%mainfile diss

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tucsdissertation}[2006/10/17 TUCS Dissertation.]

\RequirePackage{ifthen,epsfig,graphics}
\RequirePackage[usenames]{color}

% For the cover pages.
\newboolean{cover}
\DeclareOption{cover}{\setboolean{cover}{true}}

%%%%%%%%%%%%%%%%%%%%
% A TUCS Dissertation is a kind of book.
%%%%%%%%%%%%%%%%%%%%

\newcommand{\@defaultfontsize}{11pt}

\DeclareOption*{
  \ifthenelse{\equal{\CurrentOption}{12pt}}{\renewcommand{\@defaultfontsize}{12pt}}
  {
    \ifthenelse{\equal{\CurrentOption}{11pt}}{}
    {
      \ifthenelse{\equal{\CurrentOption}{10pt}}{\renewcommand{\@defaultfontsize}{10pt}}
      {
        \PassOptionsToClass{\CurrentOption}{book}
      }
    }
  } 
}



\ProcessOptions

\PassOptionsToClass{\@defaultfontsize}{book}

\LoadClass[twoside,a4paper,titlepage]{book}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TUCS Dissertations have some fields that books dont, namly:
%   tucsnumber: The number of the TUCS Dissertations
%   isbn:	The ISBN number of the Publication.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@tucsnumber}{?}
\newcommand{\tucsnumber}[1]{\renewcommand{\@tucsnumber}{#1}}

\newcommand{\@isbn}{?}
\newcommand{\isbn}[1]{\renewcommand{\@isbn}{#1}}
\newcommand{\theisbn}{\@isbn}



%%%%%%%%%%%%%%%%%%%%
%   isss:	The ISSN number of the series.
%%%%%%%%%%%%%%%%%%%%
\newcommand{\@issn}{1239-1883}
\newcommand{\theissn}{\@issn}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The date in a TUCS Dissertations is just given as: Month YEAR.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\today}{%
  \ifcase\month\or
    January\or
    February\or
    March\or
    April\or
    May\or
    June\or
    July\or
    August\or
    September\or
    October\or
    November\or
    December\fi\
  \number\year
}

% Set up the margins _after_ the paper size has been selected by whatever
% style files the user has.

\AtBeginDocument{
  \setlength{\textwidth}{125mm}
  \setlength{\textheight}{205mm}
  \setlength{\evensidemargin}{15.6mm}
  \setlength{\oddsidemargin}{15.6mm}
}

%%%%%%%%%%%%%%
% Fonts used on cover pages
%%%%%%%%%%%%%%

% The font for the title on the front cover
\newcommand{\title@font}{%
  \fontseries{m}%
  \fontshape{n}%
  \fontsize{24.88}{28}   %%%{17.28}{20} 
  \selectfont
  \sffamily}

% The font for the author{s} on the front cover
\newcommand{\author@font}{%
  \fontseries{m}%
  \fontshape{n}%
  \fontsize{24.88}{28}   %%%{17.28}{20} 
  \selectfont
  \sffamily}

\newcommand{\TUCSDiss@font}{%
  \fontseries{m}%
  \fontshape{n}%
  \fontsize{23}{24} 
  \selectfont
  \sffamily}

% The font for the univerities on the back cover
\newcommand{\backhead@font}{%
  \fontseries{m}%
  \fontshape{n}%
  \fontsize{11}{12}%
  \selectfont
  \sffamily}

% The font for the departments on the back cover
\newcommand{\back@font}{%
  \fontseries{m}  
  \fontshape{n}%
  \fontsize{11}{12}%
  \selectfont
  \sffamily}


% The font for the dissertation number and date on the front cover
\newcommand{\tinfo@font}{%
  \fontseries{m} 
  \fontshape{n}%
  \fontsize{17.28}{18}%
  \selectfont
  \sffamily}

% The font for ISBN and ISSN on back cover
\newcommand{\tinfotwo@font}{%
  \fontseries{m}  
  \fontshape{n}%
  \fontsize{12}{14}%
  \selectfont
  \sffamily}

% This is the command that actually makes the title.
\renewcommand{\maketitle}{
  \pagestyle{empty}
   \clearpage
  \begin{figure}[t]
    \begin{picture}(100,100)(0,0)
      \put(-77,-345){\includegraphics{TUCS_etukansi.eps}} 
      \put(-32,120){\parbox[t]{15cm}{\color{white}\author@font\@author}}
      %\put(-32,10){\parbox[t]{15cm}{\color{white}\title@font\@title}}
      \put(-32,10){\parbox[t]{15cm}{\color{white}\Huge\sf\@title}}
      \put(71,-270){\begin{tabular}{p{41ex}}\TUCSDiss@font{\color{Gray}TUCS Dissertations} \\ 
       \begin{center}\tinfo@font{\color{Gray}No \@tucsnumber, \@date} \end{center}
        \end{tabular}} 
      %\put(95,-270){\author@font{\color{Gray}TUCS Dissertations}} 
      %\put(135,-290){\tinfo@font{\color{Gray}No \@tucsnumber, \@date}} 
    \end{picture}\\\mbox{}
  \end{figure}
  \cleardoublepage
  
  \pagestyle{plain}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TUCS Dissertations have a page at the end with some logos on it.	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndDocument{%
  \clearpage
  \pagestyle{empty}%
  %%%\enlargethispage*{2cm}
  \ifthenelse{\boolean{cover}}{%
    \cleardoublepage
    \hbox{}
    \clearpage
  }{%
    \ifthenelse{\isodd{\value{page}}}{%
      \hbox{}
      \clearpage
    }{}%
  }%

    \begin{picture}(0,0)(0,0)
      %\put(-110,-650){\includegraphics{TUCS_takakansi.eps}} %%% (-80,-600)
      \put(-87,-514){\includegraphics{Diss_backcoverA4.eps}} %%% (-80,-600)
      %\put(-60,-180){\parbox[t]{15cm}{\color{white}\tinfo@font{Joukahaisenkatu 3$\,$-$\,$5, 20520 Turku, Finland \ $|$\  www.tucs.fi}}}
    \end{picture}\\ 
%
  \begin{picture}(100,535)(0,0) 
   %\put(-5,-25){\tinfotwo@font a ISBN \@isbn a}
   \put(-5,-30){\tinfotwo@font ISBN \@isbn }
   \put(-5,-45){\tinfotwo@font ISSN \@issn }

\end{picture}

}

