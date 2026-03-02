---
name: resume-tailoring
description: Researches job roles, conducts experience discovery, and generates tailored resumes (MD, DOCX) from a local resume library. Use when the user provides a job description and wants to optimize their resume for a specific application.
---

# Resume Tailoring Skill

## Overview

Generates high-quality, tailored resumes optimized for specific job descriptions while maintaining factual integrity. It surfaces undocumented experiences through conversational discovery and manages a "resume library" of your past experiences.

**Core Principle:** Truth-preserving optimization - maximize fit while maintaining factual integrity. Never fabricate experience, but intelligently reframe and emphasize relevant aspects.

## When to Use

- User provides a job description and wants a tailored resume.
- User has multiple existing resumes in markdown format.
- User needs help surfacing and articulating undocumented experiences.
- User wants to batch-apply to multiple jobs (Multi-job mode).

## Quick Start

**Required from user:**
1. Job description (text or URL)
2. Resume library location (defaults to `resumes/` in current directory)

**Workflow:**
1. **Initialize Library**: Scans `resumes/` for markdown files to build an experience database.
2. **Research Role**: Analyzes the JD and researches the company to build a "success profile".
3. **Template Generation**: Proposes role consolidations and title reframing for user approval.
4. **Experience Discovery**: (Optional) Conversational session to fill gaps and surface new skills.
5. **Content Matching**: Ranks and selects bullets from the library with transparent confidence scores.
6. **Generation**: Creates tailored MD and DOCX files, plus a detailed generation report.
7. **Library Update**: Offers to save the new resume and discovered experiences to the library.

## Detailed Workflows

For in-depth procedures, refer to the following:

- **Research & JD Analysis**: See [research-prompts.md](references/research-prompts.md) for how to benchmark roles and company culture.
- **Content Matching & Reframing**: See [matching-strategies.md](references/matching-strategies.md) for scoring algorithms and truth-preserving reframing rules.
- **Experience Discovery**: See [branching-questions.md](references/branching-questions.md) for conversational patterns to surface hidden skills.
- **Multi-Job Workflow**: See [multi-job-workflow.md](references/multi-job-workflow.md) for batch processing multiple applications efficiently.

## Core Rules

1. **Never fabricate experience**: If a gap exists, surface it clearly. Use discovery to find real experience, or acknowledge the gap.
2. **User Checkpoints**: Always pause for approval on the Success Profile, Template/Consolidation, and final Content Mapping.
3. **Truthful Reframing**: Adjust terminology to match industry standards or target role context ONLY if it accurately describes the underlying work.
