import urllib.request
import urllib.parse
from html.parser import HTMLParser
import sys
import os
import re

class DocParser(HTMLParser):
    def __init__(self, base_url):
        super().__init__()
        self.base_url = base_url
        self.links = set()
        self.content = []
        self.current_tag = None
        self.skip_tags = {'script', 'style', 'nav', 'footer', 'header'}

    def handle_starttag(self, tag, attrs):
        self.current_tag = tag
        if tag == 'a':
            for name, value in attrs:
                if name == 'href':
                    url = urllib.parse.urljoin(self.base_url, value)
                    # Stay within the same domain and path
                    if url.startswith(self.base_url):
                        # Remove fragment
                        url = url.split('#')[0]
                        # Remove trailing slash for consistency
                        url = url.rstrip('/')
                        self.links.add(url)

    def handle_endtag(self, tag):
        self.current_tag = None

    def handle_data(self, data):
        # Only extract text if it's not in a skip tag
        if self.current_tag not in self.skip_tags:
            text = data.strip()
            if text:
                self.content.append(text)

def crawl(start_url, max_pages=10):
    visited = set()
    to_visit = {start_url.rstrip('/')}
    all_content = []

    print(f"Starting crawl of {start_url} (limit: {max_pages} pages)")

    while to_visit and len(visited) < max_pages:
        url = list(to_visit)[0]
        to_visit.remove(url)
        
        if url in visited:
            continue
        
        try:
            print(f"Fetching: {url}")
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=10) as response:
                content_type = response.getheader('Content-Type', '')
                if 'text/html' not in content_type:
                    print(f"Skipping non-HTML page: {content_type}")
                    continue
                html = response.read().decode('utf-8', errors='ignore')
                
            parser = DocParser(start_url)
            parser.feed(html)
            
            visited.add(url)
            all_content.append(f"--- SOURCE: {url} ---\n")
            all_content.append("\n".join(parser.content))
            all_content.append("\n\n")
            
            # Add new links that haven't been visited
            new_links = {l for l in parser.links if l not in visited}
            to_visit.update(new_links)
            
        except Exception as e:
            print(f"Failed to fetch {url}: {e}")

    return "\n".join(all_content), len(visited)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 crawler.py <url> [max_pages]")
        sys.exit(1)

    url = sys.argv[1]
    max_pages = int(sys.argv[2]) if len(sys.argv) > 2 else 10
    
    content, count = crawl(url, max_pages)
    
    # Save to a temporary file in the skill's references directory if it's during install?
    # Actually, the user wants it in context. 
    # I'll save to a file in the current working directory under a known folder.
    
    output_dir = "crawled_docs"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # Clean up filename
    safe_name = re.sub(r'https?://', '', url)
    safe_name = re.sub(r'\W+', '_', safe_name)
    filepath = os.path.join(output_dir, f"{safe_name}.md")
    
    with open(filepath, "w") as f:
        f.write(content)
    
    print(f"\nSuccessfully crawled {count} pages.")
    print(f"Content saved to: {filepath}")
