# 视觉素材目录

- `lineart/`：预留给有权使用的建筑线稿；不再包含或生成项目自行绘制的建筑线条。
- `research/`：本地研究素材，由 `.gitignore` 排除；其中校徽与校园图片仅供本地预览，未确认再分发权利。
- `logo/`：未来存放经授权可分发的校徽或标识文件。
- `images/`：未来存放经授权可分发的校园图片。

示例检测到本地素材时显示透明校徽 `research/HUAS-School_badge-transparent.png` 和用户建筑图：`HUAS_building_1_bgcolor.png` 用于封面／章节／结束页的辅助区域，`HUAS_building_2_bgcolor.png` 用于正文图片示例。两张建筑图具有透明通道，主题保留其颜色、透明度和线条；现有浅色辅助区能显示原色，本阶段未改色或补线。

校徽从 `HUAS-School_badge-white_background.jpg` 按像素去白：只改变 Alpha，原分辨率、RGB 和主体笔画保持不变；圈内外白色均透明。原 JPG 不覆盖。处理可用 `scripts/extract-badge.py` 重现，需要 Pillow，且拒绝覆盖已有输出。源图是 JPEG，细小边缘的压缩痕迹仍可能可见。

按用户后续要求，生成式抠图也保留为 `research/HUAS-School_badge-transparent-imagegen-v1.png` 和 `v2.png`；两份均为 RGBA PNG，可用 `\HUASsetlogo{assets/research/对应文件名}` 加载。默认仍为像素去白版。生成式版本的笔画与色泽可能有变化，不是原图的像素一致副本。所有校徽版本仍只保存在被忽略的本地研究目录。

用户可用 `\HUASsetbuilding{路径}` 替换辅助建筑图；空路径关闭，缺失路径会警告并留空。没有本地素材时，主题仍可编译，正文图片页改为占位框。公开发行任何学校身份素材前，应先确认来源、用途与再分发许可；去白和改色不改变这些权利。
