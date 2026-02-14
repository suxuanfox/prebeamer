% mybeamer.cls - 完整最终版
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mybeamer}[2026/02/13 Final Custom Beamer Template]
% -------------------
% 加载 Beamer（默认顶对齐）
% -------------------
\PassOptionsToClass{t}{beamer}
\LoadClass{beamer}



% -------------------
% 字体与编码
% -------------------
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

% 主数学字体
\setmathfont{Libertinus Math}[Scale=MatchUppercase]

\newfontfamily{\arrowfont}{DejaVu Sans}

\setbeamertemplate{headline}{%
    \begin{tikzpicture}[remember picture, overlay]
        
        % 当前节第一页箭头
        \node[anchor=north west] at ([xshift=2pt,yshift=-6pt]current page.north west) {
            \hyperlinksectionstart{\arrowfont{\textcolor{gray!5}{\Large \char"21BB}}}
        };
        
        % 当前节最后一页箭头
        \node[anchor=north west] at ([xshift=2pt,yshift=-26pt]current page.north west) {
            \hyperlinksectionend{\arrowfont{\textcolor{gray!5}{\Large \rotatebox[origin=c]{180}{\char"21BB}}}}
        };
    \end{tikzpicture}%
}








% ---------- 英文字体 ----------
\setsansfont{Source Sans 3}%西文无衬线字体
\setmainfont{Source Serif 4}%西文衬线字体 

% ========== 中文字体设置 ==========
%中文无衬线 思源黑体加粗
\setCJKsansfont[
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

% 中文衬线 思源宋体
\setCJKmainfont[
    BoldFont=Source Han Serif SC Bold,
    ItalicFont=KaiTi
]{Source Han Serif SC}

% 中文无衬线 思源黑体
\setCJKfamilyfont{hei}[
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

% 定理标题黑体（不自动加粗）
\setCJKfamilyfont{hei2}{Source Han Sans SC}

% 仿宋（系统字体）
\setCJKfamilyfont{fangsong}[
    BoldFont=*,
    ItalicFont=KaiTi,
    BoldItalicFont=*
]{FangSong}

\setCJKfamilyfont{kai}[
    BoldFont=*,
    ItalicFont=KaiTi,
    BoldItalicFont=*
]{KaiTi}
\setCJKfamilyfont{song}{Source Han Serif SC}
\setCJKmonofont{Source Han Mono SC}
% section标题字体
\setCJKfamilyfont{sectionfont}[
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

% proof环境字体
\setCJKfamilyfont{pffont}[
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

% 强调字体
\setCJKfamilyfont{emfont}[
    BoldFont=Source Han Sans SC Bold
]{Source Han Sans SC}

\defaultfontfeatures{Ligatures=TeX}

% ========== 字体命令 ==========
\newcommand\kaishu{\CJKfamily{kai}}
\newcommand\songti{\CJKfamily{song}}
\newcommand\heiti{\CJKfamily{hei}}
\newcommand\thmheiti{\CJKfamily{hei2}}
\newcommand\fangsong{\CJKfamily{fangsong}}
\setbeamerfont{normal text}{family=\songti}
% 正文默认字体：宋体
\setbeamerfont{normal text}{family=\songti}

% 强制 Beamer 使用衬线作为正文默认族
\renewcommand{\familydefault}{\rmdefault}

% 强调命令
\renewcommand{\em}{\bfseries\CJKfamily{emfont}}

\setbeamerfont{title}{size=\Huge,series=\bfseries}
\setbeamerfont{frametitle}{size=\Large,series=\bfseries,family=\heiti}
\setbeamerfont{author}{size=\large}
\setbeamerfont{date}{size=\normalsize}
\setbeamerfont{block title}{series=\bfseries}


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
\setbeamercolor{structure}{fg=primary}
\setbeamercolor{itemize item}{fg=primary}
\setbeamercolor{block title}{bg=lightgray,fg=black}
\setbeamercolor{block body}{bg=white,fg=black}
\setbeamerfont{section in toc}{series=\bfseries,family=\songti}
\usetikzlibrary{shapes.symbols}	% 稍后定义 hint 环境所需

%\setlength{\parindent}{2em}	% 设置适合于汉语排版的段落缩进

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

% 脚注格式定制
\renewcommand{\thefootnote}{\arabic{footnote})}

% 汉化 figure 和 table 环境
	\renewcommand{\figurename}{图}
	\renewcommand{\tablename}{表}

% 设置习题环境, 置于每章最后: 不用 \section* 以免格式混淆
	\newenvironment{Exercises}{%
		\markright{习题}
		\addcontentsline{toc}{section}{习题}
		\vspace{1em}\begin{center}
			\Large\CJKfamily{sectionfont} 习题
		\end{center}\vspace{0.7em}
		\begin{small}\begin{enumerate}[\bfseries 1.] %
			}{	% 结束
		\end{enumerate}\end{small}
	}


% 习题提示 (定义为环境, 穿插文中)
\newenvironment{hint}{%
	\ifvmode % 用 \ifvmode 测试: 如果提示另起新段, 则不加空白.
		\ignorespaces	% 消除横向空白, 优于 \unskip
	\else
		\quad	% 否则加入空白.
	\fi
	\begin{tikzpicture}[baseline=(H.base), every node/.style={signal, draw, very thin, signal to=east, signal from=nowhere, signal pointer angle=120, inner sep=2pt}]
		\node[anchor=mid west] (H) at (0,0) {\heiti\footnotesize 提示};
	\end{tikzpicture}
}{}

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

% -------------------------------
% 定理前后间距和分隔符（替代 ntheorem）
% -------------------------------
% 定理前后间距
\setlength{\abovedisplayskip}{2mm}  % 定理前间距
\setlength{\belowdisplayskip}{2mm}  % 定理后间距

% 标题与正文间分隔符（空格）
\setbeamertemplate{theorem begin}{
  \usebeamerfont{theorem title}%
  \inserttheoremname~\inserttheoremnumber\ \par% 空格作为分隔符
  \usebeamerfont{theorem body}%
}
\setbeamertemplate{theorem end}{\par\vspace{2mm}} % 定理结束后空白




\setbeamerfont{theorem title}{series=\bfseries,family=\thmheiti}
\setbeamerfont{theorem body}{family=\fangsong}
\newtheorem{mytheorem}{定理}[section] % 按section编号
		\newtheorem{mycorollary}[mytheorem]{推论}
		\newtheorem{mylemma}[mytheorem]{引理}
		\newtheorem{proposition}[mytheorem]{命题}
		\newtheorem{mydefinition}[mytheorem]{定义}
		\newtheorem{definition-theorem}[mytheorem]{定义--定理}
		\newtheorem{definition-proposition}[mytheorem]{定义--命题}
		\newtheorem{hypothesis}[mytheorem]{假设}
		\newtheorem{conjecture}[mytheorem]{猜想}


		\newtheorem{myexample}[mytheorem]{例}
		\newtheorem{remark}[mytheorem]{注记}
		\newtheorem{convention}[mytheorem]{约定}
		\newtheorem{exercise}[mytheorem]{练习}		% 穿插于文中的习题

%以下采用保存原设定->修改字体->恢复原设定的方式, 定义了几个特例环境
\makeatletter
% ---------- 宋体环境 ----------
% hypothesis
\let\oldhypothesis\hypothesis
\let\endoldhypothesis\endhypothesis
\renewenvironment{hypothesis}[1][]{
    \setbeamerfont{theorem body}{family=\songti,series=\mdseries}% 宋体
    \oldhypothesis[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldhypothesis
}

% conjecture
\let\oldconjecture\conjecture
\let\endoldconjecture\endconjecture
\renewenvironment{conjecture}[1][]{
    \setbeamerfont{theorem body}{family=\songti,series=\mdseries}% 宋体
    \oldconjecture[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldconjecture
}

% exercise
\let\oldexercise\exercise
\let\endoldexercise\endexercise
\renewenvironment{exercise}[1][]{
    \setbeamerfont{theorem body}{family=\songti,series=\mdseries}% 宋体
    \oldexercise[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldexercise
}

% ---------- 楷体环境 ----------
% myexample
\let\oldmyexample\myexample
\let\endoldmyexample\endmyexample
\renewenvironment{myexample}[1][]{
    \setbeamerfont{theorem body}{family=\CJKfamily{kai}}% 楷体
    \oldmyexample[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldmyexample
}

% remark
\let\oldremark\remark
\let\endoldremark\endremark
\renewenvironment{remark}[1][]{
    \setbeamerfont{theorem body}{family=\CJKfamily{kai}}% 楷体
    \oldremark[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldremark
}

% convention
\let\oldconvention\convention
\let\endoldconvention\endconvention
\renewenvironment{convention}[1][]{
    \setbeamerfont{theorem body}{family=\CJKfamily{kai}}% 楷体
    \oldconvention[#1]
}{
    \setbeamerfont{theorem body}{family=\fangsong}% 恢复仿宋
    \endoldconvention
}
\makeatother





% -------------------------------
% proof 环境定制（方角 + block 色调）
% -------------------------------
\renewcommand{\proofname}{证明}

% -------------------
% myproof 专用 block 配色
% -------------------
\setbeamercolor{myproof title}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,240}
}

\setbeamercolor{myproof body}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,250}
}

% -------------------
% myproof 专用 block 配色
% -------------------
\setbeamercolor{myproof title}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,240}
}

\setbeamercolor{myproof body}{
    fg=black,
    bg={rgb,255:red,255;green,250;blue,250}
}

% myproof 标题字体（黑体）
\setbeamerfont{myproof title}{
    family=\sffamily,
    series=\bfseries
}

% -------------------
% myproof 环境定义
% -------------------
\newenvironment{myproof}[1][证明]{%
    \begingroup

    % 颜色
    \setbeamercolor{block title}{use=myproof title,
        fg=myproof title.fg,
        bg=myproof title.bg}
    \setbeamercolor{block body}{use=myproof body,
        fg=myproof body.fg,
        bg=myproof body.bg}

    % 字体
    \setbeamerfont{block title}{series=\bfseries,family=\thmheiti}

    % 开始 block
    \begin{block}{#1}
    \songti
}{%
    \hfill$\square$
    \end{block}
    \endgroup
}








% -------------------
% 标题页模板
% -------------------
\defbeamertemplate*{title page}{custom}[1][]
{
  \vbox{}
  \vfill
  \centering
    {\usebeamerfont{title}\usebeamercolor[fg]{title}\inserttitle\par}
    \vskip1em
    {\usebeamerfont{author}\usebeamercolor[fg]{author}\insertauthor\par}
    \vskip1em
    {\usebeamerfont{institute}\usebeamercolor[fg]{institute}\insertinstitute\par}
    \vskip1em
    {\usebeamerfont{date}\usebeamercolor[fg]{date}\insertdate\par}
  \vfill
}
\setbeamertemplate{title page}[custom]






% -------------------
% 自动目录页
% -------------------
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

% -------------------------------
% Beamer Frame Title Box 定义
% -------------------------------
\newlength{\BoxTtlwidth}

% -------------------------------
% 有编号章节盒子（适合章节风格页）
% -------------------------------
\newcommand{\MakeFrameTitleBox}[2]{%
    % #1 = 标题编号，#2 = 标题文字
    \sbox0{\sffamily\CJKfamily{hei2}\bfseries\Huge #1}%
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
        \sffamily\CJKfamily{hei2}\bfseries\Huge #1
        \tcblower
        #2
    \end{tcolorbox}%
}

% -------------------------------
% 无编号章节盒子（适合普通 frametitle）
% -------------------------------
\newcommand{\MakeFrameTitleBoxSingle}[1]{%
    \sbox0{\sffamily\CJKfamily{hei2}\bfseries\Huge #1}%
    \setlength{\BoxTtlwidth}{\wd0}%
    \begin{tcolorbox}[
        enhanced jigsaw,
        skin=bicolor,
        frame hidden,
        boxrule=0mm,
        sharp corners=all,
        width=\textwidth,
        top=1mm, bottom=1mm,
        colupper=white,
        colback=gray!80,
        colbacklower=gray!10,
        halign=center,
        valign=center
    ]
        \sffamily\CJKfamily{hei2}\bfseries\Huge #1
    \end{tcolorbox}%
}

% -------------------------------
% 将 Beamer frametitle 重定义为我们的盒子
% -------------------------------
\setbeamertemplate{frametitle}{%
    \vspace{1mm}%
    \MakeFrameTitleBox{\thesection}{\insertframetitle}%
}



% -------------------
% block 样式（自定义方角颜色）
% -------------------
\definecolor{blocktitlebg}{RGB}{255,250,240}
\definecolor{blockbodybg}{RGB}{255,250,250}

\setbeamercolor{block title}{bg=blocktitlebg, fg=black}
\setbeamercolor{block body}{bg=blockbodybg, fg=black}

% 使用方角
\setbeamertemplate{blocks}[default]  % 默认方角


% -------------------
% itemize 样式
% -------------------
\setbeamertemplate{itemize item}{\color{primary}$\bullet$}
\setbeamertemplate{itemize subitem}{\color{primary}$\circ$}

% -------------------------------
% 右侧导航条
% -------------------------------
\usetikzlibrary{calc}

\newlength{\NavBarWidth}   \setlength{\NavBarWidth}{3pt}   % 轨道宽度
\newlength{\NavBarMargin}  \setlength{\NavBarMargin}{0.2mm}   % 右侧边距
\newlength{\sliderheight}  % 滑块高度

\setbeamertemplate{sidebar right}{%
    \vfill
    \begin{tikzpicture}[remember picture, overlay]
        \pgfmathsetmacro{\totalpages}{\inserttotalframenumber}
        \pgfmathsetmacro{\currentpage}{\insertframenumber}
        \ifnum\totalpages>0
            % 滑块高度
            \setlength{\sliderheight}{\paperheight/\totalpages}

            % 轨道
            \fill[lightgray] 
                ([xshift=-\NavBarMargin-\NavBarWidth]current page.north east) rectangle
                ([xshift=-\NavBarMargin]current page.south east);

            % 计算滑块坐标（长度）
            \pgfmathsetlengthmacro{\yTop}{(\currentpage-1)*\sliderheight}
            \pgfmathsetlengthmacro{\yBottom}{\currentpage*\sliderheight}

            % 绘制滑块（浅灰色 + 圆角）
            \fill[gray!50, rounded corners=1.5pt] 
                ([xshift=-\NavBarMargin-\NavBarWidth,yshift=-\yTop]current page.north east) rectangle
                ([xshift=-\NavBarMargin,yshift=-\yBottom]current page.north east);

            \node[anchor=east] at 
                ([xshift=-\NavBarMargin-\NavBarWidth-1mm,yshift=-\yTop-\sliderheight/2]current page.north east)
                {\tiny \currentpage\\[-0.2em]\tiny /\tiny\\[-0.2em]\tiny \totalpages};
        \fi
    \end{tikzpicture}%
    \vfill
}

% -------------------
% cls 文件结束
% -------------------