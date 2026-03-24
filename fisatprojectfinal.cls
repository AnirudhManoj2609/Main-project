  %% fisatproject.cls
  %% Copyright 2020 Reshmi R
  %
  % This program may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either version 1.2
  % of this license or (at your option) any later version.
  % The latest version of this license is in
  %   http://www.latex-project.org/lppl.txt
  % and version 1.2 or later is part of all distributions of LaTeX 
  % version 1999/12/01 or later.
  %
  % This program consists of the file fisatproject.cls

\ProvidesClass{mins}[1/1/2020]
\NeedsTeXFormat{LaTeX2e}

%\DeclareOption*{\InputIfFileExists{\CurrentOption.min}{}{
%\PassOptionsToClass{\CurrentOption}{report}}}

\PassOptionsToClass{notitlepage}{report}

\ProcessOptions \relax

\LoadClass[a4paper,12pt]{report}
%[left=.5in,right=.5in,top=1in,bottom=1in]
\RequirePackage[top=.8in,bottom=.7in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{url,fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{listings}
\RequirePackage[toc,page]{appendix}


\titleformat{\chapter}[display]
  {\normalfont\Large\bfseries\filcenter}{\chaptertitlename\ \thechapter}{20pt}{\Large}
\titlespacing*{\chapter}
  {0pt}{30pt}{20pt}

\def\title#1{\gdef\@title{#1}\gdef\stored@title{#1}}
\def\author#1{\gdef\@author{#1}\gdef\stored@author{#1}}
\def\regno#1{\gdef\@regno{#1}\gdef\stored@regno{#1}}
\def\team#1{\gdef\@team{#1}\gdef\stored@team{#1}}
\def\guide#1{\gdef\@guide{#1}\gdef\stored@guide{#1}}



\pagenumbering{gobble}

\def\@maketitle{%
  %\vskip 2em%
\pagestyle{empty}
  \vspace{2cm}
  \begin{center}%

    {\LARGE \@title \par}%
    \vfill
\vskip 1.5em%
\textit{Phase II project report submitted in partial fulfilment of the requirements for\\[.2cm]
	the award of the degree of}\\[1.5cm]
	{\Large \bf \itshape{{Bachelor of Technology}}}\\[.5cm]
\textit{in}\\[.5cm]
{\Large \bf \itshape{{Computer Science \& Design}}}\\[1.5cm]
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      Submitted by\\[.2cm]
      \begin{tabular}[t]{c}%
        \@team
      \end{tabular}\par}%
    \vskip 1em%
   % {\large \@date}%
  \thispagestyle{empty}
  \par
  \vfill

  \includegraphics[scale=.3]{fisat}\\[.5cm]
  \large \bfseries{Federal Institute of Science And Technology (FISAT)$^{{\mbox{\textregistered}}}$}\\
\small \bfseries{Angamaly, Ernakulam}\\[.5cm]
\small {\textit{Affiliated to}}\\[.5cm]
\large \bfseries{APJ Abdul Kalam Technological University}\\
\small \bfseries{CET Campus, Thiruvananthapuram}\\
\small \bfseries{April 2026}\\
\end{center}
  }


\newcommand{\makecert}{
\newpage
\thispagestyle{plain}
\vspace{3cm}
\begin{center}
{\large FEDERAL INSTITUTE OF SCIENCE AND TECHNOLOGY (FISAT)}\\
Mookkannoor(P.O), Angamaly-683577
\end{center}
\begin{center}
\includegraphics[scale=.3]{fisat.eps}\\
\vspace{2cm}
\textbf{CERTIFICATE}
\end{center}
\vspace{1.5cm}\doublespacing{
This is to certify that the project phase II report for the project entitled ``\textbf{\stored@title}'' is a bonafide report of the project presented during VIII$^{th}$ semester (CXD416 - Project Phase II) by \textbf{\stored@author(\stored@regno)}, in partial fulfilment of the requirements for the award of the degree of Bachelor of Technology (B.Tech) in Computer Science \& Design during the academic year 2025-26.\\[3cm]}

\hfill \textbf{Dr. Paul P Mathai}\\
Project Coordinator \hfill Project Guide \hfill Head of the Department

\vspace{1cm}
%\textbf{Place}:\\
%\textbf{Date}:
\vfill
%External Examiner \hfill Internal Examiner
}

\pagestyle{fancy}
\fancyhf{}
\lhead{\stored@title}
\lfoot{ Computer Science \& Engineering | FISAT}
\rfoot{\thepage}
\renewcommand{\footrulewidth}{0.4pt}
