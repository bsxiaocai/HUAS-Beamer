# HUAS-Beamer notice

HUAS-Beamer 是独立开发的 LaTeX Beamer 主题。目前并非湖南文理学院发布或授权的官方模板。

## 项目源码

`LICENSE` 是未经修改的 LaTeX Project Public License 1.3c 正文。计划按 LPPL-1.3c 发布的 HUAS-Beamer 自主开发源码为：

- `beamerthemeHUAS.sty`、`beamercolorthemeHUAS.sty`、`beamerfontthemeHUAS.sty`、`beamerinnerthemeHUAS.sty`、`beamerouterthemeHUAS.sty`；
- `theme/huas-assets.tex`、`theme/huas-config.tex`；
- `assets/lineart/campus-outline.tex`（项目绘制的建筑示意线稿）；
- 示例源码 `main.tex`。

源码版权持有人与 Current Maintainer 均为 `bsxiaocai`，LPPL maintenance status 为 `maintained`。公开发布前仍需确认可联系的维护渠道，并复核所有素材与文档的分发权利。

## 素材与其他文件

| 类别 | 当前状态 | 权利说明 |
| --- | --- | --- |
| 项目原创视觉素材 | `assets/lineart/campus-outline.tex` 是已纳入 Git 的简化建筑示意线稿 | 此源码按 LPPL-1.3c 使用，不是学校官方建筑插画；未来新增图片须逐项声明来源与许可。 |
| HUAS 官方身份素材 | `assets/research/` 中有本地研究文件，但已被 Git 忽略 | 湖南文理学院名称、HUAS 标识、校徽、校旗、校训书法及其他官方视觉资产的相关权利归各自权利人所有；本项目不对其重新授权，也不声称可以自由修改或再分发。来源与公开使用许可待确认。 |
| 第三方代码与素材 | 当前没有纳入 Git 的第三方参考源码或图片 | `examples/references/` 是被 Git 忽略的本地参考仓库。来源、版本和许可线索列于 `examples/README.md`，这些项目的许可不被本项目的 LPPL 声明覆盖。 |
| 项目文档与开发提示 | README、阶段总结及 `docs/development/` 文件 | 上述源码许可范围不自动扩展到开发提示、研究记录和其他未明确列入的文件；公开前应确认其作者与分发权利。 |

参考仓库中 ZJU-Beamer-Template 与 NJU_Beamer 未发现顶层 LICENSE；当前项目没有直接复用它们的代码。若以后计划复用任何上游代码或素材，应先核对该文件的具体许可和署名要求。

`assets/research/HUAS_building_1_bgcolor.png` 与 `HUAS_building_2_bgcolor.png` 是用户从现有图片中提取的建筑素材，仅通过可选路径用于本地示例，不属于项目原创 LPPL 源码范围；源图与再分发许可仍待确认。
