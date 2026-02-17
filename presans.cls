\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presans}[2026/02/15 Custom Beamer Class]

%------------------------------------------------
% 选项控制
%------------------------------------------------
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=mybeamer,
    prefix=mybeamer@
}

\DeclareBoolOption[false]{chinese}
\ProcessKeyvalOptions*

%------------------------------------------------
% 基础类
%------------------------------------------------
\PassOptionsToClass{t}{beamer}
\LoadClass{beamer}

\RequirePackage{iftex}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{xcolor}
\RequirePackage{calc} % 用于计算宽度
\RequirePackage{zhnumber}				% 中文数字转换
% 支持直接引入 PDF 页面
\RequirePackage{pdfpages}
% 加入字串处理功能
\RequirePackage{xstring}
\RequirePackage[many]{tcolorbox}		% 制作方框

\RequirePackage{zhlineskip}	% 设定适于中文排版的行距
% 使用 biblatex + biber 制作书目
\RequirePackage[
	backend=biber,
	sorting=nyt,
	hyperref=auto,
	backref=true,
	backrefstyle=three]
	{biblatex}

% 要求载入 TikZ
\RequirePackage{tikz}
% 载入 paralist, 要求标签向右对齐.
\RequirePackage[neveradjust, neverdecrease]{paralist}
\RequirePackage{unicode-math}
\RequirePackage{graphicx}
\ifPDFTeX
    \PackageError{mybeamer}{This class requires XeLaTeX or LuaLaTeX}{}
\fi

\RequirePackage{fontspec}
\RequirePackage{xeCJK}

\setmathfont{Fira Math}%无衬线数学公式，如有需要，将其注释掉即可
\setbeamertemplate{navigation symbols}{}
\newfontfamily{\arrowfont}{DejaVu Sans}

\setbeamertemplate{headline}{%
    \begin{tikzpicture}[remember picture, overlay]
        
        % 当前节第一页箭头
        \node[anchor=north west] at ([xshift=2pt,yshift=-20pt]current page.north west) {
            \hyperlinksectionstart{\arrowfont{\textcolor{gray!5}{\Large \char"21BB}}}
        };
        
        % 当前节最后一页箭头
        \node[anchor=north west] at ([xshift=2pt,yshift=-40pt]current page.north west) {
            \hyperlinksectionend{\arrowfont{\textcolor{gray!5}{\Large \rotatebox[origin=c]{180}{\char"21BB}}}}
        };
    \end{tikzpicture}%
}
% 英文字体
\setsansfont{Source Sans 3}%无衬线字体
%\newfontfamily{\thmnumberfont}{Source Serif 4} % 衬线字体

%中文字体
\setCJKsansfont[
    ItalicFont=*,
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}
\setCJKmainfont[
    ItalicFont=*,
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

\setCJKfamilyfont{heiti}{Source Han Sans SC}


% -------------------
% 颜色设置
% -------------------
\definecolor{primary}{RGB}{138,43,226} % violet
\definecolor{darkgray}{RGB}{51,51,51}
\definecolor{lightgray}{RGB}{230,230,230}
\definecolor{black}{RGB}{0,0,0}
\definecolor{white}{RGB}{255,255,255}

\setbeamercolor{title}{fg=black}
\setbeamercolor{frametitle}{bg=lightgray,fg=darkgray}
\setbeamercolor{structure}{fg=black}
\setbeamerfont{structure}{series=\bfseries}
\setbeamercolor{itemize item}{fg=violet}
\setbeamercolor{block title}{fg=black}
\usetikzlibrary{shapes.symbols}	% 稍后定义 hint 环境所需
\newenvironment{hint}{%
	\ifvmode % 用 \ifvmode 测试: 如果提示另起新段, 则不加空白.
		\ignorespaces	% 消除横向空白, 优于 \unskip
	\else
		\quad	% 否则加入空白.
	\fi
	\begin{tikzpicture}[baseline=(H.base), every node/.style={signal, draw, very thin, signal to=east, signal from=nowhere, signal pointer angle=120, inner sep=2pt}]
		\node[anchor=mid west] (H) at (0,0) {\CJKfamily{heiti}\footnotesize 提示};
	\end{tikzpicture}
}{}

\RequirePackage{hyperref}

% 设置超链接颜色
\hypersetup{
    colorlinks=true,        % 链接文字显示为彩色，而不是带框
    linkcolor=violet,       % 目录、章节等内部链接颜色
    urlcolor=violet,        % URL 链接颜色
    citecolor=violet        % 参考文献引用颜色
}

\DeclareFieldFormat{postnote}{#1}	% 功能是印出 \cite[postnote]{Book}
\DefineBibliographyStrings{english}{%
			in = {刊于},
			editor = {主编},
			byeditor = {编者为},
			backrefpage = {引用于 p.\!},
			backrefpages = {引用于 pp.\!},
	}
% biblatex 部分第二步: 要求在 doi 和 URL 并存时移除 URL. 仅适用于 Biblatex + Biber. 源码取自 https://tex.stackexchange.com/questions/119136/biblatex-convert-doi-url-into-doi-field  原文如下.
% The actual value inside \regexp can be adjusted.
% In the first step we create a doi field for each entry where the url field matches the regexp, and the novel field has the value of the url field. In the second step we remove the doi "namespace".
% In the second \map sequence the url and urldate fields are cleared if a doi field is present, to mimic the behavior in the first part of the original question. 
\DeclareSourcemap{
	\maps[datatype=bibtex]{
		\map{
			\step[ % copies url to doi field if it starts with http://dx.doi.org/
			fieldsource=url,
			match=\regexp{http://dx.doi.org/(.+)},
			fieldtarget=doi,
			]
			\step[ % removes http://dx.doi.org/ string from doi field
			fieldsource=doi,
			match=\regexp{http://dx.doi.org/(.+)},
			replace=\regexp{$1}
			]
		}
		\map{ % removes url + urldate field from all entries that have a doi field
			\step[fieldsource=doi, final]
			\step[fieldset=url, null]
			\step[fieldset=urldate, null]
		}
	}
}
%保持定理环境title和body连续
\setbeamertemplate{blocks}[rounded][shadow=false]

\setbeamercolor{block title}{
    fg=black,
    bg=white
}
\setbeamercolor{block body}{
    fg=black,
    bg=white
}

\usepackage{calc}
\usepackage{xcolor}
\usepackage{fontspec}

\newfontfamily{\thmnumberfont}{Source Serif 4} % 编号字体
\newlength{\tmpwidth}   % 存放下划线宽度

% 共享计数器
\newcounter{mytheorem}[section]
\renewcommand{\themytheorem}{\thesection.\arabic{mytheorem}}

% 标题与正文字体
\newcommand{\thmtitlefont}{\CJKfamily{heiti}\bfseries\large} % 定理黑体加粗
\newcommand{\thmbodyfont}{\normalsize\mdseries}                % 正文

% 定理环境模板（整个标题包含可选名称都有下划线）
\newenvironment{mytheorembase}[2][]{
    \vspace{2mm} % 定理前间距
    \refstepcounter{mytheorem}

    % 编号字体：灰色，衬线，不加粗，比标题大
    \newcommand{\thmnumbertext}{{\color{gray}\thmnumberfont\mdseries\LARGE\themytheorem}}

    % 构造完整标题字符串（包括可选名称）
    \ifx\relax#1\relax
        \def\thmtmp{#2~\thmnumbertext}
    \else
        \def\thmtmp{#2~\thmnumbertext~(#1)}
    \fi

    % 测量标题总宽度
    \settowidth{\tmpwidth}{\thmtitlefont\thmtmp}

    % 输出标题
    {\thmtitlefont \thmtmp\par}

    % 输出下划线
    \vskip-2ex%下划线和标题距离
    \textcolor{lightgray}{\rule{\tmpwidth}{0.6pt}}\par
    \vskip0.5ex % 下划线与正文间距

    % 正文开始
    \thmbodyfont
}{
    \par
    \vspace{2mm} % 定理后间距
}






%----------------------------------------
% 各种定理环境
%----------------------------------------
\newenvironment{mytheorem}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 定理\else Theorem\fi}}{\end{mytheorembase}}
\newenvironment{mylemma}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 引理\else Lemma\fi}}{\end{mytheorembase}}
\newenvironment{mycorollary}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 推论\else Corollary\fi}}{\end{mytheorembase}}
\newenvironment{myproposition}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 命题\else Proposition\fi}}{\end{mytheorembase}}
\newenvironment{mydefinition}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 定义\else Definition\fi}}{\end{mytheorembase}}
\newenvironment{myexample}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 例\else Example\fi}}{\end{mytheorembase}}
\newenvironment{myremark}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 注记\else Remark\fi}}{\end{mytheorembase}}
\newenvironment{myconjecture}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 猜想\else Conjecture\fi}}{\end{mytheorembase}}
\newenvironment{myconvention}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 约定\else Convention\fi}}{\end{mytheorembase}}
\newenvironment{myexercise}[1][]{\begin{mytheorembase}[#1]{\ifmybeamer@chinese 练习\else Exercise\fi}}{\end{mytheorembase}}



% frametitle 字体
\setbeamerfont{frametitle}{
    size=\large,
    series=\bfseries
}

% frametitle 颜色
\setbeamercolor{frametitle}{
    fg=white,
    bg=gray!70
}
\setbeamercolor{myproof title}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,240}
}

\setbeamercolor{myproof body}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,250}
}
% 使用方角
\setbeamertemplate{blocks}[default]  % 默认方角
% myproof 标题字体（黑体）
\setbeamerfont{myproof title}{
    family=\sffamily,
    series=\bfseries
}

% -------------------
% myproof 环境定义
% -------------------
\newenvironment{myproof}[1][\ifmybeamer@chinese 证明梗概\else Sketch of Proof\fi]{%
    \begingroup

    % 颜色
    \setbeamercolor{block title}{use=myproof title,
        fg=myproof title.fg,
        bg=myproof title.bg}
    \setbeamercolor{block body}{use=myproof body,
        fg=myproof body.fg,
        bg=myproof body.bg}

    % 字体
    \setbeamerfont{block title}{series=\bfseries}

    % 开始 block
    \begin{block}{#1}
}{%
    \hfill$\square$
    \end{block}
    \endgroup
}
% 自定义 frametitle 模板
% -------------------------------
\newlength{\BoxTtlwidth}
\newcommand{\MakeFrameTitleBox}[2]{%
    % #1 = 标题编号，#2 = 标题文字
    \sbox0{\sffamily\bfseries\Huge #1}%
    \setlength{\BoxTtlwidth}{\wd0}%
    \begin{tcolorbox}[
        enhanced jigsaw,
        skin=bicolor,
        frame hidden,
        boxrule=0mm,
        sharp corners=all,
        width=\textwidth,
        top=1mm, bottom=1mm,
        lefthand width=\BoxTtlwidth,
        colupper=white,
        colback=gray!80,
        colbacklower=gray!10,
        sidebyside,
        sidebyside align=center,
        halign=center,
        valign=center
    ]
        \sffamily\bfseries\Huge #1
        \tcblower
        #2
    \end{tcolorbox}%
}

% -------------------------------
% 将 Beamer frametitle 重定义为我们的盒子
% -------------------------------
\setbeamertemplate{frametitle}{%
    \vspace{1mm}%
    \MakeFrameTitleBox{\thesection}{\insertframetitle}%
}

%自定义标题页模板
\defbeamertemplate*{title page}{custom}[1][]
{
  \vbox{}
  \vfill
  \centering
    {\usebeamerfont{title}\bfseries\LARGE\usebeamercolor[black]{title}\inserttitle\par}
    \vskip1em
    % Subtitle (可选)
    \ifx\insertsubtitle\@empty
      % 空，不显示
    \else
      {\usebeamerfont{subtitle}\bfseries\Large\usebeamercolor[darkgray!80]{subtitle}\insertsubtitle\par}
      \vskip1em
    \fi
    {\usebeamerfont{author}\usebeamercolor[darkgray!60]{author}\insertauthor\par}
    \vskip1em
    {\usebeamerfont{institute}\usebeamercolor[darkgray!60]{institute}\insertinstitute\par}
    \vskip1em
    {\usebeamerfont{date}\usebeamercolor[darkgray!60]{date}\insertdate\par}
  \vfill
}
\setbeamertemplate{title page}[custom]





\AtBeginSection[]{
  \begin{frame}
    \frametitle{目录}
    \tableofcontents[currentsection]
  \end{frame}
}

\newenvironment{nonumberframe}[1][]{
  \numberedframefalse
  \begin{frame}[#1]
}{
  \end{frame}
  \numberedframetrue % 恢复默认
}

\setbeamertemplate{footline}{%
  \begin{tikzpicture}[remember picture, overlay]
    % -----------------------------
    % 参数
    % -----------------------------
    \def\barheight{2mm}           % 进度条高度，可修改
    \def\halfwidth{0.5\paperwidth} % 左右总宽度

    % 当前页比例
    \pgfmathsetmacro{\ratio}{\insertframenumber/\inserttotalframenumber}

    % -----------------------------
    % 1️⃣ 背景浅灰色（顶部）
    % -----------------------------
    \fill [lightgray] 
      (\paperwidth/2-\halfwidth, \paperheight-\barheight) rectangle 
      (\paperwidth/2+\halfwidth, \paperheight);

    % -----------------------------
    % 2️⃣ 已展示部分深灰色（顶部）
    % -----------------------------
    \fill [gray] 
      (\paperwidth/2-\halfwidth*\ratio, \paperheight-\barheight) rectangle 
      (\paperwidth/2+\halfwidth*\ratio, \paperheight);

    % -----------------------------
    % 3️⃣ 中间页码文字（动态居中）
    % -----------------------------
    \node[white,font=\bfseries,anchor=center] 
      at (\paperwidth/2, \paperheight-\barheight/2) {\insertframenumber/\inserttotalframenumber};
  \end{tikzpicture}%
}

\setbeamertemplate{itemize item}{\color{primary}$\bullet$}
\setbeamertemplate{itemize subitem}{\color{primary}$\circ$}

\newtcolorbox{tips}{
		breakable,
		enhanced,
		width = \textwidth,
		colback = white, colbacktitle = white,
		colframe = gray!50, boxrule=0.2mm,
		coltitle = black,
		fonttitle = \sffamily,
		attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
		boxed title style = {boxrule=0pt, colframe=white},
		before skip = 0.5cm,
		top = 3mm,
		bottom = 3mm,
		title={阅读提示}
	}

