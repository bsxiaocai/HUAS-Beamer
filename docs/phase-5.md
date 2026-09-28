# Phase 5 示例、字体与素材处理总结（2026-09-28）

## 阅读与依据

重读开发总纲、许可提示、代码审查要点，以及 Phase 0／1／2／3／4 和许可阶段总结。参考 SJTUBeamer 的 ctex 字体集与内容分离、ZJU 的根目录编译和两遍构建、Metropolis 的字体检查与层级设置，并查看本机 ctex Windows 字体配置。仅借鉴机制，没有复制上游代码。

本阶段以用户的新要求为准：不自行绘制建筑线条；中文优先采用黑体、宋体；校徽去除圈内外白色。旧总结里“缺失建筑时回退到原创示意图”的设计在本阶段撤销，历史总结保留原记录。开始时已有建筑源码删除记录，用户随后将其提交为 `1382eb2`；本阶段清理残留引用，不恢复该文件。

## 完成内容

- 移除入口对 `campus-outline.tex` 的引用与为其添加的 TikZ 依赖，移除绘图专用颜色。建筑加载器只显示提供的素材；空路径或缺失路径不显示装饰建筑，缺失路径仍有明确警告。保留 lineart 目录作为素材位置。
- 采用黑体标题、章节标题、内容块标题、重点文字和页脚；正文、副标题、引文与图注采用 ctex 宋体体系。Windows 标题优先使用 SimHei，正文为 SimSun；无 SimHei 时使用 ctex 的黑体族。没有下载或分发字体。黑体标题轻度模拟加粗，不改变用户的 ctex 字体族。
- 保留原校徽 JPG，按用户明确授权使用 Python/Pillow 去白，仅改变 Alpha，不改 RGB、尺寸或主体几何。圈内外与文字间的白色负空间均透明；淡色边缘按红色差值平滑淡出，避免留下明显白边。
- 按用户后续要求保存两份 imagegen 生成式候选，默认示例用像素去白版；用户可用现有 `\HUASsetlogo` 切换。Warm 封面将红色校徽放入浅色信息区，解决透明红色校徽在暖红背景上对比不足的问题。
- 新增 `examples/academic-demo.tex`（10 页）和 `examples/seminar-demo.tex`（9 页）。前者展示研究问题、方法、公式、表格、结论与参考资料；后者展示读书引文、双栏细读、讨论与反思。原 Cool 示例为 16 页，最小示例为 5 页。
- `examples/local-assets.tex` 集中加载可选透明校徽与用户建筑图；`scripts/build.ps1` 支持 all/main/academic/seminar/cool，从任意工作目录以项目根目录编译两遍，失败即停止，输出集中于 build。Python 只用于素材准备，不是主题编译依赖。
- 更新 README、examples/README、assets/README 与 NOTICE，列明接口变化、字体、示例、构建及素材范围。

## 校徽文件与处理记录

以下文件均位于 `assets/research/`，保持 Git 忽略：

| 文件 | 处理方式与用途 |
| --- | --- |
| `HUAS-School_badge-white_background.jpg` | 原图，未覆盖 |
| `HUAS-School_badge-transparent.png` | Python 像素去白，默认使用，657×620 RGBA |
| `HUAS-School_badge-transparent-imagegen-v1.png` | 内置 imagegen 第一次生成式抠图，可选择使用 |
| `HUAS-School_badge-transparent-imagegen-v2.png` | 内置 imagegen 第二次生成式抠图，可选择使用 |

两次生成式处理有笔画与色泽变化，不能视为原图的像素一致副本；因此请求用户授权像素处理。用户同意后生成默认版，随后要求也保留生成式版本，已全部存入本项目。像素处理脚本在 `scripts/extract-badge.py`，需要 Pillow，拒绝覆盖已有结果。只适用于当前红色校徽的白底，不是通用抠图算法。

生成式版本采用内置工具，不使用 API／CLI。两次提示词分别为：

```text
Use case: background-extraction. Edit target: the supplied HUAS university badge JPEG. Produce a transparent PNG cutout of the EXISTING red badge. Remove ALL white: outside the circle, inside both rings, inside and around every red Chinese/English glyph and sculpture shape. Preserve the exact red artwork, ring geometry, typography and positioning: 湖南文理学院; HUNAN UNIVERSITY OF ARTS AND SCIENCE. Do not redraw, redesign, add, correct, recolor or invent any stroke. Keep all existing red fine details and natural antialiased edges. Transparent background, including interior negative spaces; no white fills, shadow, border or checkerboard pixels. This is an extraction of the source logo for embedding in slides, not a new logo.
```

```text
Background extraction ONLY. Use this exact JPEG image as an immutable pixel artwork. Remove every white pixel including interior gaps to alpha transparency. Preserve original FLAT MUTED RED (#C8312F approximately) in all retained pixels. Preserve the original THIN English letters, original calligraphic Chinese strokes, both fine circular outlines, and all sculpture silhouette details. Do not thicken any stroke. Do not add gradients, gloss, highlights, shadows or 3D. Do NOT redraw this logo. Keep the original source framing and relative geometry. Only white negative-space regions change to transparent. This is a university identity badge and exact artwork preservation is essential.
```

## 验证与修正

- 四份示例实际连续两遍 XeLaTeX 编译：5／10／9／16 页，均为 16:9。最终日志无 error、warning、overfull 或 underfull；整套页面渲染检查后放大核对宋体正文、黑体标题、中英文公式、细读引文和 Warm 封面。
- 将可分发源码复制到独立目录，不含 research 素材或第三方参考项目；从该目录外调用构建脚本，Warm 研讨示例两遍成功，9 页。无校徽、无建筑时仍正常编译，未出现自行绘制的替代线稿。
- PDF 嵌入字体实际包含 SimSun、SimHei；首次字体修改触发 xeCJK 重定义提示，改用项目专有字体命令，消除提示并保留用户原字体族。
- 像素去白版 RGB 字节与原 JPG 解码结果完全一致，分辨率一致；Alpha 覆盖 0～255，圈内白色测试点为 0。检查白底与深蓝底预览。修复 Pillow 新版本 getdata 的弃用提示，使用原始 RGB 字节读取。
- Git 差异与忽略规则检查通过，PNG、研究 PDF、字体文件、参考仓库与编译产物不进入源码提交。LPPL 正文未改动。

## 未完成好与限制

- 之前自行补绘建筑线稿未符合用户的素材使用期望，本阶段纠正；后续缺少素材时只能留空或使用明确的正文占位，不补绘校园建筑。
- 建筑 PNG 仍有提取残留，原橙色细线在小尺寸下较淡。本次保留原线条与颜色，置于浅色区域；若真实投影对比不足，可从原图仅调整颜色并另存，不能重绘或增加线条。
- JPEG 校徽已有压缩痕迹，像素去白无法恢复源图中缺失的细节。为保留 RGB 未做颜色去污染，深色背景放大仍可能看到少量淡色边缘；生成式候选存在形状和色泽差异，使用时按需要选择。
- 黑体模拟粗体仍需要在实际投影中判断；Linux、macOS、Overleaf 没有实测。字体跨平台差异与密集长文仍需在真实场景核对。
- 当前是手工参考文献与原生代码展示，尚未添加自动参考文献、语法高亮或发行包工具链；这些不属于本轮素材与基础示例要求。

## 下一阶段注意

继续阅读总纲、许可提示和各阶段总结，以用户最新要求覆盖旧设计决定。优先根据真实报告反馈调整字号、留白与细线对比，不扩展无需求组件。建筑只从现有素材改色，所有版本保留源图并记录路径；校徽用可选接口加载。公开分发仍需明确素材、文档与维护联系渠道；当前只完成本地开发，不自动推送或发布。
