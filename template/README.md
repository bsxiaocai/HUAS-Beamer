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

推荐 **XeLaTeX**（TeX Live 2025 已验证）：

```bash
xelatex HUAS-Beamer.tex
bibtex  HUAS-Beamer
xelatex HUAS-Beamer.tex
xelatex HUAS-Beamer.tex
```

一键编译全部四版：`make`（Linux/macOS）或 `makebeamer.bat`（Windows）。
Overleaf 用户选择 XeLaTeX 编译器即可直接使用。

## 主题选项

```latex
\usepackage{huasbeamer}                % 中文暖色调（默认）
\usepackage[blue]{huasbeamer}          % 冷色调（蓝白）版本
\usepackage[en]{huasbeamer}            % 英文模式
\usepackage[notoc]{huasbeamer}         % 关闭节前自动目录页
\usepackage[subsectiontoc]{huasbeamer} % 小节前也出目录页
\usepackage[nonav]{huasbeamer}         % 关闭底部翻页控件
```

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
| `\huassetbadge{...}` | 替换校徽图片 |
| `\tocbackground` | 目录页背景线稿（可改/可删） |
| `\huastableheader` | 表格彩色表头行（配套 `\huastableheaderfont`） |
| `\setframeofframes{--}` | 修改页码分隔符（默认 `/`） |

主题色定义于 `huasbeamer.sty` 顶部：`huasred`、`huasdeep`、`huasorange`、
`huascoral`、`huasgold`、`huascream`、`huasbg`（页面底色）。

## 编译要求

- TeX Live 2025 / MiKTeX（含 ctex、tikz、booktabs、listings、newtxmath）
- 中文字体默认 fandol（随 TeX Live 发行）；Windows 用户可在
  `huasbeamer.sty` 中改为 `fontset=windows`（见自定义说明文档）
