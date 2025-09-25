% DocuFlow Class v1.2
% Created by Lucas Schmirl, 2025. For non-commercial use only.
% Licensed under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{docuflow}[2025/09/23 v1.1 DocuFlow class with full features]
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

\RequirePackage{iftex}          % check for which engine is used
\ifluatex
    \RequirePackage{fontspec}   % font selection (XeLaTeX, LuaLaTeX only)
\fi

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

% ---------------- Titlepage ---------------- 
% Titlepage background
\newcommand\DF@bgimage{}
\newcommand\settitlebackground[1]{\gdef\DF@bgimage{#1}}

% Titlepage content
\newcommand\DF@titlecontent{}
\newcommand\setTitlePageContent[1]{\gdef\DF@titlecontent{#1}}

% Redefine maketitle to use custom titlepage
\renewcommand\maketitle{%
\begin{titlepage}
  \ifx\DF@bgimage\@empty\else
  \begin{tikzpicture}[remember picture,overlay]
    \node[opacity=1.0,inner sep=0pt] at (current page.center)
    {\includegraphics[width=\paperwidth,height=\paperheight]{\DF@bgimage}};
  \end{tikzpicture}%
  \fi
  \DF@titlecontent%
\end{titlepage}%
}

% ---------------- Helpers ---------------- 
% Helper for Frontmatter (Abstract + Kurzfassung) sprachenabhängig 
\newcommand{\DFmakefrontmatter}{%
  \maketitle
  % abstract.tex einbinden, falls vorhanden (bei english und ngerman)
  \IfFileExists{abstract.tex}{\input{abstract.tex}}{}%
  % Kurzfassung einfügen nur wenn Sprache 'ngerman' ist und die Datei existiert
  \ifdefstring{\DF@language}{ngerman}{%
    \IfFileExists{kurzfassung.tex}{\clearpage\input{kurzfassung.tex}}{}%
  }{}%
  \clearpage

  % Contents
  \tableofcontents
  \clearpage
}

% Helper for abstract sections
\newcommand{\DFabstractSection}[1]{%
  \ifstrequal{\DF@doctype}{book}{\chapter*{#1}}{%
    \ifstrequal{\DF@doctype}{report}{\chapter*{#1}}{%
      \section*{#1}%
    }%
  }%
}

% Helper for normal sections
\newcommand{\DFautoSection}[1]{%
  \ifstrequal{\DF@doctype}{book}{\chapter{#1}}{%
    \ifstrequal{\DF@doctype}{report}{\chapter{#1}}{%
      \section{#1}%
    }%
  }%
}

% Helper for abstract keywords
\newcommand{\keywords}[1]{
  \vfill
  \par
  \noindent\textbf{Keywords:} #1
}

% Helper for Kurzfassung Schlagworte
\newcommand{\schlagworte}[1]{
  \vfill
  \par
  \noindent\textbf{Schlagworte:} #1
}

% Font switcher macro
\newcommand{\fontX}[2]{
  {
    \setmainfont{#1} #2
  }
}

\newcommand{\DFShowFontDemo}{%
  \ifluatex
    % lualatex font Demo
    \input{luaLatexFontDemo.tex}
  \else
      % pdflatex font Demo
      \input{pdfLatexFontDemo.tex}
  \fi
}

% Definition Code-Listings Formatierung:
\usepackage[final]{listings}
\lstset{captionpos=b,               % caption position bottom
numberbychapter=false,              % no chapter numbering
caption=\lstname,                   % caption is filename
frame=single,                       % single frame around code
numbers=left,                       % line numbers on left
stepnumber=1,                       % line number step
numbersep=2pt,                      % distance line numbers to code
xleftmargin=15pt,                   % left margin for code
framexleftmargin=15pt,              % left margin for frame
numberstyle=\tiny,                  % line number style
tabsize=3,                          % tab size
columns=fixed,                      % fixed column width
basicstyle={\fontfamily{pcr}\selectfont\footnotesize},        % font style
keywordstyle=\bfseries,                                       % keyword style
commentstyle={\color[gray]{0.33}\itshape},                    % comment style
stringstyle=\color[gray]{0.25},                               % string literal style
breaklines, breakatwhitespace, breakautoindent}               % line breaking
\lstloadlanguages{[ANSI]C, C++, [gnu]make, gnuplot, Matlab}   % load languages


%---------------- Sprachpaket und Funktionen ---------------- 
% Sprachpaket laden
\RequirePackage[\DF@language]{babel}
%\typeout{DF@language is \DF@language}  % for debugging

% language based heading names
\providecommand{\acronymname}{Default (not set)}
\providecommand{\bibname}{Default (not set)}

\ifdefstring{\DF@language}{ngerman}{%
  %\renewcommand{\bibname}{Literaturverzeichnis} % not working due to babel from hell
  \renewcommand{\listfigurename}{Abbildungsverzeichnis}%
  \renewcommand{\listtablename}{Tabellenverzeichnis}%
  \renewcommand{\lstlistlistingname}{Quellcodeverzeichnis}%
  \renewcommand{\acronymname}{Abkürzungsverzeichnis}%
  \renewcommand{\appendixname}{Anhang}%
}{%
  %\renewcommand{\bibname}{Bibliography} % not working due to babel from hell
  \renewcommand{\listfigurename}{List of Figures}%
  \renewcommand{\listtablename}{List of Tables}%
  \renewcommand{\lstlistlistingname}{List of Code}%
  \renewcommand{\acronymname}{List of Abbreviations}%
  \renewcommand{\appendixname}{Appendix}%
}

% Notes
% Use \newcommand when defining something for the first time.
% Use \renewcommand only if you know it’s already defined (like \maketitle).
% Use \providecommand for “default only if not already defined” (like \acronymname).