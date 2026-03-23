---
name: beamer-educator
description: Use this skill when the user asks to generate LaTeX Beamer slides, presentation decks, or lecture materials. It ensures the agent separates speaker notes from slide content and applies strict pedagogical formatting.
metadata:
  author: Gemini 3.1 Pro
  version: "1.0"
  domain: education
---

# LaTeX Beamer Educator

## When to use this skill

Use this skill whenever the user needs to create, format, or refactor a presentation using LaTeX Beamer, especially for academic or university-level teaching contexts.

## How to structure pedagogical slides

1. **The 6x6 Rule**: Limit slides to a maximum of 6 bullet points and roughly 6 words per line. Use keywords, not full sentences on the slide itself.
2. **Dual-Layer Information**:
   - Place the core visual anchor (definitions, key lists, diagrams) inside the `\begin{frame}` ... `\end{frame}` block.
   - Place the actual script, philosophical context, or verbal explanations inside the `\note{...}` command. The teacher will read this.
3. **Logical Flow**: Always include a `\titlepage` slide, an Introduction/Hook frame, the Core Content frames, and a Summary/Homework frame.

## How to format layouts and visuals

- **Columns**: Use the `columns` environment to split text and visual placeholders (e.g., 60% text / 40% image) to avoid text walls.
- **Placeholders**: Use `\includegraphics[width=\textwidth]{example-image}` for missing visuals. Add a LaTeX comment above it suggesting exactly what kind of image the teacher should insert (e.g., `% Suggestion: Insert a diagram of the Curry-Howard correspondence here`).
- **Pacing**: Use the `\pause` command judiciously to reveal complex lists step-by-step, preventing cognitive overload.

## Technical LaTeX constraints

- **Preamble**: Always include a robust preamble with `utf8` input encoding, font encoding, and language support (e.g., `\usepackage[french]{babel}`).
- **Themes**: Default to clean, modern academic themes (e.g., `\usetheme{Boadilla}` or `\usetheme{Madrid}`) unless the user specifies otherwise.
- **Notes Configuration**: Always include `\setbeameroption{show notes on second screen=right}` in the preamble so the teacher can view their script while projecting.
- **Escaping**: Carefully escape special LaTeX characters (`&`, `%`, `$`, `#`, `_`, `{`, `}`, `~`, `^`, `\`).

## Example output

```latex
\documentclass[aspectratio=169]{beamer}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}
\usepackage{graphicx}
\usepackage{pgfpages}

\usetheme{Boadilla}
\setbeameroption{show notes on second screen=right}

\title{Introduction to Logic}
\author{Professor Name}
\date{\today}

\begin{document}

\begin{frame}
    \titlepage
    \note{Welcome everyone. Today we are shifting from abstract theory to mechanical practice...}
\end{frame}

\begin{frame}{The Core Concept}
    \begin{columns}
        \begin{column}{0.6\textwidth}
            \textbf{Three Pillars:}
            \begin{itemize}
                \item Syntax
                \pause
                \item Semantics
                \pause
                \item Pragmatics
            \end{itemize}
        \end{column}
        \begin{column}{0.4\textwidth}
            % Suggestion: Image of a triangle connecting the three concepts
            \includegraphics[width=\textwidth]{example-image}
        \end{column}
    \end{columns}
    \note{Let's start with Syntax. Notice how it relates to the rules of the system...}
\end{frame}

\end{document}
```
