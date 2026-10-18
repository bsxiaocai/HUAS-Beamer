# 从零开始：LaTeX → Beamer → HUAS-Beamer 模板完整教程

> **本教程写给谁**：完全没接触过 LaTeX 的同学。不管你是要做毕业答辩、开题报告、
> 课程汇报还是学术会议展示，跟着本教程从零走一遍，就能独立做出自己的幻灯片。
>
> 本教程已按 2026-10-18 的仓库源码核对；中英文四版均使用 XeLaTeX，
> 完整构建优先用 latexmk 自动处理参考文献和多轮编译。
>
> **本教程的分工**：
> - 本文件 = **教材**：从零讲清 LaTeX 与 Beamer，再落到 HUAS-Beamer 模板的编辑与使用；
> - [模板使用与自定义说明.md](模板使用与自定义说明.md) = **手册**：模板全部可调参数的速查表（本教程第 17 章会带你用它）；
> - [../README.md](../README.md) = **门面**：项目简介、特性与快速开始。
>
> **学习路线**：
>
> | 阶段 | 章节 | 学完你能做什么 |
> | --- | --- | --- |
> | ① LaTeX 入门 | 第 1–6 章 | 看懂任何 `.tex` 文件，会写普通文稿 |
> | ② Beamer 上手 | 第 7–10 章 | 会写幻灯片：分页、分栏、分步显示 |
> | ③ 模板实战 | 第 11–20 章 | 独立完成一套湖文风格的答辩 PPT |
> | ④ 速查 | 附录 A–D | 随用随查 |

---

# 第一部分　LaTeX 入门

## 第 1 章　认识 LaTeX

### 1.1 LaTeX 是什么

LaTeX（读作「拉泰赫」）是一套**基于纯文本的排版系统**。你用记事本一样的方式写
`.tex` 源文件，再由编译器把它排成高质量的 PDF。它擅长的领域：

- 数学公式（全世界论文的事实标准）；
- 学术论文、学位、书籍排版；
- **Beamer 幻灯片**（本项目就是）。

### 1.2 和 Word / PPT 有什么不同

| | Word / PPT | LaTeX |
| --- | --- | --- |
| 操作方式 | 鼠标点样式 | 写命令，样式由模板控制 |
| 公式 | 公式编辑器，慢且易走样 | 源码级美观，输入快 |
| 样式一致性 | 手工刷格式，容易乱 | 内容与样式分离，改主题全篇生效 |
| 版本管理 | 二进制，难 diff | 纯文本，天然适配 Git |
| 上手难度 | 低 | 前 2 小时有门槛，之后效率反超 |

**结论**：公式多、要求排版统一、要长期维护的内容 → LaTeX 更省心。

### 1.3 三个核心概念（先记住，后面反复出现）

1. **引擎（compiler）**：把 `.tex` 变 PDF 的程序。本项目用 **XeLaTeX**（支持中文与系统字体）；
2. **宏包（package）**：别人写好的扩展，`\usepackage{...}` 加载，比如 `graphicx` 提供插图；
3. **文档类（documentclass）**：决定「这是论文还是幻灯片」。写论文用 `article`，
   写幻灯片用 `beamer`。

---

## 第 2 章　安装环境

一套 LaTeX 环境 = **发行版（编译器）+ 编辑器**。在线使用则都不用装。

### 2.1 发行版（必装其一）

| 系统 | 推荐 | 说明 |
| --- | --- | --- |
| Windows | [TeX Live](https://tug.org/texlive/)（可选 full 完整安装） | 可覆盖本模板使用的宏包；本模板开发基于 TeX Live |
| Windows（轻量） | [MiKTeX](https://miktex.org/) | 小安装包，缺宏包时自动下载 |
| macOS | [MacTeX](https://tug.org/mactex/) | 相当于 Mac 版 TeX Live |
| Linux | `sudo apt install texlive-full`（Debian/Ubuntu） | 发行版仓库直接装 |

### 2.2 编辑器（必装其一）

| 编辑器 | 适合 | 要点 |
| --- | --- | --- |
| [TeXstudio](https://www.texstudio.org/) | 大多数人 | 开箱即用；菜单「选项 → 设置 TeXstudio → 命令」可确认 XeLaTeX |
| VS Code + LaTeX Workshop | 已用 VS Code | 装扩展后 `Ctrl+Alt+B` 编译，`Ctrl+Alt+V` 看 PDF |
| Overleaf（在线） | 不想装软件 | 见 §2.4 |

### 2.3 验证安装

打开终端（PowerShell / cmd）执行：

```bash
xelatex --version
bibtex --version
latexmk --version
```

三条命令分别验证引擎、参考文献工具和自动构建工具能否被终端找到。
当前四版源码已在 Windows / TeX Live 2026 下验证；版本号能打印并不代表宏包、字体或编辑器配置都已就绪，
还需实际编译模板。`pdflatex --version` 可验证另一个引擎，但本模板不使用它。

### 2.4 免安装方案：Overleaf

1. 打开 [overleaf.com](https://www.overleaf.com) 注册登录；
2. `New Project → Upload Project`，把 `template/` 目录打包为 zip 上传；
3. 左上角 `Menu → Compiler` 选 **XeLaTeX**，点 `Recompile`。

> Overleaf 的好处是零配置、可多人协作；缺点是离线不可用、大项目编译慢。

### 2.5 VS Code 的高亮、构建与黄色提示

在 VS Code 中打开项目文件夹，安装并启用 LaTeX Workshop。
`.tex` 的语言模式应为 LaTeX、`.sty` 为 LaTeX package；语法高亮取决于语言模式和颜色主题，
与 TeX Live 引擎是否可用无直接关系。可选择 Dark+ 主题。

自动处理参考文献的完整配置见[项目主页的 VS Code 配置](../README.md#vs-code-配置与排错)。
项目 `.vscode/` 已被 Git 忽略，重新克隆不会自动带上本机配置，全局个人设置也不会随仓库同步。

黄色提示要查看「问题」面板中的来源和说明：ChkTeX 的排版建议不等于编译错误，
引用未解析、字体替代和缺字则需要检查构建日志。若安装了多个 LaTeX 扩展，
避免重复检查；`mathematic.vscode-latex` 的检查开关为 `latex.linter.enabled`。
重装 TeX Live 或修改 PATH 后，应完整重启 VS Code，让扩展进程读取新环境。

---

## 第 3 章　第一个 LaTeX 文档

### 3.1 hello, world

新建 `hello.tex`，写入：

```latex
\documentclass{article}      % 文档类：普通文章

\title{我的第一篇 LaTeX}
\author{张三}

\begin{document}
\maketitle                   % 生成标题区

\section{你好}
Hello, world! 这是我的第一个 \LaTeX{} 文档。

\end{document}
```

编译：

```bash
xelatex hello.tex
```

同目录生成 `hello.pdf`——恭喜，环境通了。

### 3.2 逐行理解

| 行 | 含义 |
| --- | --- |
| `\documentclass{article}` | 声明文档类，必须是第一句 |
| `\title{...}` `\author{...}` | 导言区里的「元信息」，供 `\maketitle` 使用 |
| `\begin{document}` | 正文开始；到 `\end{document}` 结束 |
| `\maketitle` | 按导言区信息生成标题 |
| `\section{你好}` | 一级标题，自动编号 |
| `\LaTeX{}` | 输出「LaTeX」标志；`{}` 防止吞掉后面的空格 |

### 3.3 文档的三段式骨架

```latex
\documentclass{...}     % ① 文档类
% ===== 导言区 =====
\usepackage{...}        % ② 加载宏包、全局设置
...
\begin{document}        % ③ 正文
...
\end{document}
```

**编译后目录里会多出 `.aux`、`.log` 等文件**——它们是编译中间产物，
删了不影响源码，重编译会再生成（本项目 `.gitignore` 已自动排除它们）。

---

## 第 4 章　LaTeX 语法基础

### 4.1 命令

```latex
\命令名[可选参数]{必选参数}
```

例：`\documentclass[aspectratio=169]{beamer}` 中 `aspectratio=169` 是可选参数、
`beamer` 是必选参数。**花括号必须配对**，这是新手第一大报错来源。

### 4.2 注释

```latex
这行会排出来 % 百分号后面是注释，不会排出来
```

### 4.3 环境

```latex
\begin{环境名}
  内容……
\end{环境名}
```

`itemize`（无序列表）、`tabular`（表格）、`equation`（编号公式）都是环境。
`\begin` 和 `\end` 的名字必须一致，否则报「Extra \endgroup」之类的错。

### 4.4 特殊字符（必须转义）

| 字符 | 输入 | | 字符 | 输入 |
| --- | --- | --- | --- | --- |
| # | `\#` | | _ | `\_` |
| $ | `\$` | | { | `\{` |
| % | `\%` | | } | `\}` |
| ^ | `\textasciicircum{}` | | ~ | `\textasciitilde{}` |
| & | `\&` | | \ | `\textbackslash{}` |

> `$`、`^`、`_`、`~` 在数学里另有含义（见 §5.4），只有写正文时才需要转义。

### 4.5 换行与分段

- **空行 = 新段落**；
- 单换行只是空格；想强制换行用 `\\`；
- 连续空格、制表符都算一个空格。

### 4.6 中文怎么办

pdfLaTeX 处理中文很麻烦，**用 XeLaTeX + ctex 宏包**（本模板已内置）：

```latex
\documentclass{article}
\usepackage[UTF8]{ctex}   % 中文支持
\begin{document}
中文随便写，标点也没问题。
\end{document}
```

编译命令用 `xelatex`。**这就是本模板必须 XeLaTeX 编译的原因。**

---

## 第 5 章　常用排版元素

### 5.1 章节

```latex
\section{一级标题}
\subsection{二级标题}
\subsubsection{三级标题}
```

### 5.2 文字样式

```latex
\textbf{加粗} \textit{斜体} \underline{下划线} \emph{强调（语义斜体）}
{\small 局部小字} {\color{red} 局部红字}
```

`{...}` 包起来形成分组，样式只在组内生效。

### 5.3 列表

```latex
\begin{itemize}          % 无序
  \item 第一条
  \item 第二条
\end{itemize}

\begin{enumerate}        % 有序，自动编号
  \item 首先
  \item 其次
\end{enumerate}

\begin{description}      % 词条
  \item[导入] 教学环节说明。
\end{description}
```

### 5.4 数学公式

```latex
行内公式：$E = mc^2$，质量 $m$、光速 $c$。

编号公式：
\begin{equation}
  \bar{X} = \frac{1}{n}\sum_{i=1}^{n} x_i
  \label{eq:mean}
\end{equation}
```

常用：`\frac{分子}{分母}`、上下标 `x^2` `x_i`、`\sqrt{}`、`\sum`、`\int`、
希腊字母 `\alpha \beta \gamma`。

### 5.5 表格

```latex
\begin{tabular}{lcc}        % l=左对齐 c=居中 r=右对齐
  方法 & 数量 & 占比 \\      % & 分列，\\ 换行
  \hline
  问卷 & 320 & 40\% \\
  访谈 & 12 & 20\% \\
\end{tabular}
```

### 5.6 插图

```latex
\usepackage{graphicx}                 % 导言区加载
\includegraphics[width=0.5\textwidth]{figures/logo}
```

图片路径可写全，也可用 `\graphicspath{{figures/}}` 设默认目录（本模板即如此）。

### 5.7 交叉引用与参考文献

```latex
如式 \ref{eq:mean} 所示……           % 引用编号
前人研究表明……\cite{zhang2023}。    % 引用文献
```

文献条目写在 `reference.bib`（模板自带 5 条中性示例，条目 key 见该文件）：

```bibtex
@article{zhang2023,
  author  = {Zhang Wei and Li Ming},
  title   = {A Comparative Study of Deep Learning Methods for Tabular Data},
  journal = {Journal of Data Science and Applications},
  year    = {2023},
}
```

文末输出：

```latex
\bibliographystyle{plain}
\bibliography{reference}
```

手动构建参考文献时使用四步编译（见 §6.2），也可让 latexmk 自动完成；只运行首轮时可能显示 `[?]`。

---

## 第 6 章　编译与排错

### 6.1 编译流程

```
.tex 源码 ──xelatex──▶ PDF
   ▲                  │
   └── 读 .aux 里的编号/引用信息（第二轮编译时生效）
```

所以**编译两遍**是 LaTeX 的常态：第一遍收集信息，第二遍排对编号。

### 6.2 含参考文献的四步编译

```bash
xelatex 论文      # 1. 生成 .aux
bibtex  论文      # 2. 根据 .aux 生成 .bbl（参考文献）
xelatex 论文      # 3. 把 .bbl 排进 PDF
xelatex 论文      # 4. 修正所有交叉引用
```

### 6.3 读懂报错

1. 看终端里**第一个** `!` 开头的行，如 `! Missing $ inserted`；
2. 括号里的行号常不准，翻 `.log` 文件找 `l.42` 这样的行号最可靠；
3. 最常见的四类错：
   - `Missing }` / `Extra }` → 花括号没配对；
   - `Undefined control sequence` → 命令拼错或宏包没加载；
   - `Environment ... undefined` → `\begin`/`\end` 名字不一致；
   - `File ... not found` → 图片/文件名写错（含扩展名敏感）。

### 6.4 编译不通过时的自查清单

- [ ] 文件是否用 UTF-8 编码保存？
- [ ] 中文文档是否用 `xelatex` 而不是 `pdflatex`？
- [ ] `\begin` 与 `\end` 是否一一对应？
- [ ] 特殊字符是否转义（§4.4）？
- [ ] 报错行**之前**的一行有没有漏 `}`、`\\`、`&`？

---

# 第二部分　Beamer 幻灯片

## 第 7 章　Beamer 是什么

Beamer 是 LaTeX 的**幻灯片文档类**：frame 是组织内容的基本单位，编译产物是 PDF 幻灯片。
普通 frame 对应一页；分步显示或自动分页会让一个 frame 生成多个 PDF 页面。
它与 PPT 的本质区别同 §1.2——**写内容的不用管样式**，公式表格代码原生美观，
而 HUAS-Beamer 模板替你把「湖南文理学院风格」的样式全部做好了。

## 第 8 章　最小 Beamer 文档

```latex
\documentclass[aspectratio=169]{beamer}  % 16:9；4:3 则去掉中括号
\usepackage[fontset=fandol]{ctex}       % 此独立示例含中文，需加载中文支持

\begin{document}

\begin{frame}{第一页标题}
  这是我的第一页幻灯片。
  \begin{itemize}
    \item 要点一；
    \item 要点二。
  \end{itemize}
\end{frame}

\begin{frame}{第二页}
  普通 frame 对应一页，分步显示时可以生成多页。
\end{frame}

\end{document}
```

`xelatex` 编译这个例子可得两页幻灯片。`\begin{frame}{标题}` 开始一个内容帧，
普通内容帧对应一页，分步显示与自动分页时可能对应多页。

## 第 9 章　Beamer 核心元素

### 9.1 frame 的常用选项

```latex
\begin{frame}[fragile]{含代码的页}     % 含 lstlisting/verbatim 必须加 fragile
\begin{frame}[allowframebreaks]{参考文献} % 内容超页自动续页
\begin{frame}[plain,noframenumbering]  % 纯净页：无页眉页脚、不计页码（封面/致谢用）
```

| 选项 | 用途 |
| --- | --- |
| `fragile` | 页内有代码、verbatim 等「逐字符」内容时**必加**，否则报错 |
| `plain` | 去掉页眉页脚（封面、致谢页） |
| `noframenumbering` | 该页不计入页码 |
| `allowframebreaks` | 内容多时自动分页（参考文献页） |
| `t` | 内容顶部对齐（默认垂直居中） |

### 9.2 三种彩色块

```latex
\begin{block}{普通块标题}    正文内容 \end{block}
\begin{alertblock}{警示块}   需要注意的问题 \end{alertblock}
\begin{exampleblock}{示例块} 举例说明 \end{exampleblock}
```

### 9.3 左右双栏

```latex
\begin{columns}[T]                       % T=顶部对齐
  \begin{column}{0.48\textwidth}
    左栏内容
  \end{column}
  \begin{column}{0.48\textwidth}
    右栏内容
  \end{column}
\end{columns}
```

宽度之和别超过 1（留点间距，如 0.48 + 0.48）。

### 9.4 分步显示（演示利器）

```latex
\begin{itemize}[<+-| alert@+>]   % 逐条出现，且高亮当前条
  \item 第一步出现；
  \item 第二步出现；
  \item 第三步出现。
\end{itemize}

\only<2->{这行从第 2 页起才出现}  % 手动控制
```

`<+->` 表示「一页显示一条」；编译后 PDF 会生成多页动画效果。

### 9.5 章节与目录

```latex
\section{研究背景}      % 一章
\subsection{国内现状}   % 一节
\tableofcontents        % 目录页（可加 [hideallsubsections] 只显示章）
```

### 9.6 主题与配色

Beamer 自带大量主题：`\usetheme{Madrid}`、`\usecolortheme{seagull}`……
**但本模板不用它们**——HUAS-Beamer 通过自定义样式文件实现了自己的版式，
见第三部分。

## 第 10 章　Beamer 编译习惯

- 单文件：`xelatex 文件.tex`；
- 页面上的装饰（背景、色带）用 TikZ 的 `remember picture` 定位，
  **第一次编译位置可能偏，编译第二遍就正了**，属正常现象；
- 每次大改后编译两遍再看效果。

---

# 第三部分　HUAS-Beamer 模板的编辑与使用

## 第 11 章　认识模板包

`template/` 目录的文件分工：

| 文件 | 角色 | 你要不要动它 |
| --- | --- | --- |
| `huasbeamer.sty` | **主题样式**：颜色/封面/页脚/目录全在这 | 只在改样式时动（第 17 章） |
| `HUAS-Beamer.tex` | 中文·暖色（校徽红）演示，**兼使用范例** | **复制它开工** |
| `HUAS-Beamer-EN.tex` | 英文·暖色 | 同上 |
| `HUAS-Beamer-Blue.tex` | 中文·冷色（蓝白） | 同上 |
| `HUAS-Beamer-Blue-EN.tex` | 英文·冷色 | 同上 |
| `reference.bib` | 参考文献库 | 把你的文献条目加进去 |
| `figures/` | 校徽、校标、建筑线稿等图片素材 | 换图时动 |
| `Makefile` / `makebeamer.bat` | 一键编译四版 | 不用动 |
| `.latexmkrc` | latexmk 工程配置 | 不用动 |
| `HUAS-Beamer*.pdf` | 编译成品（四个版本） | 参考对照用 |

> `examples/`（兄弟院校模板调研）与 `research/`（校徽校旗等原始素材）仅保留在本地，
> 已被 `.gitignore` 排除，不会上传 GitHub——它们是「参考资料」，与日常编辑无关。

**四个 `.tex` 的差异只在两处**：导言区 `\usepackage` 的选项（`blue`/`en`）和内容语言。
学会编辑一个，另外三个自然会。

## 第 12 章　五分钟做出你的答辩 PPT

### 第 12.1 步骤总览

```
① 复制 HUAS-Beamer.tex → 我的答辩.tex
② 改导言区六件套（封面信息）
③ 按 章→节→页 骨架替换正文
④ xelatex 编译两遍（有文献走四步）
```

### 第 12.2 一个完整的小例子

`我的答辩.tex`（可直接复制运行）：

```latex
% !TEX program = XeLaTeX
\documentclass[aspectratio=169]{beamer}
\graphicspath{{figures/}}
\usepackage{huasbeamer}          % 加载 HUAS 主题（想换冷色加 [blue]）

%% ---------- 封面信息（★内容填写★）----------
\title[开题报告]{基于深度学习的图像分类研究}   % [页脚短标题]{封面大标题}
\subtitle{——以 ResNet 改进为例}               % 不要可删
\author[张三]{答辩人：张三}
\supervisor{指导教师：李四\quad 教授}           % 不要可删
\institute[湖南文理学院]{\small 湖南文理学院·计算机与电气工程学院}
\date{\small 2025 年 6 月}
\reportdate{2025 年 6 月 10 日}                % 固定页脚汇报时间（可选）

\begin{document}

% ---------- 封面 ----------
\begin{frame}[plain,noframenumbering]
  \titlepage
\end{frame}

% ---------- 目录 ----------
\begin{frame}{目录}
  \tocbackground                 % 目录背景线稿（可删）
  \vskip-2em
  \tableofcontents[hideallsubsections]
\end{frame}

% ---------- 正文 ----------
\section{研究背景}
\subsection{研究现状}

\begin{frame}{研究背景}
  \begin{block}{问题定义}
    图像分类是计算机视觉的基础任务……
  \end{block}
  \begin{alertblock}{现有不足}
    \begin{itemize}
      \item 深层网络梯度消失；
      \item 小样本场景泛化差。
    \end{itemize}
  \end{alertblock}
\end{frame}

\section{研究内容}

\begin{frame}{技术路线}
  \begin{itemize}[<+-| alert@+>]
    \item 改进残差结构；
    \item 引入注意力机制；
    \item 在 CIFAR-10 上验证。
  \end{itemize}
\end{frame}

% ---------- 致谢 ----------
\begin{frame}[plain,noframenumbering]
  \begin{center}
    {\Huge\bfseries 感谢聆听，敬请指正！}
  \end{center}
\end{frame}

\end{document}
```

编译：

```bash
xelatex 我的答辩.tex
xelatex 我的答辩.tex     # 第二遍，装饰位置归位
```

打开 `我的答辩.pdf`，就是一套完整的湖文风格幻灯片。

## 第 13 章　封面与页脚（对应自定义说明 §1.1）

### 13.1 六件套命令

```latex
\title[页脚短标题]{封面主标题}
\subtitle{副标题}                  % 可整行删
\author[页脚短作者]{答辩人：XXX}
\supervisor{指导教师：XXX}          % 可整行删
\institute[页脚短单位]{\small 湖南文理学院·XX学院}
\date{\small 2025 年 6 月}
\reportdate{2025 年 6 月 10 日}     % 可选：固定页脚汇报时间
```

| 命令 | 显示位置 | 说明 |
| --- | --- | --- |
| `\title[短]{全}` | 封面大标题；页脚第二行左侧 | 不写方括号页脚显示完整标题 |
| `\subtitle{...}` | 封面主标题下方 | 可删 |
| `\author[短]{全}` | 封面中央；页脚第一行左侧 | |
| `\supervisor{...}` | 封面作者下方 | 可删 |
| `\institute[短]{全}` | 封面底部；页脚第一行右侧 | |
| `\date{...}` | 封面底部单位下方 | 可写 `\today` |
| `\reportdate{...}` | 页脚汇报时间 | 默认 = 编译当天日期 |

### 13.2 页脚两行的结构

```
┌────────────────────────────────────────────┐
│ 汇报人  2025-06-10 ············· 湖南文理学院 │  ← 第一行
│ 论文题目 ···························  ◁ ▷ 3/25 │  ← 第二行
└────────────────────────────────────────────┘
```

- 第一行 = `\author` 短名 + `\reportdate`（左）· `\institute` 短名（右）；
- 第二行 = `\title` 短标题（左）· 翻页按键 + 页码（右）；
- 页码分隔符可改：`\setframeofframes{--}`（默认 `/`）；
- 不要翻页按键：加载主题时加 `[nonav]`。

## 第 14 章　正文结构：章—节—页

### 14.1 三级骨架

```latex
\section{研究背景}                    % 章
\subsection{国内研究现状}             % 小节
\begin{frame}{这一页的标题}           % 页
  正文……
\end{frame}
```

**自动机制**（HUAS-Beamer 的核心体验）：

- 每个 `\section` **之前自动插入**「渐变节页（编号+标题，整体偏上）」+「目录页」；
- 节前目录页里：**当前节及其小节高亮**，其余节灰显且不显示其小节（NJIT 规则）；
- 页脚、顶部导航条自动读取章/节名。

### 14.2 不想要自动目录页？

| 需求 | 做法 |
| --- | --- |
| 关闭节前节标题页及目录页 | `\usepackage[notoc]{huasbeamer}` |
| 小节前也出目录页 | `\usepackage[subsectiontoc]{huasbeamer}` |
| 需要时手动插目录 | 在任意 frame 内写 `\tableofcontents` |

`subsectiontoc` 独立控制小节前目录。若同时设置 `[notoc,subsectiontoc]`，
节前两页会关闭，小节前目录仍保留；关闭所有自动目录时也需移除 `subsectiontoc`。

### 14.3 总目录页的写法

```latex
\begin{frame}{目录}
  \tocbackground                 % 校门线稿背景（可删这行）
  \vskip-2em                     % ★位置★ 整体上移
  \tableofcontents[hideallsubsections]
\end{frame}
```

目录节条目是「立体圆圈 + 中文数字『一、二、三、』」（英文版自动变阿拉伯数字），
圆圈颜色与字号搜索样式文件里的 `ball color` / `section in toc`；汉字数字定义搜 `\huas@cnnum`。

## 第 15 章　主题选项（对应自定义说明 §2）

```latex
\usepackage{huasbeamer}                 % 中文·暖色（默认）
\usepackage[blue]{huasbeamer}           % 冷色蓝白（页面纯白）
\usepackage[en]{huasbeamer}             % 英文模式（不加载 ctex）
\usepackage[notoc]{huasbeamer}          % 关闭节前自动目录
\usepackage[subsectiontoc]{huasbeamer}  % 小节前也出目录
\usepackage[nonav]{huasbeamer}          % 关闭底部翻页按键
```

**选项可组合**：`\usepackage[blue,en]{huasbeamer}` = 英文冷色版。
想直接用成品：四个 `.tex` 演示文件已经分别配好四种组合。

## 第 16 章　内容元素实战

本章把 §5 的通用写法落到模板语境，给的都是**可直接粘贴**的片段。

### 16.1 插图

图片统一放 `figures/`（导言区已设 `\graphicspath{{figures/}}`），引用时不写扩展名：

```latex
\includegraphics[width=0.42\textwidth]{huas-badge}
```

模板素材一览（完整表见自定义说明 §5）：

| 素材文件 | 用途 |
| --- | --- |
| `huas-logo-nobadge.png` | 封面校标（默认），换：`\huassetlogo{文件名}` |
| `huas-badge-v2.png` | 封面左上角校徽，换：搜样式文件 `huas-badge-v2` |
| `building-library.png` | 封面背景水印，换：`\huassetbg{文件名}` |
| `building-gate.png` | 目录页背景（`\tocbackground`） |
| `building-*-white.png` | 深色背景（节页/致谢页）专用白版线稿 |

### 16.2 表格（带彩色表头）

```latex
\begin{table}
  \centering\small
  \caption{研究方法一览}\label{tab:method}
  \begin{tabular}{lll}
    \huastableheader                               % 浅红表头底色
    \huastableheaderfont 方法 & \huastableheaderfont 对象 & \huastableheaderfont 目的 \\
    \midrule
    问卷调查法 & 师生 320 份 & 把握现状 \\
    课堂观察法 & 课例 12 个 & 分析行为 \\
    \bottomrule
  \end{tabular}
\end{table}
```

`booktabs` 的三线表（`\toprule \midrule \bottomrule`）已由模板加载，直接用。

### 16.3 公式

```latex
\begin{block}{数据统计（节选）}
  \begin{equation}
    \bar{X} = \frac{1}{n}\sum_{i=1}^{n} x_i,
    \qquad
    S = \sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(x_i-\bar{X})^2}
    \label{eq:mean}
  \end{equation}
  实验前后差异采用配对 $t$ 检验\cite{li2021}。
\end{block}
```

### 16.4 代码（记得 [fragile]）

```latex
\begin{frame}[fragile]{数据处理示例}
  \begin{lstlisting}[language=Python]
import pandas as pd
data = pd.read_excel("survey.xlsx")
print(data["score"].mean())
  \end{lstlisting}
\end{frame}
```

代码样式（行号、配色、换行）在 `HUAS-Beamer*.tex` 导言区的 `\lstset{...}` 里，
颜色直接用了主题色 `huasdeep` / `huascoral` / `huasorange`。

### 16.5 参考文献

1. 文献条目写进 `reference.bib`（格式见 §5.7）；
2. 正文引用 `\cite{zhang2023}`；
3. 文末帧：

```latex
\begin{frame}[allowframebreaks]{参考文献}
  \footnotesize
  \bibliographystyle{plain}
  \bibliography{reference}
\end{frame}
```

4. **四步编译**（§6.2）。

### 16.6 致谢页（渐变背景 + 校门线稿）

```latex
\begin{frame}[plain,noframenumbering]
  \begin{tikzpicture}[remember picture,overlay]
    \shade[left color=huasdeep,right color=huasorange]
      (current page.south west) rectangle (current page.north east);
    \node[anchor=south,opacity=0.16] at ([yshift=0.35cm]current page.south) {%
      \includegraphics[width=1.04\paperwidth]{building-gate-white.png}};
  \end{tikzpicture}
  \vskip2.2cm
  \begin{center}
    {\Huge\bfseries\color{white}感谢聆听，敬请指正！}\\[1.8ex]
    {\large\color{white}Q \& A}
  \end{center}
\end{frame}
```

## 第 17 章　样式自定义导览

> 本章教你**怎么改样式**；每一项的**完整参数表**在
> [模板使用与自定义说明.md](模板使用与自定义说明.md) 对应章节，本章标注了 §号。

### 17.1 「★注释★」工作法

`huasbeamer.sty` 里每个可调点都埋了注释锚点：

```
★调色★ / ★尺寸★ / ★图片★ / ★文字★ / ★字号★ / ★行距★ / ★字体★ / ★位置★
```

**改样式 = 在编辑器里 Ctrl+F 搜索这些锚点或下文给出的命令名**，改数值，重新编译两遍。

### 17.2 颜色（自定义说明 §3）

主题色一共有七个（搜 `\definecolor`）：

| 颜色名 | 默认值 | 用途 |
| --- | --- | --- |
| `huasred` | `#CC3433` 校徽红 | 主色：列表符、块标题底、页脚第二行 |
| `huasdeep` | `#8F2420` 深红 | 页脚第一行、渐变深端、封面色带 |
| `huasorange` | `#EB3D00` 校旗橙红 | 渐变亮端、alert 块 |
| `huascoral` | `#E06742` 珊瑚 | 图注、目录小三角 |
| `huasgold` | `#F5B301` 校旗金 | 备用点缀 |
| `huascream` | `#F7F2EC` 米白 | 浅色装饰 |
| `huasbg` | `#FDFAF3` 暖米白 | **所有页面底色** |

改色示例（页面底色调更黄）：

```latex
\definecolor{huasbg}{HTML}{FAF2DE}
```

`[blue]` 选项下七个颜色整套替换为蓝白系（`huasbg` 变纯白），改色思路相同。

### 17.3 尺寸与间距（自定义说明 §4）

| 想改什么 | 搜什么 | 默认 |
| --- | --- | --- |
| 全局行距 | `行距与列表间距` | `\linespread{1.08}` |
| 列表项间距 | 同上 | `\itemsep=0.45ex` |
| 表格行高 | 同上 | `\arraystretch=1.25` |
| 封面色带高度 | `0.40cm` / `0.48cm` | 顶 0.40 + 0.08、底 0.48 |
| 封面校徽 | `huas-badge-v2` | 高 1.35cm |
| 页脚两行 | `footline` | 见 §13.2 |
| 帧标题字号 | `★字号★ 中文版帧标题` | 中文 `\Large` |
| 节页布局 | `section page` | 编号+标题（无横向导航，整体偏上） |
| 目录条目圆圈/字号 | `ball color` / `section in toc` | 圆圈内汉字数字、节 `\Large` |
| 目录背景 | `\tocbackground` | 校门线稿 |

### 17.4 图片素材（自定义说明 §5）

可直接通过命令替换封面校标与水印：

```latex
\huassetlogo{我的校标.png}     % 封面校标
\huassetbg{我的背景.png}       % 封面背景水印
```

封面左上角校徽请在 `huasbeamer.sty` 的 `title page` 中搜索 `huas-badge-v2.png` 替换；
正文校徽修改相应 `.tex` 的 `\includegraphics`。当前 `\huassetbadge` 与 `\huassetdeco`
仅保存文件名，尚未被版式读取，调用它们不会改变现有图片。

> 深色背景（渐变节页、致谢页）请用 `-white` 版线稿素材，浅色背景用原版。

### 17.5 文字（自定义说明 §6）

| 内容 | 在哪改 |
| --- | --- |
| 底部色带英文校名 | 搜 `\huas@nameen` |
| 中文校名 | 校标文字属于图片；`\huas@namecn` 目前仅为备用定义 |
| 校训（默认不显示） | 搜 `\huas@motto` |
| 致谢页文字 | `.tex` 最后一帧 |
| 目录页标题（中英自动） | 搜 `Contents` |

### 17.6 字体（自定义说明 §7）

- **西文与数字**：Times 体系（`Times New Roman` 未安装时回退 `TeX Gyre Termes`，并非逐字缺字回退），
  数学 `newtxmath`；改入口搜 `★字体★ 学术标准`；
- **中文**：使用 `ctex` 的 `fontset=none`，再显式配置 Fandol 字体；正文黑体、斜体楷体，节页标题局部宋体。
  想把正文改成宋体，应将中文分支的主字体改为
  `\setCJKmainfont{FandolSong-Regular}[BoldFont=FandolSong-Bold,ItalicFont=FandolKai-Regular]`，不要删除配置行；
- **Windows 系统字体**：需修改 `\setCJKmainfont`、`\setCJKsansfont` 等对应命令和局部字体族，
  只改 `fontset=windows` 会被后续显式配置覆盖，完整示例见[自定义说明 §7](模板使用与自定义说明.md#7-字体)；
- **英文模式**：不加载 ctex，但加载 xeCJK，并配置中文宋体、黑体和仿宋，支持中文参考文献；仍须 XeLaTeX。

### 17.7 表格辅助宏（自定义说明 §8）

`\huastableheader` = 浅红表头底色行；`\huastableheaderfont` = 表头字体（深红加粗）。
用法见 §16.2，颜色改法：搜 `\newcommand{\huastableheader}`。

## 第 18 章　编译与工程化

| 场景 | 命令 |
| --- | --- |
| 完整编译一个版本（含文献） | `latexmk HUAS-Beamer.tex` |
| 含参考文献 | `xelatex → bibtex → xelatex ×2` |
| 一键编四版 | Windows 双击 `makebeamer.bat`；macOS/Linux `make` |
| 自动反复编译 | `latexmk HUAS-Beamer.tex`（配置在 `.latexmkrc`，已定 XeLaTeX + bibtex） |
| 边写边预览 | `latexmk -pvc HUAS-Beamer.tex` |
| Overleaf | 上传 `template/` 全部文件，编译器选 XeLaTeX |

以上终端命令均在 `template/` 内运行。若使用 PowerShell，批处理命令写为
`.\makebeamer.bat`，单版可用 `.\makebeamer.bat HUAS-Beamer-EN`。
自定义 `.tex` 文件名可直接交给 latexmk，不受四个内置目标限制。
迁移独立项目时，应同时保留主题、`figures/`、参考文献与 `.latexmkrc`。

latexmk 会按需运行 BibTeX 和重复编译；本目录 `.latexmkrc` 指定了 XeLaTeX。
Windows 批处理结束会清理辅助文件并暂停，需要保留 `.log` 排错时改用 latexmk 或手动命令。
Makefile 只在依赖文件变化时重编译，单独换图后可用 `make -B` 强制构建。

**实战注意**：

- PDF 被阅读器占用时无法覆盖编译，先关阅读器；
- 改了 `.sty` 必须重新编译才生效（两遍）；
- 不认识的宏包报错 → MiKTeX 会提示自动安装；TeX Live 请用 tlmgr 安装。

## 第 19 章　完整案例：一次开题报告的工作流

**场景**：下周开题报告，15 分钟汇报，导师要求暖色校徽红版本。

```
Day 1  复制 HUAS-Beamer.tex → 开题报告.tex
       ├─ 改六件套 + \reportdate（10 分钟）
       └─ 列提纲：4 个 \section（背景 / 内容 / 方法 / 进度）

Day 2  逐节写内容
       ├─ 背景页：block + alertblock 对比「政策 / 问题」
       ├─ 内容页：columns 左图右文
       ├─ 方法页：表格（\huastableheader）+ 公式
       └─ 进度页：itemize[<+-| alert@+>] 分步讲

Day 3  打磨
       ├─ 补 reference.bib 文献，四步编译
       ├─ 需要的页加 [fragile] 代码示例
       └─ 检查页脚短标题是否需要缩短（\title 的方括号）

Day 4  彩排
       ├─ 看页码节奏：\section 数量与时间分配
       └─ 导出 PDF 到 U 盘 + 邮箱备份（PDF 即成品，任何电脑可放）
```

> **心得**：先搭骨架（section + 空 frame）再填内容，永远比一页一页磨快；
> 内容写不完时，删页比缩字号更体面（字号别小于 `\footnotesize`）。

## 第 20 章　常见问题

| 问题 | 解决办法 |
| --- | --- |
| `lstlisting` 页报错 | 该 frame 加 `[fragile]` |
| 参考文献显示 `[?]` | 四步编译：`xelatex → bibtex → xelatex → xelatex` |
| 封面/目录装饰偏移一次 | TikZ 需两轮编译，再编一遍 |
| 中文编译报错 | 中英文均用 `xelatex`，检查首个错误及字体/宏包是否齐全；`[en]` 负责英文界面 |
| 中文字体缺失 | 检查 Fandol 安装；显式更换字体命令的方法见 §17.6 |
| 节前目录页太多 | `[notoc]` 关闭节前节页和目录；小节目录需移除 `[subsectiontoc]` |
| 目录条目溢出页脚 | 按自定义说明 §4.6 收字号与 `\huas@tocitemskip` 条目间距 |
| PDF 无法覆盖编译 | 关闭正在预览的阅读器 |
| 页面底色想调 | `\definecolor{huasbg}{HTML}{...}`（§17.2） |
| 想要英文幻灯片 | 使用 `[en]` 或 `-EN.tex` 版本，并自行将正文和文献改为英文，选项不负责翻译 |

---

# 附录

## 附录 A　特殊字符速查

| 字符 | 正文输入 | 数学输入 |
| --- | --- | --- |
| # $ % ^ & _ { } ~ \ | `\# \$ \% \textasciicircum{} \& \_ \{ \} \textasciitilde{} \textbackslash{}` | `$ ^ _ { }` 有特殊含义，`\` 引导命令 |
| 引号 | `` `左引号' ``、`` ``双引号'' `` | |
| 省略号 | `\ldots` | `\cdots` |
| 破折号 | `---`（三连字符） | |
| 不换行空格 | `~`（如 `图~1`） | |

## 附录 B　命令速查

**LaTeX 通用**：

| 命令 | 作用 |
| --- | --- |
| `\textbf{} \textit{} \emph{}` | 加粗 / 斜体 / 强调 |
| `\section{} \subsection{}` | 章 / 节 |
| `\label{} \ref{} \cite{}` | 标签 / 引用编号 / 引用文献 |
| `\includegraphics[width=...]{}` | 插图 |
| `\frac{}{} \sqrt{} \sum` | 分式 / 根号 / 求和 |

**Beamer 通用**：

| 命令 | 作用 |
| --- | --- |
| `\begin{frame}{标题}` | 开始一个内容帧，分步显示时可生成多个 PDF 页面 |
| `block / alertblock / exampleblock` | 三种彩色块 |
| `columns / column` | 双栏 |
| `<+->` `\only<n->{}` | 分步显示 |
| `\tableofcontents` | 目录页 |

**HUAS-Beamer 专有**：

| 命令 | 作用 |
| --- | --- |
| `\supervisor{}` | 封面导师行 |
| `\reportdate{}` | 固定页脚汇报时间 |
| `\huassetlogo / \huassetbg` | 换封面校标/水印；其他图片按 §17.4 修改源码位置 |
| `\tocbackground` | 目录页背景线稿 |
| `\huastableheader / \huastableheaderfont` | 表格彩色表头 |
| `\setframeofframes{--}` | 页码分隔符 |

## 附录 C　术语表

| 术语 | 含义 |
| --- | --- |
| 引擎 | 把 `.tex` 编译成 PDF 的程序（本项目用 XeLaTeX） |
| 宏包 | `\usepackage` 加载的功能扩展 |
| 文档类 | `\documentclass` 声明的文档类型（article / beamer…） |
| 导言区 | `\begin{document}` 之前的设置区 |
| frame | Beamer 内容帧；普通帧对应一页，分步显示时可对应多个 PDF 页面 |
| fragile | frame 选项：页内含代码等逐字符内容时必加 |
| overlay | 分步显示的「动画层」 |
| 三线表 | 学术表格样式（顶线、栏目线、底线） |
| 四步编译 | xelatex→bibtex→xelatex→xelatex，参考文献必需 |

## 附录 D　进阶资源

- 《[一份（不太简短的）LaTeX2ε 介绍](https://ctan.org/pkg/lshort-zh-cn)》——中文经典入门书（lshort-zh-cn）；
- [LaTeX Wiki Book](https://en.wikibooks.org/wiki/LaTeX) —— 遇到具体问题查这里；
- [CTAN](https://ctan.org) —— 全部宏包文档的官方仓库；
- Beamer 用户手册（`texdoc beamer` 本地查看）—— 覆盖、主题等高级用法；
- [Overleaf Learn](https://www.overleaf.com/learn) —— 图文并茂的官方教程；
- 模板样式细节：[模板使用与自定义说明.md](模板使用与自定义说明.md)；
- 项目设计思路与视觉规范：[开发计划.md](开发计划.md)。

---

> **练习清单**（做完你就是熟手）：
> 1. 编译 `hello.tex`，故意制造一次「花括号不配对」报错并学会看行号；
> 2. 写一个 3 页的最小 Beamer：封面 frame + 2 页正文；
> 3. 用 `HUAS-Beamer.tex` 的副本做出你的答辩 PPT，含：目录、双栏页、表格页、文献页；
> 4. 把页面底色改一次（§17.2），再改回来；
> 5. 换掉封面校标（`\huassetlogo`），编译两遍验证。
