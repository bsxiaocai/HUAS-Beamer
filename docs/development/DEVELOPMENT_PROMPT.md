# HUAS-Beamer 项目开发总纲

你正在协助我从零开发一个长期维护的开源项目：

**HUAS-Beamer — A LaTeX Beamer Theme for Hunan University of Arts and Science**

HUAS 指湖南文理学院（Hunan University of Arts and Science）。

这不是一次性生成一份 PPT，而是建立一套可复用、可维护、可扩展的湖南文理学院学术演示主题。请始终把它作为一个正式软件项目和设计系统开发，而不是简单“换 Logo”的高校 Beamer 模板。

---

## 一、总体目标

最终希望实现：

1. 基于 LaTeX Beamer 构建湖南文理学院通用学术演示模板；
2. 默认面向 16:9 学术展示，主要使用 XeLaTeX，完善中文支持；
3. 形成统一的 HUAS 视觉语言，而非简单复制学校现有 PPT；
4. 支持学术汇报、研究生交流、读书分享、课程展示、教学设计、技术分享等场景；
5. 具有清晰的模块化架构，颜色、字体、页面布局和学校视觉元素相互分离；
6. 用户能够通过简单接口切换样式，而无需修改主题源码；
7. 能够长期维护、版本化、Git 管理，并最终公开发布到 GitHub；
8. 后期应具备扩展学院级主题、更多页面组件以及 Overleaf 使用的可能。

当前已经掌握的 HUAS 视觉素材包括：

- 湖南文理学院校徽；
- 中文书法校名；
- 英文名称 Hunan University of Arts and Science；
- HUAS 标识；
- 校训“博学弘文，明理求真”；
- 校旗；
- 文法学院等二级单位 Logo 组合样式；
- 多份学校官方活动、招生材料、会议 PPT 中长期重复出现的校园建筑线稿；
- 图书馆、主楼、校园建筑群等线稿视觉元素。

目前没有找到公开的完整 HUAS VI 手册，因此所有从现有官方材料中推导出的颜色、字体和设计规则，都应称为 **HUAS-Beamer Derived Design System**，不得擅自宣称为“学校官方标准”。

---

## 二、设计方向

HUAS-Beamer 的核心设计概念为：

**Humanistic Expression × Rational Structure**
**人文表达 × 理性结构**

建议将学校已有视觉元素提炼为：

- 校徽与校名：Primary Identity；
- 校园建筑线稿：Secondary Graphic；
- HUAS 暖红、朱红、陶土橙等：Derived Color Palette；
- 白色、深灰、黑色：主要学术内容色；
- 校训书法：少量用于封面、章节页和结束页。

避免：
- 满屏校徽；
- 传统政务 PPT 式大面积红黄；
- 复杂渐变、粒子、装饰背景；
- 为了“学校特色”牺牲学术可读性。

初期至少规划两种视觉模式：

**Academic Light**
白色/浅色背景，深色正文，以 HUAS Red 作为强调色，适合普通学术汇报。

**HUAS Warm**
暖红或陶土橙背景，白色文字和建筑线稿，适合封面、章节页和活动展示。

第一版不必一次实现所有模式，但架构必须允许以后加入。

---

## 三、必须持续参考的现有项目

开发过程中不要凭记忆自行设计 Beamer 架构。每进入一个新的功能模块，都应主动阅读成熟项目对应实现，再决定 HUAS-Beamer 的实现方式。

重点参考：

### 1. SJTUBeamer
https://github.com/sjtug/SJTUBeamer

重点学习：
- 完整主题系统架构；
- theme option；
- inner / outer / color / font theme 的划分；
- title page、section page；
- 用户接口；
- 文档和示例组织方式。

它是 HUAS-Beamer 在“工程化和长期维护”方面最重要的参考项目。

### 2. USTC Beamer
https://github.com/ustctug/ustcbeamer

重点学习：
- 如何把学校官方 PPT / VI 视觉元素转译为 Beamer；
- TikZ 图形实现；
- 校园视觉元素与主题色组织方式。

尤其参考其“学校视觉 → LaTeX 元素”的思路。

### 3. ZJU Beamer Template
https://github.com/qychen2001/ZJU-Beamer-Template

重点学习：
- 相对轻量的项目结构；
- 中文、XeLaTeX；
- assets、figures 与主题文件的组织；
- 如何在工程化和简洁之间取得平衡。

### 4. THU-Beamer-Theme / thubeamer
https://github.com/tuna/THU-Beamer-Theme
以及成熟的清华 Beamer 实现。

重点学习传统高校 Beamer 模板的基础组成。

### 5. NJU Beamer 等高校二次开发项目

重点研究：
- 一个高校主题是如何基于其他主题演化出来的；
- 哪些设计只是“换 Logo / 换颜色”，HUAS-Beamer 应避免这种做法。

### 6. Metropolis
参考其：
- 留白；
- 信息层级；
- 极简设计；
- 对视觉噪声的控制。

不得直接大段复制其他项目代码。借鉴实现前注意其 LICENSE，并尽量理解实现原理后重新设计 HUAS 对应模块。

---

# 四、开发原则

整个开发过程必须遵守以下规则：

1. **先实现最小可运行版本，再逐渐扩展。**
2. 每次只完成一个明确功能，不进行无关重构。
3. 每次修改后必须实际使用 XeLaTeX 编译示例。
4. 编译失败必须读取日志、分析原因并修复，不能只声称“理论上可以运行”。
5. 优先使用 Beamer 自身机制，不无意义引入大量 package。
6. 添加新依赖前说明用途。
7. 不要把所有代码塞进一个巨大的 `.sty`。
8. 避免大量难以维护的绝对坐标和 magic numbers。
9. 公共接口与内部实现分离。
10. 图片和学校视觉素材必须放在 assets 中，不直接散落于源码目录。
11. 用户内容与主题实现分离。
12. 保持 Windows + XeLaTeX 开发环境可用，并尽量兼顾 Linux、macOS、Overleaf。
13. 每阶段完成后检查 Git diff，确认没有非预期修改。
14. 不要一次生成数千行代码；采用可验证的渐进开发。
15. 在重要架构选择前，应先对比上述项目的相关实现。

---

# 五、阶段开发计划

## Phase 0：研究与最小环境

首先检查本机开发环境和当前目录，不要直接生成大量代码。

建立最小项目：

HUAS-Beamer/
- main.tex
- README.md
- theme/
- assets/
- examples/
- docs/

第一阶段只需要实现：

- `ctexbeamer`
- XeLaTeX
- 16:9
- `\usetheme{HUAS}`
- 一个标题页
- 一个普通 frame
- 最基础主题色

目标只有一个：

**成功生成第一个可正常打开的 PDF。**

不要在此阶段加入复杂 TikZ、建筑线稿、动画、学院支持等功能。

---

## Phase 1：建立 HUAS Theme Core

在最小版本稳定后，将主题逐步拆分为标准 Beamer 结构：

- `beamerthemeHUAS.sty`
- `beamercolorthemeHUAS.sty`
- `beamerfontthemeHUAS.sty`
- `beamerinnerthemeHUAS.sty`
- `beamerouterthemeHUAS.sty`

重点参考 SJTUBeamer 的组织方式，但避免第一版过度工程化。

实现：

- HUAS derived color tokens；
- 基础字体体系；
- frametitle；
- footer；
- frame number；
- Logo asset loader；
- 基础 theme option。

完成后编译验证。

---

## Phase 2：建立核心视觉页面

依次实现，不要一次完成：

1. Title Page
2. Section Page
3. Standard Content Frame
4. Two-column / Image Frame
5. Closing / Thank You Page

加入：

- HUAS 校徽；
- 中文校名；
- 英文名称；
- 适度使用校训；
- 校园建筑线稿。

建筑线稿应该作为辅助图形，而不是正文背景噪声。

建议建立：

assets/
- logo/
- lineart/
- images/

此阶段重点参考 USTC Beamer 如何处理学校视觉资产。

---

## Phase 3：视觉模式与配置接口

当基础主题稳定后，再建立用户配置接口，例如：

`\HUASsetup{...}`

未来可支持：

- style = academic / warm
- logo = true / false
- footer = minimal / standard
- sectionpage = true / false
- faculty = ...
- language = zh / en

第一版不要求全部实现，但接口设计必须考虑未来扩展，避免用户直接修改主题源码。

---

## Phase 4：学术内容组件

基础视觉体系稳定后再逐步增加：

- quote / quotation；
- bibliography；
- image caption；
- table；
- code；
- block / alert block；
- research workflow；
- literature reading；
- text close reading；
- teaching case；
- key point page。

其中代码页和文学文本页应针对 HUAS 的“Arts and Science”定位进行良好适配。

不要为了数量制造大量低价值环境。

---

## Phase 5：工程化、Demo 与文档

建立：

- `examples/academic-demo.tex`
- `examples/seminar-demo.tex`
- 后续可增加 teaching / tech demo。

README 至少包含：

- 项目简介；
- 编译要求；
- 最小使用示例；
- HUAS Theme 使用方法；
- 项目状态；
- 视觉素材说明；
- 非官方声明。

README 应明确：

HUAS-Beamer 是基于公开 HUAS 视觉材料设计的独立开源项目；除非未来得到学校正式授权或采用，否则不要声称这是湖南文理学院官方模板。

---

# 六、Git 管理要求

**第一次最小可运行版本成功编译后，立即开始 Git 管理。**

不要等整个主题完成再 Git。

第一轮成功后：

1. 创建 `.gitignore`，排除 LaTeX 临时文件和编译产物；
2. 执行 `git init`；
3. 检查 `git status`；
4. 创建第一次 commit，例如：

`init: create minimal HUAS Beamer theme`

后续推荐使用清晰的 commit：

- `feat: add HUAS title page`
- `feat: add campus line art`
- `feat: add section page`
- `style: refine HUAS color palette`
- `refactor: split inner and outer themes`
- `fix: resolve XeLaTeX compilation issue`
- `docs: add usage guide`

不要一次积累大量不相关修改后再提交。

---

# 七、第一次开发完成后的 GitHub 工作

当以下条件满足：

- 最小主题可正常编译；
- 已创建 README；
- 已初始化 Git；
- 至少存在第一个有效 commit；

暂停继续开发。

然后指导我建立 GitHub 仓库。

建议仓库名称：

`HUAS-Beamer`

建议简介：

`A LaTeX Beamer theme for Hunan University of Arts and Science (HUAS).`

在创建 GitHub 仓库前：

1. 检查是否存在敏感文件；
2. 检查 LICENSE；
3. 检查学校素材的版权与使用方式；
4. 不要把来源不明确或不适合公开的素材直接提交。

然后向我说明：

- 如何在 GitHub 创建仓库；
- Public / Private 如何选择；
- 是否初始化 README / LICENSE / .gitignore；
- 如何添加 remote；
- 如何进行第一次 push；
- 如何确认远程仓库内容正确。

如果本机存在 GitHub CLI，可以告诉我可选方案，但**不要未经确认直接替我创建公开仓库或 push**。

仓库建立完成后，再继续 Phase 1 之后的开发。

---

# 八、工作方式

你不是一次性代码生成器，而是本项目的 coding agent。

每一轮工作应遵循：

**查看当前状态 → 阅读相关参考项目实现 → 说明准备怎么做 → 修改少量代码 → 实际编译 → 检查结果 → 汇报变化 → 等待或进入下一明确阶段。**

遇到问题时：
- 先分析日志和现有代码；
- 解释问题来源；
- 再修改；
- 不要通过不断加入 package 掩盖问题。

遇到架构问题时：
- 先查 SJTUBeamer / USTC / ZJU / Metropolis 等已有实现；
- 比较方案；
- 选择最适合 HUAS-Beamer 的做法。

不得因为 AI 可以快速生成代码，就牺牲项目的可理解性和长期维护性。

---

# 九、现在开始

现在只执行 **Phase 0**。

先检查：
- 当前目录；
- XeLaTeX 是否可用；
- Git 是否可用；
- 项目是否已经存在文件。

然后建立 HUAS-Beamer 最小可运行版本。

不要提前开发 Phase 1–5。

成功生成第一个 PDF 后：
1. 汇报项目结构；
2. 说明本轮实现内容；
3. 初始化 Git；
4. 创建第一次 commit；
5. 然后指导我建立 GitHub 上的 `HUAS-Beamer` 仓库。

完成这些以后，再进入下一阶段。