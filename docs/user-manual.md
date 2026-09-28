# HUAS-Beamer 零基础使用手册

对应版本：Phase 6；核对日期：2026-09-29。按“从未用过 LaTeX”编写，主要操作路线是 **Windows + TeX Live + 文本编辑器 + PowerShell**。主题已在本机 TeX Live 2025 上验证；安装界面可能随版本变化。教学代码不需要下载参考仓库，也不需要 Python。

## 阅读路线

第一次使用，按第 1～6 节顺序做；能改文字并生成 PDF 后，按需要阅读后面章节。

1. [认识文件、命令与编译](#step-1)
2. [安装与检查工具](#step-2)
3. [打开工程并编译现有示例](#step-3)
4. [建立自己的第一份演示](#step-4)
5. [逐行理解与修改封面](#step-5)
6. [增加、删除和排列页面](#step-6)
7. [文字、列表与特殊符号](#step-7)
8. [选择三种样式和配置](#step-8)
9. [校徽、建筑与正文图片](#step-9)
10. [双栏、内容块、引文与重点页](#step-10)
11. [表格、公式、代码与参考文献](#step-11)
12. [按毫米调整版面：全部 34 项尺寸](#step-12)
13. [字体、字号、颜色和固定文字](#step-13)
14. [四份模板怎样改](#step-14)
15. [排错与恢复](#step-15)
16. [交付、迁移与 Overleaf](#step-16)
17. [练习与速查](#step-17)

更深入的默认值和内部细节见[微调手册](customization.md)；开发历史见[五阶段总评](development-overview.md)。本手册是 Markdown，可在支持 Markdown 的编辑器中打开预览；也可以直接阅读文字。

<a id="step-1"></a>
## 1. 先认识你要操作的东西

### 1.1 LaTeX 怎样制作演示

你在 `.tex` 文本文件里写内容和排版命令，XeLaTeX 读取文件，生成可放映的 PDF。这个过程叫“编译”。编辑 `.tex` 后，旧 PDF 不会自动改变；要保存并重新编译。

Beamer 是制作演示页面的 LaTeX 文档类。ctex 为中文提供支持；本工程用 `ctexbeamer`。HUAS 是决定颜色、字体和页面布局的主题。最终文件是 PDF，不是可以直接拖拽编辑的 PPTX。

| 名称 | 通俗解释 | 你需要做什么 |
| --- | --- | --- |
| `.tex` | 你写的演示稿 | 用文本编辑器打开并修改 |
| `.sty` | 主题实现文件 | 保留在项目中；开始时不需要改 |
| `.png/.jpg` | 插入演示的图片 | 放在 assets 中，通过路径加载 |
| `.pdf` | 编译出来的演示成品 | 打开检查、全屏放映或分享 |
| `.log` | 编译过程记录 | 出错时查第一条错误 |
| `.aux/.toc/.nav` 等 | 编译器保存的辅助信息 | 让第二遍编译更新目录、引用和总页数 |
| `.md` | 使用说明和开发总结 | 阅读说明，不拿它作为演示源编译 |

### 1.2 先认识五种写法

```tex
\title{我的第一次汇报}
% 这一行是注释，不显示在 PDF 中。
\begin{frame}{这一页的标题}
  这一页的正文。
\end{frame}
```

- `\` 开始一个命令，如 `\title`。这里是一个反斜杠，不是文件路径分隔符 `/`。
- `{...}` 是命令的内容，开始和结束的花括号必须成对。`\title{...}` 的花括号里写封面题名。
- `[...]` 通常是可选设置，如 `\begin{frame}[t]{标题}` 的 `t` 表示正文顶部对齐。
- `\begin{名字}` 与 `\end{名字}` 围住一个环境，名字必须一致。
- `%` 后面的同一行是注释。取消注释就是删去行首 `%`；只删你想启用的那一行。

命令、括号和参数名使用英文半角字符；中文正文和中文标点照常输入。`style=cool` 中的 `=` 不能换成全角 `＝`。粘贴代码时只复制代码块里面的内容，不复制包围它的三条反引号。

### 1.3 项目根目录是什么

“根目录”是能同时看见 `main.tex`、`beamerthemeHUAS.sty`、`theme`、`examples`、`docs` 的那一层文件夹。本机是 `D:\10_Code\01_Active\HUAS-Beamer`；搬到另一台机器可以是别的路径。

```text
HUAS-Beamer/
├─ main.tex                     五页最小视觉示例
├─ beamer*themeHUAS.sty          五个主题文件，全部保留
├─ theme/                       配置、布局、素材、内容四个模块
├─ examples/                    三份完整示例与 local-assets.tex
│  └─ references/               本地参考代码，普通使用不需要
├─ assets/                      图片素材
│  └─ research/                 本地研究图片，不随 Git 下载
├─ scripts/build.ps1            现有四份示例的构建脚本
├─ docs/                        说明与总结
├─ LICENSE、NOTICE.md            源码与素材的许可说明
└─ build/                       编译后创建，里面找 PDF 和日志
```

不要只把 `main.tex` 单独拷贝出去：它要加载旁边的主题与 `theme/`。不要在 `theme/` 中编译内部 `.tex` 模块，它们不是完整文档。研究素材和参考项目没有也能使用主题。

<a id="step-2"></a>
## 2. 安装与检查工具

### 2.1 你需要哪些软件

需要一套 TeX 发行版来提供 XeLaTeX 和宏包，再用文本编辑器改文件。本文沿用项目实测的 TeX Live；可用 TeX Live 附带的 TeXworks，也可安装 TeXstudio。编辑器与编译器是两件东西，只安装编辑器还不能编译。[TeXstudio 官方入门说明](https://texstudio-org.github.io/getting_started.html)解释了这个要求。

已经能运行 XeLaTeX 的电脑，直接跳到 2.3，不需要为了本模板重装环境。

### 2.2 尚未安装时

1. 打开 [TeX Live 官方 Windows 页面](https://tug.org/texlive/windows.html)，下载页面提供的 `install-tl-windows.exe`。
2. 运行安装程序，选择安装目录。用不含中文的目录便于排错，如 `D:\texlive\2026`；年份以你实际下载的版本为准。不要把 TeX Live 安装到演示项目文件夹里。
3. 初学者可保留 full 安装方案，避免逐个补包；确保磁盘能容纳安装器显示的空间需求。等待安装器报告成功，再关闭。
4. 关闭旧终端，重新打开 PowerShell。安装器通常会加入可执行文件搜索路径，旧终端可能还未读到新路径。

以上安装入口和 PATH 行为见 [Windows 官方说明](https://tug.org/texlive/windows.html)；full 方案见 [安装器说明](https://tug.org/texlive/doc/install-tl.html)。项目验证用的是现有 2025 环境，未对新安装器做本机重新安装测试。

### 2.3 打开 PowerShell，检查编译器

在 Windows 开始菜单搜索“PowerShell”并打开。终端里像 `PS D:\...>` 的文字是提示符，不要把它复制到命令里。本文 `powershell` 代码块在终端执行；`tex` 代码块写进 `.tex` 文件。每条终端命令输入后按 Enter。

```powershell
xelatex --version
```

成功时显示 XeTeX/TeX Live 的版本信息。若提示“不识别 xelatex”，可以先使用完整路径；本项目电脑的路径是：

```powershell
& 'D:/Texlive/texlive/2025/bin/windows/xelatex.exe' --version
```

开头的 `&` 是 PowerShell 的“执行这个程序”，单引号包住路径。其他电脑要在安装目录下找到 `bin/windows/xelatex.exe`，用实际路径替换。只复制本机路径到别的电脑通常不能运行。

如需让命令长期可用，在 Windows 的“编辑账户的环境变量”中选用户 `Path`，新增实际 `bin\windows` 目录，保留已有条目，重新打开终端再检查。无需把整个 TeX Live 根目录加入 Path。

### 2.4 配置编辑器

在 TeXstudio 中通过“文件 → 打开”选择项目根目录的 `main.tex`；保存编码使用 UTF-8。若以后使用编辑器的编译功能，在“选项 → 配置 TeXstudio → 构建”将默认编译器选为 XeLaTeX；找不到程序时在“命令”页选择实际的 XeLaTeX 路径。菜单语言与位置以安装版本为准。[官方配置说明](https://texstudio-org.github.io/configuration.html)列出了这些设置。

下面统一用终端编译，输出路径明确。暂时只用编辑器打开、改字和保存即可。文件首行 `% !TeX program = xelatex` 是部分编辑器识别的提示，不会替代编译器安装，也不会改变终端执行的命令。

<a id="step-3"></a>
## 3. 先成功编译一份现有示例

### 3.1 进入根目录

在 PowerShell 执行：

```powershell
Set-Location -LiteralPath 'D:/10_Code/01_Active/HUAS-Beamer'
Get-Location
```

第二条命令输出当前目录。不是本机路径时替换第一行引号内文字。引号可容纳空格；`.tex` 内的素材路径建议使用 `/`，例如 `assets/images/photo.png`。

### 3.2 用构建脚本编译

```powershell
./scripts/build.ps1 -Target main
```

本机 XeLaTeX 未加入 PATH 时改用：

```powershell
./scripts/build.ps1 -Target main -Engine 'D:/Texlive/texlive/2025/bin/windows/xelatex.exe'
```

脚本会建输出目录、编译两遍，成功后打印 PDF 路径。打开 `build/main/main.pdf`，应看到封面、章节、两页正文和结束页，共五页。有无本地研究图片都会生成 PDF；没有素材时校徽不显示，装饰建筑留空，正文图片位置显示占位。

### 3.3 脚本被执行策略阻止时，直接编译

如果提示“无法加载文件，因为在此系统上禁止运行脚本”，可用下面同样有效的方式，不需要更改系统策略：

```powershell
New-Item -ItemType Directory -Force -Path 'build/main' | Out-Null
xelatex -interaction=nonstopmode -halt-on-error '-output-directory=build/main' main.tex
xelatex -interaction=nonstopmode -halt-on-error '-output-directory=build/main' main.tex
```

`xelatex` 不在 PATH 时，把两行开头分别换为 `& '实际的/xelatex.exe/路径'`。例如本机第一遍：

```powershell
& 'D:/Texlive/texlive/2025/bin/windows/xelatex.exe' -interaction=nonstopmode -halt-on-error '-output-directory=build/main' main.tex
```

这里的 `New-Item` 创建文件夹；`-Force` 允许文件夹已存在；`Out-Null` 省略创建信息。`-halt-on-error` 遇到第一条错误就停；`-output-directory` 指定输出文件夹。第一遍读取内容，第二遍更新目录、引用及正文总页数，两遍都应成功。第一遍失败就先排错，不继续机械重复。

### 3.4 编译另外三份

| 想看哪套 | Target 值 | 脚本输出文件 | 默认物理页数 / 正文计数 |
| --- | --- | --- | --- |
| 最小视觉示例 | `main` | `build/main/main.pdf` | 5 / 2 |
| Academic 学术汇报 | `academic` | `build/academic/academic-demo.pdf` | 10 / 6 |
| Warm 读书研讨 | `seminar` | `build/seminar/seminar-demo.pdf` | 9 / 5 |
| Cool 蓝色组件 | `cool` | `build/cool/cool-demo.pdf` | 16 / 11 |

把命令的 `-Target main` 换成相应值即可。运行 `./scripts/build.ps1` 或 `-Target all` 会全部编译。以上页数针对未修改的示例，改内容后可以不同。封面、章节、结束页存在于 PDF，但不计正文页码。

现在在 `main.tex` 中把 `\title{HUAS-Beamer 视觉页面示例}` 换为 `\title{我的第一次汇报}`，按 Ctrl+S 保存，再编译两遍。打开同一输出 PDF，封面题名应已改变。完成后可以撤销该练习，下一节另建个人文件。

<a id="step-4"></a>
## 4. 建立自己的第一份演示

### 4.1 新建文件，不改公共主题

在文本编辑器中新建文件，复制下列整段代码，另存为项目根目录中的 `my-talk.tex`，编码为 UTF-8。Windows 资源管理器开启“查看 → 显示 → 文件扩展名”，确认不是 `my-talk.tex.txt`。保存类型选“所有文件”时要完整输入 `.tex`。

以下是**完整文档**，不需要再套另一层 document 或 frame。没有素材也能编译。

<!-- tutorial:starter -->
```tex
% !TeX program = xelatex
\documentclass[aspectratio=169]{ctexbeamer}

\usetheme{HUAS}
\HUASsetup{style=academic,logo=false,footer=standard,
  sectionpage=true,language=zh,faculty={}}

\title{我的第一次学术汇报}
\subtitle{从问题到证据}
\author{张三}
\institute[文法学院]{湖南文理学院文法学院}
\date{2026年9月28日}

\begin{document}

\HUASmaketitle

\begin{frame}{汇报目录}
  \tableofcontents[hideallsubsections]
\end{frame}

\section{研究问题}

\begin{frame}[t]{我想回答什么问题？}
  这份汇报关注学生如何找到支持观点的文本证据。
  \begin{itemize}
    \item 研究对象：课堂阅读记录。
    \item 研究问题：观点是否有具体语句支持？
    \item 汇报目标：说明一个可复核的分析过程。
  \end{itemize}
\end{frame}

\begin{frame}[t]{我准备怎样分析？}
  \begin{enumerate}
    \item 保留原始材料。
    \item 分别标记观点、证据与推理。
    \item 比较不同解释并说明边界。
  \end{enumerate}
\end{frame}

\HUASclosingframe

\end{document}
```

### 4.2 编译个人文件

构建脚本只认识原来的四个目标，**没有 `-Target my-talk`**。在根目录用两条 XeLaTeX 命令编译自建文件：

```powershell
New-Item -ItemType Directory -Force -Path 'build/my-talk' | Out-Null
xelatex -interaction=nonstopmode -halt-on-error '-output-directory=build/my-talk' my-talk.tex
xelatex -interaction=nonstopmode -halt-on-error '-output-directory=build/my-talk' my-talk.tex
```

仍未配置 PATH 时，两行 `xelatex` 都换为完整程序路径。不要把说明中的“实际路径”原样复制。输出为 `build/my-talk/my-talk.pdf`，应是六页：封面、目录、章节、两页内容和致谢；目录与两页内容共三张计数页。

终端成功但 PDF 没变时，先确认保存了文件、编译的是 `my-talk.tex`、打开的是 `build/my-talk/my-talk.pdf`。旧示例的 PDF 和个人文件的 PDF 是不同文件。

<a id="step-5"></a>
## 5. 逐行理解并修改封面

### 5.1 哪一段管设置，哪一段管内容

`\begin{document}` 之前叫“导言区”，用于文档类、主题、配置、图片路径和封面信息。两个 document 标记之间叫“正文”，写页面内容。`\end{document}` 后面的文字不会成为演示内容。

| 原代码 | 含义 | 你可以怎么改 |
| --- | --- | --- |
| `\documentclass[aspectratio=169]{ctexbeamer}` | 中文演示、16:9、默认类字号 11pt | 暂时保留；需要整体大字时改成 `[aspectratio=169,12pt]` 并检查全部页面 |
| `\usetheme{HUAS}` | 加载本地 HUAS 主题 | 名字必须保留 HUAS；文件名区分拼写 |
| `\HUASsetup{...}` | 样式、页脚等设置 | 第 8 节逐项说明，放在主题加载后 |
| `\title{...}` | 封面主标题 | 换成自己的题目 |
| `\subtitle{...}` | 封面副标题 | 换文字或设 `\subtitle{}` 隐藏 |
| `\author{...}` | 汇报者姓名 | 换成个人或小组名称 |
| `\institute[文法学院]{湖南文理学院文法学院}` | 方括号短名用于普通页脚；花括号全名用于封面 | 都可以替换；不需要短名时只写 `\institute{湖南文理学院}` |
| `\date{...}` | 封面日期 | 写固定日期；`\date{\today}` 为每次编译当天；`\date{}` 隐藏日期文字 |
| `\HUASmaketitle` | 根据以上信息生成一张完整封面 | 放在正文开头，不再包 frame |

设置了非空 `faculty` 后，页脚优先显示 faculty，而不是 institute 短名。封面机构仍来自 institute。新手示例 `faculty={}` 表示空文字，所以页脚显示“文法学院”。

### 5.2 主标题太长怎么办

先缩短标题或把背景说明放入副标题。确需两行时，在一个花括号中用两个反斜杠：

```tex
\title{第一行研究题目\\第二行补充说明}
\subtitle{这里写更具体的研究范围}
```

不要同时保留两份 title 并以为会显示两份题名：后面的设置会覆盖前面的。空副标题不会生成第二行字；主题内预留的其他间距仍可能存在。大量加空行也不会把封面标题精确移动到某个坐标。

<a id="step-6"></a>
## 6. 增加、删除和排列页面

### 6.1 一页普通内容的最小结构

下面是**正文片段**。放在 document 内、两个完整 frame 之间，不要粘进另一个 frame：

<!-- tutorial:page -->
```tex
\begin{frame}[t]{我的新页面}
  这里写这一页的第一段内容。

  这里写第二段内容。
\end{frame}
```

复制整个 begin～end 结构就增加一页；删掉整段就删除一页；剪切整段到别的 frame 之间就改变顺序。只删 begin 或 end 会破坏文档。改花括号中的标题，不影响封面 title。

`[t]` 表示正文靠上；不写时普通正文通常垂直居中。`[plain]` 隐藏普通页眉页脚，主要用于需要自己排版的整页；刚开始使用完整页面命令即可。主题目前不显示 `\framesubtitle`，第二层说明可直接放进正文。

### 6.2 章节不是普通页面

```tex
\section{研究方法}
```

这行划分汇报结构，决定目录条目和 Cool 页眉的当前章节。`sectionpage=true` 时，它还自动插入一张章节页；`false` 时不插页，但章节结构依然存在。普通 section 放在 frame 外。

```tex
\section{研究方法}
\begin{frame}[t]{材料怎样收集？}
  这里写研究方法的第一页。
\end{frame}
```

需要手动章节页时，在导言区设 `sectionpage=false`，正文 section 后再写 `\HUASsectionframe`。不要自动与手动同时开启，否则会得到两张章节页。`\section*{...}` 不进入普通目录结构，也不触发主题的自动章节页。

### 6.3 目录和页码为什么要两遍编译

目录页使用 `\tableofcontents[hideallsubsections]`，自动读取 section；方括号选项隐藏小节，去掉后可显示已写出的 subsection。增加章节以后第一遍记录结构，第二遍读取记录。初次编译目录为空、总页数尚未更新时先完成第二遍。

页脚 `1/3` 是“当前正文 frame / 正文 frame 总数”。完整封面、章节和致谢不计入；目录和重点页会计入。使用 `\pause` 等分步显示后，一个 frame 可能生成多张物理 PDF 页，页脚仍显示相同 frame 号，不能把它与 PDF 页数混为一谈。初学时先保持每个 frame 一张页面。

### 6.4 结束页和重点页

```tex
\HUASkeypoint{我的结论}{第一行核心判断，\\第二行补充边界。}
\HUASclosingframe
```

二者都自己创建完整 frame，必须在其他 frame 外调用。前者计入正文页数，后者不计。只需致谢时用第二行即可；结束页固定致谢文字的改法见第 13 节。

<a id="step-7"></a>
## 7. 写文字、列表与特殊符号

### 7.1 换行、段落和强调

源文件按一次 Enter 通常只是方便阅读源码，不等于 PDF 中换一行；空一行表示另起一段。两个反斜杠 `\\` 可以在合适的正文位置显式换行，但不要在环境边界或空段落后到处添加它。

<!-- tutorial:text -->
```tex
\begin{frame}[t]{文字的基本写法}
  这是普通正文，中文直接输入。
  \textbf{这是加粗文字。}
  \alert{这是使用主题强调色的文字。}

  这是第二段。第一行说明。\\
  这是同一段中的下一行说明。

  {\small 这一段局部变小，花括号结束后恢复。\par}
  字面符号：50\%、A\&B、file\_name、\#1、\$5。
\end{frame}
```

`\textbf{...}` 用加粗突出内容；`\alert{...}` 用颜色强调。原生正文中的中文粗体由 ctex 字体配置处理，不等于更换整套标题字体。`{\small ...\par}` 的花括号限制字号作用范围，`\par` 让该段在局部字号下结束。编辑器放大代码字号只影响编辑界面，不会放大 PDF。

### 7.2 特殊符号必须这样输入

| 想显示的字面字符 | 在普通正文里输入 | 原因 |
| --- | --- | --- |
| `%` | `\%` | 裸百分号会让后面的同一行变成注释 |
| `&` | `\&` | 裸 & 用于表格的分列 |
| `_` | `\_` | 裸下划线用于数学下标 |
| `#` | `\#` | 裸井号用于宏参数 |
| `$` | `\$` | 裸美元号用于进入/退出行内数学 |
| `{` / `}` | `\{` / `\}` | 裸花括号划定命令参数与作用范围 |
| `\` | `\textbackslash{}` | 裸反斜杠开始命令 |

这些规则用于普通正文，`verbatim` 代码区按原样输入，图片路径中的下划线也不用改成 `\_`。需要显示网址时用 `\url{https://example.com}`，不把正文转义规则直接套到 URL。

### 7.3 圆点列表与编号列表

<!-- tutorial:lists -->
```tex
\begin{frame}[t]{列出要点与步骤}
  \begin{itemize}
    \item 这是第一条要点。
    \item 这是第二条要点。
  \end{itemize}
  \begin{enumerate}
    \item 先提出问题。
    \item 再寻找证据。
    \item 最后说明结论。
  \end{enumerate}
\end{frame}
```

每增加一条就增加一个 `\item`；删除条目时连同其文字删除。itemize 是圆点，enumerate 是编号。不必自己输入“1、2、3”。可在某个列表 begin 后加 `\setlength{\itemsep}{0.4em}` 增大条目间距；这会增高列表，仍需检查内容是否超页。

一页内容放不下时，先拆成两页。长段论文直接粘进一页通常太密，不建议依赖 `shrink` 把内容缩到难以投影阅读。

<a id="step-8"></a>
## 8. 三种样式和六项配置

在导言区、`\usetheme{HUAS}` 之后改 `\HUASsetup`，不要把它放在 document 内。可以分次调用；后一次只覆盖写出的项目。例如先设全套配置，再单写 `\HUASsetup{footer=minimal}` 只修改页脚。

| 项目 | 可填写的值 | 默认值 | 具体效果 |
| --- | --- | --- | --- |
| `style` | `academic` / `warm` / `cool` | academic | 选择整套样式，见下表 |
| `logo` | `true` / `false` | false | 是否显示已设置的校徽；true 不会自动生成图片 |
| `footer` | `standard` / `minimal` / `none` | standard | 机构+页码+可选校徽 / 仅页码 / 无普通页脚 |
| `sectionpage` | `true` / `false` | false | 普通 section 是否自动插入章节页 |
| `language` | `zh` / `en` | zh | 切换主题固定标签；不翻译用户文字 |
| `faculty` | `{简短机构或活动文字}` / `{}` | 空 | 标准页脚和章节/结束页辅助标签；空时页脚取 institute 短名 |

“默认值”是仅加载主题时的值，现有示例各自又设了配置，所以示例中的 Logo/章节页可以已经打开。值用英文小写；布尔值不用“是/否”代替。文字中包含英文逗号时务必用花括号围住，避免逗号被当成下一项设置。

| 样式 | 封面、章节、结束页 | 普通内容页 | 合适的起点 |
| --- | --- | --- | --- |
| academic | 白色封面、暖纸色章节/结束页，暖红强调 | 白底、深色正文、标题下细线 | 学术汇报、日常课程 |
| warm | 暖红背景白字，底部浅色辅助区 | 仍是浅色正文，无章节页眉 | 读书分享、研讨 |
| cool | 蓝色题名区、浅蓝灰章节/结束页 | 深蓝章节页眉、蓝色标题栏、深蓝页脚 | 蓝色教学展示、完整组件参考 |

在个人文件中只把 `style=academic` 改为 `style=cool`，重新编译就能看见区别。Warm 不会将每页正文变成红底；这是当前设计。关闭 `footer` 不会同时关闭 Cool 的顶部页眉。

完整页面推荐用 HUAS 的完整命令。手工把 `\titlepage` 放入普通 frame 不会自动得到同样的 Warm 背景，也可能计入普通页码。

<a id="step-9"></a>
## 9. 校徽、建筑与正文图片

### 9.1 先分清三种图片用途

- **校徽**：通过 `\HUASsetlogo` 加载，主题放到封面及标准页脚；具体位置随模式变化。
- **装饰建筑**：通过 `\HUASsetbuilding` 加载，主题放到封面、章节和结束页的辅助区。
- **正文插图**：在某个 frame 内用 `\includegraphics` 放置，尺寸由该处代码控制。

改变装饰建筑的路径不会同时改变正文图片。背景透明的 PNG 能融入页面，白底 JPG 即使缩小仍然保留白色矩形。主题不自动抠图、改色或补画建筑。

### 9.2 使用本机已有学校素材

在个人文件导言区、主题加载后加入：

```tex
\HUASsetup{logo=true}
\input{examples/local-assets.tex}
```

local-assets 会检测本地透明校徽和建筑图 1，找到才加载。找不到时不会凭空补图。这个目录被 Git 忽略，因此从仓库下载的用户通常没有这些图片。

如需替换版本，在 input **之后**写覆盖命令：

```tex
\HUASsetlogo{assets/research/HUAS-School_badge-transparent-imagegen-v2.png}
\HUASsetbuilding{assets/research/HUAS_building_2_bgcolor.png}
```

| 本地文件 | 含义 |
| --- | --- |
| `HUAS-School_badge-white_background.jpg` | 原始白底 JPG，保留 |
| `HUAS-School_badge-transparent.png` | 默认像素去白版，保留原图 RGB 与笔画，只调透明度 |
| `HUAS-School_badge-transparent-imagegen-v1.png` / `v2.png` | 两份可选生成式版本，有形状和色泽差异 |
| `HUAS_building_1_bgcolor.png` / `2_bgcolor.png` | 用户提供的两张建筑素材 |

不需要校徽时用 `\HUASsetup{logo=false}`；不需要装饰建筑时用 `\HUASsetbuilding{}`。校徽 true 但未加载文件时没有图片可显示。标准页脚才显示校徽，minimal 页脚不显示。Warm 封面校徽位于浅色信息区，避免红色校徽融入红底。

### 9.3 放入你自己的图片

在 `assets/images/` 内保存 `photo.png`；文件名可以自己取，初学时用英文、数字和短横线，避免路径混乱。如下路径相对于项目根目录，不是相对于 `.tex` 文件所在的 examples 目录。

```tex
\includegraphics[width=8cm]{assets/images/photo.png}
```

这句是**图片片段**，放在 frame 或 figure 中；没有该文件就报错。PNG、JPG、PDF 是常用输入，SVG 不属于这里的直接插入路线。

同时限制宽高并保留纵横比：

```tex
\includegraphics[width=8cm,height=4cm,keepaspectratio]{assets/images/photo.png}
```

含义是“放进最多 8cm×4cm 的区域”，图片实际宽高由比例决定，不会强行同时变成 8×4cm。只写 width 时高度自动按比例计算；照片很高时可能把页面撑出边界。像素数量与页面物理尺寸是两回事，缩放后的显示大小由 width/height 控制。

### 9.4 完整图片页：带图注、来源与缺图占位

下面是**正文片段**；没有 photo.png 时也可练习。你有图后替换两个路径，并更新图注与来源文字。

<!-- tutorial:image -->
```tex
\begin{frame}[t]{图片与来源}
  \begin{figure}
    \centering
    \IfFileExists{assets/images/photo.png}{%
      \includegraphics[width=8cm,height=3.5cm,keepaspectratio]{assets/images/photo.png}
      \caption{我的观察对象}
    }{%
      \fbox{\parbox[c][2.2cm][c]{8cm}{\centering 请放入 photo.png}}
      \caption{图片位置示例}
    }
    \label{fig:my-photo}
  \end{figure}
  {\small
    \IfFileExists{assets/images/photo.png}{图源：请填写真实来源。}{当前为占位框，没有加载照片。}\par}
\end{frame}
```

`\IfFileExists{路径}{找到时做什么}{未找到时做什么}` 是条件检测，不是自动下载。`\caption` 生成图编号和文字；`\label` 放在 caption 后保存编号供 `\ref{fig:my-photo}` 使用，编译两遍更新。图在 Beamer 当前页中排版，不应按论文里的“浮动到下一页”来期待其位置。

占位框 `parbox` 的内部宽 8cm、高 2.2cm，外框还包括边框厚度和边距。真实图片上限是 8×3.5cm，与占位尺寸不相同。仅替换检测路径而忘记 includegraphics 路径，可能显示另一张图或报错。

<a id="step-10"></a>
## 10. 双栏、内容块、引文与重点页

以下标为正文片段的整段代码均放在 document 内、其他 frame 外。

### 10.1 双栏

<!-- tutorial:columns -->
```tex
\begin{frame}[t]{两种解释并列比较}
  \begin{columns}[T,onlytextwidth]
    \begin{column}{0.48\textwidth}
      \begin{block}{左侧：观察}
        在这里放原文、现象或图片。
      \end{block}
    \end{column}
    \begin{column}{0.48\textwidth}
      \begin{exampleblock}{右侧：解释}
        在这里放判断、问题或分析。
      \end{exampleblock}
    \end{column}
  \end{columns}
\end{frame}
```

默认正文宽 14cm，两栏各为 6.72cm，剩余约 0.56cm 由栏间空白分配。`T` 让两栏顶部对齐，`onlytextwidth` 让总区域遵守正文宽。两栏不必一样宽，例如改为 `0.40\textwidth` 与 `0.56\textwidth`，即 5.6cm 与 7.84cm，仍留 0.56cm。比例相加不要超过 1，也要留出间距。

栏内图片写 `width=\linewidth` 表示当前栏宽，写 `width=14cm` 就会超出栏宽。两栏顶部对齐不等于内容块自动等高，块高由文字多少决定。

### 10.2 三种内容块

<!-- tutorial:blocks -->
```tex
\begin{frame}[t]{内容块的作用}
  \begin{block}{普通判断}
    这里写主要观点。
  \end{block}
  \begin{alertblock}{需要注意的边界}
    这里写限制、问题或提醒。
  \end{alertblock}
  \begin{exampleblock}{具体例子}
    这里写材料或示例。
  \end{exampleblock}
\end{frame}
```

花括号是块的小标题，环境里面是块正文。换 style 后块跟随相应颜色；Cool 的 alertblock 仍用红色表示提醒，不是漏切到旧样式。块内距与引文框内距分别控制，详见第 12 节和微调手册。

### 10.3 带出处的引文

<!-- tutorial:quote -->
```tex
\begin{frame}[t]{原文与自己的解释分开}
  \begin{HUASquotation}{陆游《游山西村》}
    山重水复疑无路，柳暗花明又一村。
  \end{HUASquotation}
  \medskip
  这一段是汇报者的解释，不属于上面的引文。
\end{frame}
```

HUASquotation 参数是出处，显示在框内右下；环境正文是引文本身。普通 `quote` 和 `quotation` 也能使用，但不会自动带这套出处区域。引文太长时拆页；框本身不会替你分页。

### 10.4 一句重点结论

<!-- tutorial:keypoint -->
```tex
\HUASkeypoint{核心结论}{观点需要证据支持，\\解释需要说明边界。}
```

这是**完整页命令**，不需要 begin/end frame。第一参数是页标题，第二参数是大字结论；参数各自要有完整花括号。它是普通计数页，保持浅色底。修改 `keypoint padding` 调框内留白；`HUAS key point` 字体角色调结论字号。

<a id="step-11"></a>
## 11. 表格、公式、代码与参考文献

### 11.1 从三列表格开始

<!-- tutorial:table -->
```tex
\begin{frame}[t]{把问题和证据对应起来}
  \begin{table}
    \centering
    \caption{分析维度与材料}
    \label{tab:evidence}
    \renewcommand{\arraystretch}{1.4}
    \setlength{\tabcolsep}{6pt}
    \begin{tabular}{lll}
      \hline
      \textbf{维度} & \textbf{问题} & \textbf{材料} \\
      \hline
      观点 & 是否清楚？ & 讨论记录 \\
      证据 & 是否相关？ & 阅读批注 \\
      推理 & 如何联系？ & 修订稿 \\
      \hline
    \end{tabular}
  \end{table}
\end{frame}
```

- `table` 承担图注等外围排版；`tabular` 是真正的行列。
- `lll` 是三列，每个 l 表示左对齐的自然宽度列；不是三个固定宽度。
- 每行三个单元格，用两个 `&` 分开，行末 `\\` 结束。单元格要显示 & 时写 `\&`。
- `\hline` 加横线。增添一行时复制完整的“内容 & 内容 & 内容 \\”。
- `arraystretch=1.4` 是基础行高的倍数，不是 1.4cm。`tabcolsep=6pt` 是各单元格左右内距，相邻两列通常合计 12pt。
- `\label` 用 `\ref{tab:evidence}` 引用编号；它应在 caption 后。

某一列要自动折行，可把 `{lll}` 改成 `{lp{4cm}l}`：第二列正文宽 4cm，其余自然宽。总宽还包含列间内距；不等于三列标出的内容宽直接相加。长表拆为几页，不期待一个 frame 自动跨页。

### 11.2 行内公式与独立公式

<!-- tutorial:math -->
```tex
\begin{frame}[t]{用公式说明比例}
  行内公式写成 $r=a/b$，它与正文在同一行。
  \[
    r=\frac{n_{\mathrm{supported}}}{n_{\mathrm{total}}}
  \]
  分子是有证据支持的解释数，分母是全部解释数。
\end{frame}
```

一对 `$...$` 是行内数学；`\[...\]` 是单独一行的数学区域。`\frac{分子}{分母}` 写分式，`_{...}` 写下标，`^{...}` 写上标。`\mathrm{supported}` 让英文下标直立；普通字母在数学区默认用数学字体。

公式里的中文说明可用 `\text{解释数}`；本项目的 Beamer 环境已提供常用数学支持，无需为这些例子额外加宏包。美元号不成对时会出现数学模式错误。

### 11.3 代码必须保留 fragile

<!-- tutorial:code -->
```tex
\begin{frame}[fragile]{展示一段 Python 代码}
  \begin{block}{统计已经完成的任务}
    \small
    \begin{verbatim}
tasks = ["read", "annotate", "discuss"]
print(len(tasks))
    \end{verbatim}
  \end{block}
  \medskip
  代码用于说明过程，这里写中文解释。
\end{frame}
```

`verbatim` 内部代码按原样显示，不需要转义 `%`、`_`、`#`。这里只展示代码，不运行 Python；编译不依赖 Python。包含 verbatim 的 frame 必须 `[fragile]`，`\end{frame}` 单独占一行。不要把 verbatim 放入 HUASkeypoint 的参数或 textbf 的参数。

当前没有语法高亮、行号和自动折行，长行需要自己拆。局部 `\small` 缩小块内代码，长代码优先分页。不要把中文讲解强塞进默认 ASCII 等宽代码区。

### 11.4 手工参考文献和引用

下例包含**两页正文片段**，放在普通 frame 之间：

<!-- tutorial:bibliography -->
```tex
\begin{frame}[t]{说明资料来源}
  页面组织参考 Beamer 用户手册\cite{beamer-guide}。
\end{frame}

\begin{frame}[t]{参考文献}
  \begin{thebibliography}{9}
    \bibitem{beamer-guide}Till Tantau, Joseph Wright, Vedran Miletić.
      \newblock The beamer class: User Guide.
      \newblock TeX Live 随附的 Beamer 文档。
    \bibitem{huas-guide}HUAS-Beamer 项目.
      \newblock HUAS-Beamer 零基础使用手册.
      \newblock 本项目 docs/user-manual.md。
  \end{thebibliography}
\end{frame}
```

`beamer-guide` 是自己给条目起的唯一键；cite 与 bibitem 中的键必须完全一致，不是直接写“第 1 条”。`\newblock` 分隔出版信息，文献顺序由你手工排列。`{9}` 是编号宽度样本，超过 9 条时可改 `{99}`，不是限制只能写 9 条。

第一遍 cite 可能显示问号，第二遍应更新。本主题没有自动 BibLaTeX/Biber 后端，上例不用 `.bib` 文件也不用运行 Biber。文献多时复制参考文献 frame 分页，保持所有 bibitem 键唯一。

<a id="step-12"></a>
## 12. 按毫米调整版面：全部 34 项尺寸

### 12.1 先学会写一个尺寸设置

在导言区、加载主题之后写：

```tex
\HUASsetlayout{frametitle padding=2mm}
```

这让普通内容标题栏四周留白从默认 1.5mm 变成 2mm。它不把标题栏总高度固定为 2mm。改变多项用英文逗号分隔，最后一项不用逗号；键名中的空格保留，如 `headline height`，不能写成 `headline_height`。

```tex
\HUASsetlayout{
  headline width=\paperwidth,
  headline height=3mm,
  headline depth=1.3mm,
  frametitle padding=2mm,
  footline width=\paperwidth,
  footline height=3.5mm,
  footline depth=1.3mm
}
```

页眉总高 3+1.3=**4.3mm**；页脚总高 3.5+1.3=**4.8mm**。页眉只在 Cool 普通内容页显示，Academic/Warm 设置了 headline 也不会出现新页眉。增高栏位会减少正文可用高度。

恢复默认：删掉相应键或注释掉整段设置并重新编译。如果更早还有另一段 setlayout，该设置仍会生效；搜索同名键找出全部定义。注释多行配置时要把整个命令各行都注释，不能只注释开头留下孤立的参数行。

### 12.2 长度单位和三个“宽度”

| 写法 | 含义 | 默认 16:9 时 |
| --- | --- | --- |
| `cm` / `mm` | 绝对厘米 / 毫米 | 1cm=10mm |
| `pt` | TeX 排版点 | 1pt 约 0.35146mm；不等同于所有软件里的显示点 |
| `em` | 随当前字体大小变化的长度 | 不固定为某个 mm |
| `ex` | 当前字体 x 高度对应的长度 | 不固定为字号或某个 mm |
| `\paperwidth` / `\paperheight` | 整张纸的宽 / 高 | 16cm / 9cm |
| `\textwidth` | 当前排版区域的正文宽 | 整页默认 14cm；minipage 内会变为局部宽 |
| `\linewidth` | 当前行宽 | 双栏内等于该栏可用行宽 |

默认左右各 1cm，所以整页正文宽=16−1−1=14cm。改成左右 12mm 后，正文宽=160−12−12=136mm。页面物理尺寸不等于显示器上看起来的厘米数，PDF 查看器会缩放显示。

`0.48\textwidth` 表示正文宽的 48%；不是 0.48cm。希望准确写毫米时用 `3mm`，不要把 ex 强行转换为常数。页眉/页脚的框先建立，再选内部字体，因此改其文字字号不保证 ex 高度按同一字体同比改变。

### 12.3 页眉、标题栏和页脚：11 项

| 键名 | 默认值 | 效果；怎样改 |
| --- | --- | --- |
| `text margin left` | 1cm | 正文及各栏文字左缩进；设 `12mm` 向右收紧 |
| `text margin right` | 1cm | 正文及各栏文字右缩进；两者共同决定正文宽 |
| `headline width` | `\paperwidth`，16cm | Cool 深蓝章节页眉色块宽；设 `15cm` 缩窄，不自动居中 |
| `headline height` | 2.5ex | 页眉文字基线上方高度；设 `3mm` |
| `headline depth` | 1.2ex | 页眉基线下方深度；设 `1.3mm`，与上项合成 4.3mm |
| `frametitle width` | `\paperwidth`，16cm | 普通页标题栏色块宽，不改变正文宽 |
| `frametitle padding` | 0.15cm，1.5mm | 标题栏四周内距；设 `2mm` 会加厚并减少可用文字宽 |
| `frametitle rule` | 0.4pt，约 0.141mm | Academic/Warm 标题下细线厚度；长为正文宽，设 `0pt` 隐藏；Cool 不显示此线 |
| `footline width` | `\paperwidth`，16cm | 普通页脚色块宽，设 `15cm` 变窄 |
| `footline height` | 2.5ex | 页脚基线上方高度；设 `3.5mm` |
| `footline depth` | 1.2ex | 页脚基线下方深度；设 `1.3mm`，与上项合成 4.8mm |

“基线”是排字时一行文字所依附的水平位置，字符可向上、向下伸展。height 和 depth 分别控制其上、下方区域；不是页眉到纸上沿的距离。

普通标题栏总高由文字行数、字体的行高及 padding 共同决定，一行标题近似为“文字排版高度+上下 padding”。标题两行就会更高，当前不提供强制固定总高以免裁字。封面等 plain 页面没有这些普通栏位，底部图片/校训区另用 hero 参数。

新手建议保持三栏 `width=\paperwidth`，只调文字边距和内距。缩窄标题栏后的水平位置由 Beamer 标题容器共同决定，不保证与同样缩窄的页眉/页脚对齐；尤其是左右边距不对称时，要看实际 PDF。缩窄色块也不会自动把机构文字缩短。

### 12.4 校徽与建筑：5 项

| 键名 | 默认值 | 效果；怎样改 |
| --- | --- | --- |
| `logo max width` | `0.15\textwidth` | 所有校徽的宽上限；整页 2.1cm，辅助区按局部 textwidth 求值 |
| `logo title height` | 0.82cm，8.2mm | Academic 封面校徽高上限；设 `9mm` |
| `logo panel height` | 0.62cm，6.2mm | Warm/Cool 封面浅色区校徽高上限；设 `7mm` |
| `logo footer height` | 0.34cm，3.4mm | standard 页脚校徽高上限；放大时一起检查页脚高度 |
| `building max height` | `0.20\paperheight`，1.8cm | 完整页面辅助建筑的高上限；宽上限为右栏行宽；设 `16mm` 更矮 |

这些是等比缩放的**上限**。图片先碰到宽上限时，单独提高 height 可能没有变化。它们不会改变图片的颜色或透明度，也不影响 frame 中另写 includegraphics 的正文插图。

### 12.5 封面、章节与致谢：16 项

| 键名 | 默认值 | 效果；怎样改 |
| --- | --- | --- |
| `title top` | `0.04\paperheight`，3.6mm | 三种封面顶部附加留白；设 `5mm` 增加 |
| `divider top` | `0.07\paperheight`，6.3mm | 章节和结束页顶部附加留白；设 `5mm` 减少 |
| `hero bottom` | `0.03\paperheight`，2.7mm | 完整页面底部附加留白；设 `3mm` |
| `identity width` | `0.72\textwidth`，10.08cm | Academic/Warm 顶部校名文字区宽；太窄会让英文校名换行 |
| `subtitle gap` | 0.6em | Academic/Warm 主副标题额外间距；设 `0.8em` |
| `title rule gap` | 1.2em | Academic/Warm 副标题后到短线的额外间距 |
| `hero rule width` | `0.18\textwidth`，2.52cm | Academic/Warm 封面及所有结束页短线长度；设 `3cm` |
| `hero rule thickness` | 1.5pt，约 0.527mm | 完整页面短线厚度；设 `2pt` 更粗 |
| `section rule width` | `0.08\textwidth`，1.12cm | 章节页短线长；设 `2cm` |
| `section rule gap` | 1em | 章节短线到章节标题间距；设 `1.2em` |
| `closing subtitle gap` | 0.5em | 中文致谢到第二行英文间距；en 模式没有第二行 |
| `closing rule gap` | 1em | 致谢文字到短线间距；设 `1.2em` |
| `cool title padding` | 0.6em | Cool 封面蓝色题名块四周内距；设 `0.8em` |
| `cool subtitle gap` | 0.4em | Cool 封面主副标题额外间距 |
| `hero padding` | 0.15cm，1.5mm | 完整页面底部辅助区内距；设 `2mm` |
| `hero column width` | `0.47\linewidth` | 辅助区左右两栏各占框内行宽 47%；不要超过 50% |

16:9 与默认边距下的换算只对表内绝对尺寸/页面比例成立。辅助区有内距和局部 minipage，不能把它的栏宽直接当成整页正文双栏的宽。Cool 封面题名块宽为正文宽，不用 identity width；Cool 封面也不用 hero rule width 的短线。

### 12.6 引文与重点：2 项

| 键名 | 默认值 | 效果；怎样改 |
| --- | --- | --- |
| `quotation padding` | 0.8em | HUASquotation 四周内距；设 `1em`，文字区域变窄 |
| `keypoint padding` | 1em | HUASkeypoint 结论框内距；设 `1.2em` |

原生 block 的内距不由以上两项决定。需要统一加大三种 block 边缘留白时，可在导言区加载主题后写：

```tex
\setbeamertemplate{block begin}[default][colsep*=1ex]
\setbeamertemplate{block alerted begin}[default][colsep*=1ex]
\setbeamertemplate{block example begin}[default][colsep*=1ex]
```

默认 colsep 为 0.75ex。三行分别控制普通、提醒、示例块；改变内距会增加块高。图注前后默认各 7pt，可在导言区改为：

```tex
\setlength{\abovecaptionskip}{4pt}
\setlength{\belowcaptionskip}{2pt}
```

这控制图注附近间距，不改变图片本身的宽高。

### 12.7 想把标题移动到某个位置时

封面使用 `\vfill` 分配剩余空间，是弹性布局。title top 的 3.6mm 是额外留白，**不是标题最终距离纸上沿 3.6mm**。标题换行、字号、作者行数和建筑高度都会改变实际位置。先调整题名长度、字体和留白，再编译；不要把当前主题当成按固定坐标拖拽的 PPT。

三处更细的对齐还留在源码中：inner 主题的 Academic 校徽 `\raisebox{-0.12cm}` 和 `\hspace{0.8em}`；Warm 校徽 `\raisebox{-0.15cm}` 和 `\hspace{0.4em}`；outer 主题页脚校徽前 `\hspace{0.5em}`。负 raisebox 下移，正值上移。这些已有中文注释，确需修改时先备份对应文件；它们会影响共享该主题的所有演示。

### 12.8 每次改尺寸后的检查

先改一项、编译两遍、看变化，再改下一项。检查长标题、页脚机构、校徽、最密集的正文页；参数不自动修复负数、过大宽高或互相挤压的组合。拼错键名会明确报 PGF 错误。所有尺寸都要写合法单位，例如 `3mm`，不要裸写 `3`。

<a id="step-13"></a>
## 13. 中文字体、字号、颜色和固定文字

### 13.1 当前默认字体

标题、章节、内容块小标题、重点句和页脚用黑体；正文、副标题、引文和图注用宋体体系。本机 Windows 正文为 SimSun，标题优先 SimHei；SimHei 没有原生粗体，因此主题为标题设置轻度模拟加粗。没有该字体时沿用 ctex 的黑体族。项目不下载或分发系统字体。

想整体放大，从类选项开始：

```tex
\documentclass[aspectratio=169,12pt]{ctexbeamer}
```

这句**替换原 documentclass**，不要再添加第二个 documentclass。更大文字可能让段落多一行、让正文溢出，重新检查每页。

### 13.2 只改某一类文字

在导言区加载主题后写：

```tex
\setbeamerfont{frametitle}{size=\Large}
\setbeamerfont{quotation}{size=\large}
\setbeamerfont{title}{size=\fontsize{18pt}{22pt}\selectfont}
```

第一行改普通页标题；第二行改引文；第三行改封面主标题，18pt 是字号，22pt 是基准行距。三行可只保留需要的一行。正文整体更大优先用类选项；单段更小用第 7 节的局部 small。

| 字体角色 | 页面上具体哪里 | 默认字号命令 |
| --- | --- | --- |
| `title` | 封面主标题 | LARGE |
| `subtitle` | 封面副标题、结束页英文第二行 | normalsize |
| `frametitle` | 普通内容页标题 | large |
| `section title` | 章节大标题 | LARGE |
| `HUAS closing title` | 致谢大标题 | LARGE |
| `HUAS key point` | 重点页结论 | LARGE |
| `normal text` / `block body` | 普通正文 / 内容块正文 | normalsize |
| `block title` | 三种内容块的小标题 | normalsize |
| `quote` / `quotation` | 普通引文 / 带出处引文 | normalsize |
| `HUAS source` | 引文出处与示例中的图片来源 | scriptsize |
| `HUAS school name` | 封面中文校名 | normalsize |
| `HUAS english name` | 封面英文校名 | scriptsize |
| `HUAS title meta` | 作者、机构、日期 | small |
| `HUAS section label` | 章节和结束页顶部校名 | small |
| `HUAS motto` | 完整页面辅助区校训 | scriptsize |
| `footline` | 页脚文字及 Cool 页眉文字 | scriptsize |
| `caption` / `caption name` | 图注文字 / 图表编号标签 | small / 继承图注并加粗 |
| `bibliography entry author/title` | 文献作者 / 题名 | small |
| `bibliography entry location/note` | 文献出版项 / 注记 | scriptsize |

最后两行实际角色名分别为 `bibliography entry author`、`bibliography entry title`、`bibliography entry location`、`bibliography entry note`，不要把斜杠形式作为一个角色名输入。

在默认 11pt 类字号下，normalsize 实际为 10.95pt，small=10pt，scriptsize=8pt，large=12pt，Large=14.4pt，LARGE=17.28pt。命令大小写有区别。改用 12pt 类选项后这些值会随类配置改变；屏幕上字面高度也不等于字号的毫米换算。

改 footline 字体会同时影响 Cool 页眉与普通页脚，要同步检查 height/depth。普通图源若写的是局部 `\scriptsize`，不会跟随 HUAS source 角色；以对应示例源码为准。

### 13.3 想换具体字体时

只换 Windows 正文为宋体，可在导言区加载主题后使用 `\setCJKmainfont{SimSun}[BoldFont=SimHei]`，前提是电脑确实装有这些字体。标题已显式选用主题黑体，仅修改 CJK sans 字体并不能让全部标题跟随。

需要自行选标题字体时，下面是**可选导言区片段**，不要在没有这些字体的系统直接粘贴：

```tex
\newCJKfontfamily\myHeading[AutoFakeBold=2]{SimHei}
\setbeamerfont{title}{family={\sffamily\myHeading}}
\setbeamerfont{frametitle}{family={\sffamily\myHeading}}
\setbeamerfont{section title}{family={\sffamily\myHeading}}
```

将 SimHei 换为已安装字体的真实名称，三行只改变对应角色；其他块、页脚、结束页不会自动全部跟随。全套角色需按上表分别设置。AutoFakeBold 数值越大笔画越厚，真实投影后再判断，避免为了显眼而过粗。

### 13.4 调整颜色

颜色令牌是一套有名字的颜色。下表为项目推导色，不是学校官方标准。

| 令牌 | 六位 HTML 色值 | 当前作用 |
| --- | --- | --- |
| `HUASRed` | A34A42 | Academic/Warm 强调、Warm 完整页面背景、提醒块 |
| `HUASTerracotta` | B76F4F | 预留陶土色，不自动给图片改色 |
| `HUASInk` | 292929 | 深色正文 |
| `HUASMuted` | 666666 | 辅助文字 |
| `HUASPaper` | FFFFFF | 浅色正文底、暖色封面辅助区底 |
| `HUASWarmPaper` | F8F4EF | Academic 章节/结束页、辅助区 |
| `HUASLine` | E5DDD8 | Academic/Warm 普通标题下细线 |
| `HUASBlue` | 3333B2 | Cool 标题栏与强调 |
| `HUASNavy` | 191959 | Cool 页眉、页脚及深色身份文字 |
| `HUASCoolPaper` | E9E9F3 | Cool 章节/结束页和辅助区 |

例如把蓝色改得更沉稳，在导言区主题加载后写：

```tex
\definecolor{HUASBlue}{HTML}{245A81}
\definecolor{HUASNavy}{HTML}{16364E}
\HUASsetup{style=cool}
```

`HTML` 后花括号填六位色值，不写前面的 `#`。改令牌后再调用 setup，让派生强调色同步刷新。之后若又调用其他 style，就以最后选择的样式为准。

只改普通标题栏可在配置最后写 `\setbeamercolor{frametitle}{fg=white,bg=HUASBlue}`，fg 是文字颜色，bg 是背景。颜色令牌不改变 PNG 图片像素；建筑需要改色时只从原素材另存颜色版本，再通过图片接口加载。

内容块的浅色底由强调色与白色混合得到，默认普通块正文 `!8`、引文/重点框 `!6`、示例块标题 `!18`、正文 `!4`。比例在 color 主题中，可搜索对应角色修改；需要这些低层调整时备份文件并保留源码注释。

### 13.5 修改校名、校训和致谢固定字样

个人题目和作者只改自己的 `.tex`。下面属于共享主题固定文字，修改后会影响所有使用者：

| 想改什么 | 文件及搜索词 | 操作 |
| --- | --- | --- |
| 中文固定校名 | `theme/huas-config.tex`，搜索 `schoolname` | 改宏内中文文字，保留 zh/en 判断和花括号 |
| 英文固定校名 | 同上，搜索 `schoolsecondary` | 改英文名称；长文字检查封面换行 |
| 中文校训 | 同上，搜索 `motto` | 改中文分支文字，保留条件结构 |
| “谢谢聆听” / “Thank you” | `beamerinnerthemeHUAS.sty`，搜索 `HUAS closing page` | 修改对应文字，不删除 if/else/fi 或模板边界 |

在编辑器按 Ctrl+F 搜索即可。改前复制原文件备份，改后编译四份示例。这些字符串当前没有全部开放为单独 setup 参数；不要随意臆造 `motto=...` 或 `closing=...`，它们会报未知键。

<a id="step-14"></a>
## 14. 四份现有模板具体怎么改

### 14.1 从哪一份开始

| 模板 | 优先修改的内容 | 独立操作说明 |
| --- | --- | --- |
| `main.tex` | 五项封面信息、一个 section、列表、双栏插图路径及来源 | [逐页最小模板指南](templates/main.md) |
| `examples/academic-demo.tex` | 研究问题、三步方法、比例公式、分析表格、结论、参考资料 | [逐页 Academic 指南](templates/academic.md) |
| `examples/seminar-demo.tex` | 引文原文与出处、双栏细读、讨论流程、反思重点 | [逐页 Warm 指南](templates/seminar.md) |
| `examples/cool-demo.tex` | 三个 section 和目录、三种块、引文、教学任务、图表、代码、文献 | [逐页 Cool 指南](templates/cool.md) |

想保留原示例，可在编辑器中“另存为”根目录 `my-talk.tex` 后修改。仍保留 `\input{examples/local-assets.tex}` 时图片条件加载有效，因为从根目录编译。个人文件用第 4 节的手动命令；脚本不会自动寻找新文件。

### 14.2 四套具体尺寸差异

- 所有模板：纸张 16×9cm，默认正文宽 14cm；标题栏宽 16cm、padding 1.5mm；页脚 width=16cm，height=2.5ex、depth=1.2ex。
- 最小模板双栏：左 7.28cm、右 6.02cm，剩余 0.70cm；左/右比例分别 0.52/0.43。占位框内部高 2.8cm、宽右栏的 90%。
- Academic 表格：`lll` 自然宽，行高系数 1.5；每个单元格的文字与列内距共同决定宽度，不能按固定 cm 计算总宽。
- Warm 双栏：各 6.58cm，剩余 0.84cm；比例各 0.47。封面校徽用 panel height，不是 title height；默认 minimal 页脚不显示机构与校徽。
- Cool 双栏：各 6.72cm，剩余 0.56cm；比例各 0.48。正文图片宽 9.1cm，缺图占位内部宽 8.4cm、高 2.2cm；代码 frame 必须 fragile；表格行高系数 1.4。

Cool 普通内容页有深蓝页眉、蓝色标题栏和深蓝页脚三个区域；其余两种样式没有深蓝章节页眉。三套完整封面/章节/结束页均不显示普通栏。共享辅助区建筑默认高上限 1.8cm，图片宽高还受比例和栏宽限制。

### 14.3 按什么顺序替换内容

1. 另存个人文件，编译确认复制完整。
2. 改五项封面信息与 faculty，再编译。
3. 改 section；第二遍后看目录。
4. 按逐页指南替换正文，不把示例研究描述当成自己的真实结果。
5. 替换图片时同时修改检测路径、加载路径、图注和来源。
6. 最后调字号、颜色和尺寸；每次只改少量设置。

源码中的 `%` 注释说明关键位置。取消注释的修改示例可能同时改变多个参数，第一次只启用你需要的一项。不要将分享用的题名、作者和日期填入共享主题源码。

<a id="step-15"></a>
## 15. 编译失败时怎样排错

### 15.1 看第一条错误，先恢复到可编译状态

编译成功通常会出现 `Output written on ...pdf`；脚本也会打印 PDF 路径。失败时旧 PDF 可能还在，能打开旧 PDF 不等于新源码编译成功。看终端或 `.log` 中第一条以 `!` 开始的错误及附近 `l.数字` 的源行位置。

在编辑器找到这行，同时检查上一行：漏括号常常到下一行才报错。先撤销最近一次修改，确认恢复成功，再逐项加回。不必把所有问题同时修，也不必一遇错误就添加宏包。

### 15.2 常见错误对照

| 看到的提示或现象 | 常见原因 | 具体处理 |
| --- | --- | --- |
| 不识别 `xelatex` | 程序未装或不在 PATH | 第 2 节用完整路径验证，再配置 Path |
| 禁止运行脚本 | PowerShell 执行策略 | 第 3.3 节直接运行 XeLaTeX |
| `beamerthemeHUAS.sty not found` | 未从根目录编译，或只拷贝个人 tex | 回到含五个主题文件的根目录；恢复完整工程 |
| `theme/huas-config.tex not found` | theme 目录缺失或工作目录错误 | 恢复四个模块，从根目录编译 |
| `ctexbeamer.cls not found` | TeX 安装缺 ctex/Beamer 等包 | 用 TeX Live Manager 检查并安装缺失包；不要下载不明同名文件塞进工程 |
| fontspec 要求 XeTeX/LuaTeX | 用错为 pdfLaTeX | 本工程选择 XeLaTeX |
| `The font ... cannot be found` | 指定了本机没有的字体 | 删掉自定义字体设置或换已安装字体；跨平台见第 16 节 |
| `I do not know the key ...` | setup/layout 键拼错或值无效 | 对照键表，用小写英文和半角符号；如 height 不写成 heigth |
| `Can be used only in preamble` | 配置放在 document 内 | 把 setup/setlayout 移到 begin document 前 |
| `Missing $ inserted` | 普通正文含未转义 _，或数学标记不成对 | 普通下划线写 `\_`；检查美元号与数学区域 |
| `Misplaced alignment tab character &` | 表格外写了裸 & | 普通文字用 `\&`，表格内确认列数正确 |
| `Runaway argument` / 找不到 end | 花括号、环境或 fragile 使用错误 | 检查 begin/end 与括号成对；verbatim 页加 fragile |
| `File ... not found` | includegraphics 路径、扩展名、大小写不一致 | 确认文件真实存在，路径从根目录写起，用 `/` |
| Logo/Building image not found 警告 | 自定义装饰图路径不存在 | 修正路径或关闭该图；该警告通常不会阻止 PDF 生成 |
| `Overfull \hbox` | 长行、表格、图片超过横向空间 | 拆长行、调整栏宽/图片宽；优先拆内容，不随意缩到极小字号 |
| `Overfull \vbox` | 一页内容超过可用高度 | 拆页，检查页眉页脚高度、图片高和字号 |
| `Underfull ...` | 行间/段落空白分配不理想 | 查看对应页面；不是必然编译失败，避免强制断行过密 |
| 引用问号、目录缺项 | 尚未编译第二遍或键不匹配 | 两遍成功后仍异常再查 cite/label/section 拼写 |
| PDF 无法写入 | 某些查看器锁住 PDF | 关闭该 PDF 后重新编译 |
| PDF 文字没变 | 未保存、编错文件或打开旧路径 | 核对个人源文件、输出路径与保存状态 |

### 15.3 一个漏括号的例子

错误写法：`\title{我的汇报`。正确写法：`\title{我的汇报}`。错误写法中编译器会继续找结束花括号，之后很多正常文字都可能被当成题名参数，所以报错行不一定恰好在 title 那一行。

### 15.4 需要重新生成辅助文件时

源码已修好但目录/引用仍受旧状态影响时，可把个人输出目录改成一个新目录，重新编译两遍，例如 `build/my-talk-fresh`；先创建它，两行 output-directory 都一致。这样保留旧成品且不需要删除工程文件。

平时只应清理明确的构建目录，不要删除 theme、assets 或个人 `.tex` 来“清缓存”。求助时给出编译命令、第一条错误和附近源码，说明从哪个目录执行；只发“出错了”无法定位。

<a id="step-16"></a>
## 16. 交付成品、迁移与 Overleaf

### 16.1 给别人看演示

最终检查输出 PDF 后，把 PDF 另存为易识别的成品名即可，接收者通常无需安装 LaTeX。放映软件打开 PDF，进入其全屏/演示模式；具体快捷键依查看器而定。最后逐页确认题目、作者、日期、目录、页码、公式、文献和图片来源，在实际投影上确认字号与细线对比。

### 16.2 给别人继续编辑

最小可编辑副本需要：

- 你的个人 `.tex` 文件。
- 根目录五个 `beamer*themeHUAS.sty`。
- `theme/huas-config.tex`、`huas-layout.tex`、`huas-assets.tex`、`huas-content.tex`。
- 个人文件实际 input 的其他文件，例如 `examples/local-assets.tex`。
- includegraphics/setlogo/setbuilding 指向的实际图片；图片没有时只有有条件分支或装饰加载器能回退。
- `LICENSE`、`NOTICE.md` 与相关说明。

保留相对目录结构；普通使用不需要 references、研究 PDF、TeX Live 安装文件和 build 日志。源码许可证不自动授权学校校徽等素材的再分发，详见 NOTICE。若只从 Git 下载代码，研究图片不会自动出现。

### 16.3 Linux、macOS、Overleaf 的字体准备

它们不一定有 SimSun/SimHei。可以将第一行改为：

```tex
\documentclass[aspectratio=169,fontset=fandol]{ctexbeamer}
```

ctex 会使用 TeX Live 自带的 Fandol 字体集作为跨平台准备方案。不要同时保留 Windows 专用 `\setCJKmainfont{SimSun}` 或本手册可选的 `\myHeading` 定义。本轮可在本机验证 Fandol 字体选项编译，但这不等于在其他平台或云端已经测试；平台字体和布局可能不同。

### 16.4 Overleaf 的操作路线

1. 按 16.2 准备源码副本，个人入口文件放上传项目最上层，保留 theme 和素材路径。
2. 新建 Overleaf 项目并上传文件；不要把全部源码嵌在额外一层无关文件夹中而不调整主文件。
3. 在项目设置中将主文档选为个人入口，如 `my-talk.tex`。
4. 将 Compiler 选为 **XeLaTeX**，必要时选择项目需要的 TeX Live 版本；选择方法见 [Overleaf 官方编译器说明](https://docs.overleaf.com/getting-started/recompiling-your-project/selecting-a-tex-live-version-and-latex-compiler)。
5. 使用上一节 Fandol 类选项，清理 Windows 专用字体名及磁盘绝对路径。
6. 重新编译，检查全部 PDF 页；云端不用 PowerShell 构建脚本。

这是根据项目结构与官方编译器说明给出的准备路线，尚未在 Overleaf 账号内实测。Linux 类文件系统对大小写敏感，`Photo.png` 与 `photo.png` 不应混用。相同源码在不同字体下的换行可能不同，迁移后要重新看成品。

<a id="step-17"></a>
## 17. 从最小练习到个人报告

### 17.1 五个练习和完成标志

| 练习 | 操作 | 完成时看到什么 |
| --- | --- | --- |
| 1 改封面 | 把 starter 的张三换成自己，固定日期换成汇报日期 | 封面信息变了，正文不变 |
| 2 加页面 | 第 6.1 节片段粘到致谢前 | PDF 多一页；正文总页数从 3 变 4 |
| 3 改样式 | academic 改 cool | 普通页有深蓝页眉、蓝色标题栏和深蓝页脚 |
| 4 放图片 | 建 photo.png，粘第 9.4 节图片页 | 显示真图和图注；暂不放图时显示占位框 |
| 5 精确调参 | 页眉设 3mm+1.3mm，页脚设 3.5mm+1.3mm | Cool 栏位按设定增加，检查最密集页仍能容纳内容 |

每次改完保存并成功编译两遍，再进入下一练习。图片页的来源文字必须由你改成真实来源；示例内容只是结构教学材料。

### 17.2 常用修改速查

| 我要做什么 | 找哪里 / 用什么 |
| --- | --- |
| 改封面题目、姓名、日期 | 导言区 title、author、date |
| 改页脚机构 | faculty；空时 institute 的短名 |
| 换蓝色或暖色 | setup 的 style=cool / warm |
| 只显示页码 | footer=minimal |
| 关章节大页但保留目录 | sectionpage=false，保留 section |
| 添加普通页 | 复制完整 begin frame～end frame |
| 插重点页 | frame 外的 HUASkeypoint |
| 换装饰图片 | setlogo/setbuilding；放在 local-assets input 后 |
| 改正文图片 | 该页 includegraphics 及检测路径、图注、来源 |
| 改页眉宽高 | headline width/height/depth，仅 Cool |
| 改普通标题栏留白 | frametitle padding，不是总高度 |
| 改页脚宽高 | footline width/height/depth |
| 改两栏宽度 | 正文 column 参数，不是 hero column width |
| 改中文标题字号 | setbeamerfont 的 title/frametitle/section title |
| 改正文整体字号 | documentclass 加 12pt，检查所有页 |
| 找成品和错误日志 | build 下相应输出目录 |

### 17.3 交付前的逐页检查

确认五项封面信息、目录条目、正文顺序和文献来源；核对图片路径与真实图源，删除练习占位文字；检查字号、换行、表格、代码和页脚没有裁切。最后保存、两遍成功编译，用刚生成的 PDF 放映。需要修改时继续编辑个人 `.tex`，再重新生成 PDF。

## 本手册验证范围

本手册的完整 starter 与标记为 `tutorial:*` 的正文教学片段已从文档直接提取后编译：starter 为 6 页，组件合集在三种样式下各为 19 页，均连续两遍成功；毫米布局、块内距、图注间距和颜色示例也已组合验证。全部 34 项尺寸键与文档链接已核对，详细结果见[总评的复核记录](development-overview.md)。图片路径 photo.png 是教学文件名；无该文件的图片页使用明确占位，不声称显示真实素材。安装、编辑器界面和 Overleaf 上传步骤依据官方说明整理，未进行全新安装或真人新手试用。
