# DocuFlow LaTeX Class

**Version:** 1.0 | 09/25 |
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
- **Automatic front matter:** title page, abstract, and summary  
- **Figure and table management** with automatic lists  
- **Acronym support** via the `acronym` package  
- **Customizable title page background image**  
- **Modern hyperlink handling** with colored URLs  

---

## Installation

1. Copy `docuflow.cls` to your project folder or LaTeX package directory.  
2. Load the class in your document:

```latex
\documentclass[ngerman,article,apa7,12pt]{docuflow}
