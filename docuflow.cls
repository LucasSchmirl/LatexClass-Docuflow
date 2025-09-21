% DocuFlow Class v1.0
% Created by Lucas Schmirl, 2025. For non-commercial use only.
% Licensed under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{docuflow}[2025/09/21 v0.5 DocuFlow class with full features]

\RequirePackage{etoolbox}

% ---------------- Option defaults ----------------
\newcommand\DF@language{english}
\newcommand\DF@doctype{article}
\newcommand\DF@citation{apa7}
\newcommand\DF@passoptions{}

% ---------------- Declare recognized options ----------------
% Language
\DeclareOption{english}{\renewcommand\DF@language{english}}
\DeclareOption{ngerman}{\renewcommand\DF@language{ngerman}}

% Document type
\DeclareOption{article}{\renewcommand\DF@doctype{article}}
\DeclareOption{book}{\renewcommand\DF@doctype{book}}
\DeclareOption{report}{\renewcommand\DF@doctype{report}}

% Citation type
\DeclareOption{apa7}{\renewcommand\DF@citation{apa7}}
\DeclareOption{harvard}{\renewcommand\DF@citation{harvard}}
\DeclareOption{IEEE}{\renewcommand\DF@citation{IEEE}}

% Forward unknown options to base class
\DeclareOption*{%
  \ifx\DF@passoptions\@empty
    \edef\DF@passoptions{\CurrentOption}%
  \else
    \edef\DF@passoptions{\DF@passoptions,\CurrentOption}%
  \fi
}

% ---------------- Process options ----------------
\ProcessOptions\relax
% Document class with passed options
\PassOptionsToClass{\DF@passoptions}{\DF@doctype}
\LoadClass{\DF@doctype}

% ---------------- Required packages ----------------
\RequirePackage{graphicx}   % images
\RequirePackage{acronym}    % acronym lists
\RequirePackage{xcolor}     % colors
\RequirePackage{amsmath}    % math support
\RequirePackage{csquotes}   % smart quotes
\RequirePackage{tikz}       % titlepage background
\RequirePackage{enumitem}   % custom enumerate


% ---------------- Hyperref setup ----------------
\definecolor{FAVblue}{RGB}{0,142,251} % default URL color
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black, citecolor=black, filecolor=black,
  urlcolor=FAVblue
}
\urlstyle{sf}

% ---------------- Bibliography handling ----------------
\newcommand\DF@bibstyle{apa}
\ifdefstring{\DF@citation}{harvard}{\renewcommand\DF@bibstyle{authoryear}}{}
\ifdefstring{\DF@citation}{IEEE}{\renewcommand\DF@bibstyle{ieee}}{}
\ifdefstring{\DF@citation}{apa7}{\renewcommand\DF@bibstyle{apa}}{}

\RequirePackage[backend=biber,style=\DF@bibstyle]{biblatex}
\addbibresource{bibliography.bib}

% ---------------- Titlepage background ----------------
\newcommand\DF@bgimage{}
\newcommand\settitlebackground[1]{\gdef\DF@bgimage{#1}}

\newcommand\DF@titlecontent{}
\newcommand\setTitlePageContent[1]{\gdef\DF@titlecontent{#1}}

\renewcommand\maketitle{%
  \begin{titlepage}
    \ifx\DF@bgimage\@empty\else
      \begin{tikzpicture}[remember picture,overlay]
        \node[opacity=1.0,inner sep=0pt] at (current page.center)
          {\includegraphics[width=\paperwidth,height=\paperheight]{\DF@bgimage}};
      \end{tikzpicture}%
    \fi
    \DF@titlecontent
  \end{titlepage}%
}

% ---- Frontmatter helper (Abstract + Kurzfassung) sprachenabhängig ---------
\newcommand{\DFmakefrontmatter}{%
  \maketitle
  % Contents
  \tableofcontents
  \clearpage
  % abstract.tex einbinden, falls vorhanden (bei english und ngerman)
  \IfFileExists{abstract.tex}{\input{abstract.tex}}{}%
  % Kurzfassung einfügen nur wenn Sprache 'ngerman' ist und die Datei existiert
  \ifdefstring{\DF@language}{ngerman}{%
    \IfFileExists{kurzfassung.tex}{\clearpage\input{kurzfassung.tex}}{}%
  }{}%
  \clearpage
}


% Helper for acronyms section
\newcommand{\DFautoSection}[1]{%
  \ifstrequal{\DF@doctype}{book}{\chapter*{#1}}{%
    \ifstrequal{\DF@doctype}{report}{\chapter*{#1}}{%
      \section*{#1}%
    }%
  }%
}


% Sprachpaket laden
\RequirePackage[\DF@language]{babel}
%\typeout{DF@language is \DF@language}


% ---------------- Acronym heading name ----------------
\providecommand{\acronymname}{Default (not set)}
\ifdefstring{\DF@language}{ngerman}{%
  \renewcommand{\acronymname}{Abkürzungsverzeichnis}%
}{%
  \renewcommand{\acronymname}{Acronyms}%
}


% Notes
% Use \newcommand when defining something for the first time.
% Use \renewcommand only if you know it’s already defined (like \maketitle).
% Use \providecommand for “default only if not already defined” (like \acronymname).