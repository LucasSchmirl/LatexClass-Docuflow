# DocuFlow LaTeX Class

**Version:** 1.2 | 09/25 |
**Author:** Lucas Schmirl  
**License:** [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) (Non-commercial use only)

---

## Overview

**DocuFlow** is a versatile LaTeX class designed for academic papers, reports, and books. It provides flexible options for language, document type, and citation style, along with convenient features for title pages, abstracts, summaries, acronym lists, and more.

---

## Key Features

- **Languages:** `english`, `ngerman`  
- **Document types:** `article`, `report`, `book`  
- **Citation styles:** `apa7`, `harvard`, `IEEE`  
- **Customizable title page background image**  
- **Automatic front matter:** title page, abstract, and summary using variables
- **Figure and table management** with automatic lists  
- **Acronym support** via the `acronym` package  
- **Modern hyperlink handling** with colored URLs  

---

## Usage (Class)

Copy the wole folder containing `docuflow.cls`, `bibliography.bib` and the additional `.tex` files (tutorial, snippets, font-demos...) to your project folder or LaTeX package directory. Then compile the project and kick what you dont need.

## Installation (LaTeX)

To install `texLive` on windows follow this [Tutorial](https://mathjiajia.github.io/vscode-and-latex/), for Linux or Mac check out this [Link](https://www.tug.org/texlive/). 

Depending on the project, you either want to compile with pdflatex or lualatex (compile-engine), for this purpose I use the following inside my VSCode-`settings.json` to compile my LaTeX documents:

```json
// Latex Settings
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.autoBuild.run" : "onSave",

    // Tools
    "latex-workshop.latex.tools": [
        {
         "name": "pdflatex",
         "command": "pdflatex",
         "args": [
          "-shell-escape",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
          "-outdir=%OUTDIR%",
          "%DOC%"
         ],
         "env": {}
        },
        {
         "name": "lualatex",
         "command": "lualatex",
         "args": [
          "-shell-escape",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
          "-outdir=%OUTDIR%",
          "%DOC%"
         ],
         "env": {}
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOCFILE%"
            ]
        },
       ],


       // Recipes
       "latex-workshop.latex.recipes": [
        {
         "name": "pdflatex", //"pdflatex ➞ biber ➞ pdflatex`×2",
         "tools": [
          "pdflatex",
          "biber",
          "pdflatex",
          "pdflatex",
         ]
        },
        {
         "name": "lualatex", //"lualatex ➞ biber ➞ lualatex`×2",
         "tools": [
          "lualatex",
          "biber",
          "lualatex",
          "lualatex",
         ]
        }
    ],
```