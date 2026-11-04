%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my-resume.cls - Enhanced & Bulletproof Layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-resume}[2026/11/04 my-resume v3.0, enhanced layout resume class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifthen}
\newboolean{@singleordouble}
\setboolean{@singleordouble}{true}
\DeclareOption{singlesided}{\setboolean{@singleordouble}{true}}
\DeclareOption{doublesided}{\setboolean{@singleordouble}{false}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions*

\ifthenelse{\boolean{@singleordouble}}
    {\PassOptionsToClass{oneside}{scrartcl}}
    {\PassOptionsToClass{twoside}{scrartcl}}

\LoadClass{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REQUIRED PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\usetikzlibrary{arrows,shapes,calc}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{academicons}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILTER IRRELEVANT WARNINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{silence}
\WarningFilter{scrlayer-scrpage}{Very small head height detected!}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength\highlightwidth
\newlength\headerheight
\newlength\marginleft
\newlength\marginright
\newlength\margintop
\newlength\marginbottom

\setlength\highlightwidth{7.2cm}
\setlength\headerheight{3.8cm}
\setlength\marginleft{0.8cm}
\setlength\marginright{\marginleft}
\setlength\margintop{0.8cm}
\setlength\marginbottom{0.8cm}

\RequirePackage[bindingoffset=0cm,nomarginpar,noheadfoot]{geometry}
\geometry{left=\marginleft,right=\marginright,top=\margintop,bottom=\marginbottom}

\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{0F172A}   % deep luxury navy/slate
\definecolor{mediumgray}{HTML}{334155} % balanced dark slate
\definecolor{gray}{HTML}{64748B}       % muted slate
\definecolor{lightgray}{HTML}{F8FAFC}  % very soft modern slate-50

\definecolor{awesome-emerald}{HTML}{0D9488}
\definecolor{awesome-skyblue}{HTML}{0284C7}
\definecolor{awesome-red}{HTML}{E11D48}
\definecolor{awesome-darknight}{HTML}{0F172A}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORED BARS & LAYERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xpatch}
\RequirePackage{scrlayer-scrpage}

\DeclareNewPageStyleByLayers{headerhighlightmain}{%
  highlightbar.even,%
  highlightbar.odd,%
  header.bg
}
\DeclareNewPageStyleByLayers{highlightmain}{%
  highlightbar.even,%
  highlightbar.odd
}
\DeclareNewPageStyleByLayers{headermain}{%
  header.bg
}

\DeclareNewLayer[
  background,
  oddpage,
  innermargin,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.odd}

\ifthenelse{
    \boolean{@singleordouble}
}{%
    \DeclareNewLayer[
      background,
      evenpage,
      outermargin,
      width=\highlightwidth,
      contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
    ]{highlightbar.even}
}{%
    \DeclareNewLayer[
        clone=highlightbar.odd,
        evenpage,
        align=r,
        hoffset=\paperwidth
      ]{highlightbar.even}
}

\DeclareNewLayer[
  background,
  topmargin,
  addheight=\headerheight,
  contents={\color{headerbarcolor}\rule{\layerwidth}{\layerheight}}
]{header.bg}

\lehead[]{}
\cehead[]{}
\rehead[]{}
\lohead[]{}
\cohead[]{}
\rohead[]{}
\lefoot[]{}
\cefoot[]{}
\refoot[]{}
\lofoot[]{}
\cofoot[]{}
\rofoot[]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[3][]{\def\@photo{#2}\def\@photodiameter{#3}\def\@photoformat{#1}}

\newcommand{\makeheader}{%
    \noindent%
    \begin{minipage}[c][\headerheight]{\textwidth}%
        \ifdef{\@photo}{%
            \begin{minipage}[c]{\dimexpr \textwidth-3.6cm}%
                \vspace{0.2cm}%
                {\fontsize{23pt}{26pt}\selectfont\bfseries\color{headerfontcolor}\MakeUppercase{\@name}\par}%
                \vspace{0.35em}%
                {\small\bfseries\color{accent!30}\@tagline\par}%
            \end{minipage}\hfill%
            \begin{minipage}[c]{3.4cm}%
                \centering%
                \begin{tikzpicture}
                    \begin{scope}
                        \clip (0,0) circle (1.35cm);
                        \node at (0,0) {\includegraphics[width=2.7cm,height=2.7cm,keepaspectratio]{\@photo}};
                    \end{scope}
                    \draw[white, line width=2.5pt] (0,0) circle (1.35cm);
                \end{tikzpicture}%
            \end{minipage}%
        }{%
            {\fontsize{23pt}{26pt}\selectfont\bfseries\color{headerfontcolor}\MakeUppercase{\@name}\par}%
            \vspace{0.35em}%
            {\small\bfseries\color{accent!30}\@tagline\par}%
        }%
	\end{minipage}\par%
    \vspace{0.4cm}%
}

\newcommand{\emptyheader}{%
    \vspace*{0.2cm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\infofield}[2]{\mbox{\makebox[4.5mm]{\textcolor{accent}{\normalsize #1}}\hspace{0.4em}#2}\par\vspace{0.25em}}
\newcommand{\email}[1]{\infofield{\faEnvelope}{\href{mailto:#1}{\nolinkurl{#1}}}}
\newcommand{\address}[1]{\infofield{\faAt}{#1}}
\newcommand{\location}[1]{\infofield{\faMapMarker}{#1}}
\newcommand{\phone}[1]{\infofield{\faPhone}{#1}}
\newcommand{\homepage}[2]{\infofield{\faGlobe}{\href{#2}{#1}}}
\newcommand{\linkedin}[2]{\infofield{\faLinkedin}{\href{#2}{#1}}}
\newcommand{\github}[2]{\infofield{\faGithub}{\href{#2}{#1}}}
\newcommand{\credly}[2]{\infofield{\faCertificate}{\href{#2}{#1}}}

\newcommand{\highlightbar}[1]{%
    \def\@highlightbar{%
        \begin{minipage}[t]{\dimexpr \highlightwidth-\marginleft-0.2cm}%
            #1%
        \end{minipage}%
    }%
}

\newcommand{\mainbar}[1]{%
    \def\@mainbar{%
        \begin{minipage}[t]{\dimexpr \textwidth-\highlightwidth-0.3cm}%
            #1%
        \end{minipage}%
    }%
}

\newcommand{\makebody}{%
    \par\noindent%
    \ifthenelse{\boolean{@singleordouble}}%
        {%
            \@highlightbar\hfill\@mainbar%
        }{%
            \Ifthispageodd{%
                \@highlightbar\hfill\@mainbar%
            }{%
                \@mainbar\hfill\@highlightbar%
            }%
        }%
    \par%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTIONS & STYLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\section}[2][]{%
    \vspace{0.65em}%
    \ifstrequal{#1}{}{}{\large \makebox[4.5mm][c]{\textcolor{accent}{#1}}\hspace{0.25em}}%
    {\color{heading}\large\bfseries\MakeUppercase{#2}}\\[-0.8ex]%
    {\color{accent}\rule{\linewidth}{1.2pt}\par}\smallskip
}

\renewcommand{\subsection}[1]{%
    \smallskip%
    {\color{emphasis}\normalsize\bfseries{#1}\par}\smallskip
}

% Clean Executive Job / Education Command
\newcommand{\job}[4]{%
    \vspace{0.35em}%
    \noindent\parbox[b]{\dimexpr\linewidth-3.8cm}{\textbf{\large\color{heading}#3}}%
    \parbox[b]{3.8cm}{\raggedleft\footnotesize\color{accent}\faCalendar\ \mbox{#1}}\par
    \vspace{0.12em}%
    \noindent{\small\bfseries\color{mediumgray}\faBuilding\ #2}\par
    \ifstrequal{#4}{}{}{%
        \vspace{0.2em}%
        \noindent{\small\color{body}#4}\par
    }%
    \vspace{0.45em}%
}

% Clean Skill with guaranteed non-wrapping dots
\newcommand{\skill}[2]{%
    \noindent\parbox[t]{\dimexpr \linewidth-2.0cm}{\textbf{\small#1}}\hfill%
    \parbox[t]{1.9cm}{\raggedleft\footnotesize\foreach \x in {1,...,5}{%
        \space{\ifnumgreater{\x}{#2}{\color{gray!30}}{\color{accent}}\faCircle}}}\par\vspace{0.25em}
}

\newcommand{\simpleskill}[1]{%
    \textcolor{emphasis}{\small\faCheckCircle\ \textbf{#1}}\par\vspace{0.2em}%
}

\newcommand{\skillsection}[1]{%
    \vspace{0.25em}%
    \textit{\color{accent}\bfseries\small#1}\par\vspace{0.2em}
}

\newcommand{\tag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=accent!60,fill=white,rounded corners=2pt,inner xsep=0.7ex,inner ysep=0.45ex,text height=1.2ex,text depth=.2ex]{\footnotesize\color{emphasis}#1};
}

\newcommand{\badgegrid}[4]{%
    \begin{center}
    \renewcommand{\arraystretch}{1.1}
    \begin{tabular}{cc}
        \includegraphics[width=2.5cm,height=2.1cm,keepaspectratio]{#1} &
        \includegraphics[width=2.5cm,height=2.1cm,keepaspectratio]{#2} \\[0.3em]
        \includegraphics[width=2.5cm,height=2.1cm,keepaspectratio]{#3} &
        \includegraphics[width=2.5cm,height=2.1cm,keepaspectratio]{#4}
    \end{tabular}
    \end{center}
}

\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}
      \begin{scope}[rotate=\totalrot]
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 0.6ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 0.6ex) [xshift=\labelshiftdir*0.35cm,inner sep=0.6ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\scriptsize\bfseries,text=body]{\name};
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
    \end{tikzpicture}\par
    \endgroup
}

\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=1pt, parsep=0.5pt, leftmargin=1.1em}

\pagestyle{headerhighlightmain}
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=accent,
    filecolor=accent,
    urlcolor=accent,
    pdfauthor={Marcos Paulo Pereira Dias},
    pdftitle={Curriculum Vitae - Marcos Paulo Pereira Dias}
}

