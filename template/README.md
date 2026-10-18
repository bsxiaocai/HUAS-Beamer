# HUAS-Beamer 使用说明（模板包内速查）

湖南文理学院（Hunan University of Arts and Science）LaTeX Beamer 模板。

## 文件结构

```
template/
├─ huasbeamer.sty              # 主题样式（配色/封面/页眉页脚/目录页）
├─ HUAS-Beamer.tex             # 中文演示（暖色调）
├─ HUAS-Beamer-EN.tex          # 英文演示（暖色调）
├─ HUAS-Beamer-Blue.tex        # 中文演示（冷色调蓝白）
├─ HUAS-Beamer-Blue-EN.tex     # 英文演示（冷色调蓝白）
├─ reference.bib               # 参考文献示例
├─ figures/                    # 校徽、校标、建筑线稿素材
├─ Makefile / makebeamer.bat / .latexmkrc
└─ HUAS-Beamer*.pdf            # 四版编译成品
```

## 编译方法

中英文四版均须使用 **XeLaTeX**，不能使用 pdfLaTeX。当前源码在 Windows / TeX Live 2026 下
完成四版编译验证（四版各 28 个 PDF 页面，结构一致；页数随内容和分步显示变化）。

先切换到 `template/` 目录。推荐使用本目录 `.latexmkrc`：

```bash
latexmk HUAS-Beamer.tex
```

latexmk 会运行 XeLaTeX、按需调用 BibTeX，并重复编译以稳定目录和引用。
也可手动运行：

```bash
xelatex HUAS-Beamer.tex
bibtex  HUAS-Beamer
xelatex HUAS-Beamer.tex
xelatex HUAS-Beamer.tex
```

其他版本替换文件名即可；BibTeX 参数不带 `.tex`。一键编译与清理：

| 场景 | 在 `template/` 下执行 |
| --- | --- |
| 编译全部四版（Linux/macOS） | `make`；强制重编已有 PDF 用 `make -B` |
| 编译单版（Linux/macOS） | `make HUAS-Beamer-EN.pdf` |
| 编译全部四版（Windows PowerShell） | `.\makebeamer.bat` |
| 编译单版（Windows PowerShell） | `.\makebeamer.bat HUAS-Beamer-Blue-EN` |
| 保存源码后持续构建 | `latexmk -pvc HUAS-Beamer.tex` |
| 清理辅助文件，保留 PDF | `latexmk -c HUAS-Beamer.tex`；Linux/macOS 也可用 `make clean` |
| 删除四版 PDF 及辅助文件 | Linux/macOS 的 `make distclean`（会删除成品） |

Windows 批处理在结束时清理当前目录的 LaTeX 辅助文件并暂停。
需要排错或保留日志时，使用 latexmk 或手动命令；不要在存有其他项目辅助文件的目录执行该批处理。
Makefile 按文件时间判断是否重编译；仅替换图片后可用 `make -B` 或 latexmk 构建。
Overleaf 用户选择 XeLaTeX 编译器即可直接使用。

## 主题选项

```latex
\usepackage{huasbeamer}                % 中文暖色调（默认）
\usepackage[blue]{huasbeamer}          % 冷色调（蓝白）版本
\usepackage[en]{huasbeamer}            % 英文模式
\usepackage[notoc]{huasbeamer}         % 关闭节前的节标题页与目录页
\usepackage[subsectiontoc]{huasbeamer} % 小节前也出目录页
\usepackage[nonav]{huasbeamer}         % 关闭底部翻页控件
```

选项可组合，如 `[blue,en]`。`[en]` 不加载 ctex，但会加载 xeCJK 支持中文参考文献，
并不会翻译正文或文献。`[subsectiontoc]` 独立于 `[notoc]`；两者同时使用仍会生成小节前目录。

## 开始自己的汇报

复制一个 `.tex` 示例并保存在本目录，修改封面信息及正文；可用
`latexmk 我的汇报.tex` 编译自定义文件名。迁移到独立目录时，一并复制
`huasbeamer.sty`、`figures/`、`reference.bib` 和 `.latexmkrc`。
示例人名、日期和参考文献不代表真实汇报资料，使用前请替换并核实。

VS Code 配方和高亮排错见[项目主页](../README.md#vs-code-配置与排错)。
`.vscode/` 与个人全局设置均不随仓库分发；不使用编辑器配置也能通过终端编译。

页脚信息自动读取导言区设置：汇报人 `\author`、标题 `\title`（均显示方括号短标题）、
单位 `\institute`；汇报时间默认为编译日期，可用 `\reportdate{2025 年 6 月 10 日}` 固定。

> **全部可调整项**（内容填写、颜色、尺寸、图片、字体）详见
> [`docs/模板使用与自定义说明.md`](../docs/模板使用与自定义说明.md)。

## 自定义

| 命令 | 作用 |
| --- | --- |
| `\title / \author / \institute / \date` | 封面信息（方括号内为页脚短标题） |
| `\supervisor{...}` | 封面导师行（可选，独立于 `\author`） |
| `\reportdate{...}` | 固定页脚汇报时间（默认编译日期） |
| `\huassetlogo{...}` | 替换封面校标图片 |
| 封面校徽 | 在 `huasbeamer.sty` 的 `title page` 中搜索并替换 `huas-badge-v2.png` |
| `\tocbackground` | 目录页背景线稿（可改/可删） |
| 目录条目圆圈/字号 | 在 `huasbeamer.sty` 搜索 `ball color`（圆圈颜色与大小）/ `section in toc`（字号） |
| `\huastableheader` | 表格彩色表头行（配套 `\huastableheaderfont`） |
| `\setframeofframes{--}` | 修改页码分隔符（默认 `/`） |

主题色定义于 `huasbeamer.sty` 顶部：`huasred`、`huasdeep`、`huasorange`、
`huascoral`、`huasgold`、`huascream`、`huasbg`（页面底色）。

`\huassetbg{...}` 可替换封面水印。当前 `\huassetbadge`、`\huassetdeco` 只保存文件名，
尚未被版式读取；调用它们不会改变现有校徽或装饰。

## 编译要求

- XeLaTeX、BibTeX；使用自动构建时还需 latexmk 及其 Perl 运行环境。
- 主题依赖 beamer、fontspec、xeCJK、ctex（中文模式）、tikz（含 shadings 库，目录圆圈用）、
  amsmath、amssymb、amsthm、booktabs、colortbl、newtxmath；示例另外加载 listings、multicol、multirow。
- 中文字体显式使用 Fandol（随 TeX Live 提供）；中文正文为黑体、斜体用楷体、节页标题为宋体。
- 西文主字体优先使用 Times New Roman，字体不存在时回退 TeX Gyre Termes；数学使用 newtxmath。
- 更换字体需修改 `\setCJKmainfont` 等对应命令，不能只改 ctex 的 `fontset`，
  详见[自定义说明第 7 节](../docs/模板使用与自定义说明.md#7-字体)。
