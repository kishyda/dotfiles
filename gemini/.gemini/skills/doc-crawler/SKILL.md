---
name: doc-crawler
description: Crawls a documentation URL, extracts text content, and saves it to a local markdown file for analysis. Use when the user wants to "digest", "research", or ask specific questions about a set of online documentation.
---

# Doc Crawler

## Overview

This skill allows for the systematic extraction of content from a documentation website. It follows links within the same domain to build a comprehensive markdown-like file of the documentation's text content.

## Workflow

1.  **Crawl Documentation**: Run the `scripts/crawler.py` script with the target URL and an optional page limit.
    ```bash
    python3 scripts/crawler.py https://example.com/docs 20
    ```
2.  **Locate Extracted Content**: The crawler saves the combined content into the `crawled_docs/` directory in the current working directory.
3.  **Analyze and Answer**:
    - For small documentation sets: Read the entire generated `.md` file to understand the context.
    - For large documentation sets: Use `grep_search` on the `crawled_docs/` directory to find specific keywords or sections related to the user's question.
4.  **Reference Sources**: When answering, mention the source URLs extracted in the markdown file (e.g., `--- SOURCE: https://... ---`).

## Resources

### scripts/

- `crawler.py`: A Python script that recursively crawls a URL (within the same path prefix) and extracts text into a single markdown file.

## Troubleshooting

- **Rate Limiting**: If the crawler fails to fetch pages, wait a few minutes or reduce the `max_pages` count.
- **JavaScript Rendering**: This basic crawler does not execute JavaScript. If the documentation site is a Single Page Application (SPA), it may only capture the skeleton. In such cases, use the `web_fetch` tool for individual pages instead.
