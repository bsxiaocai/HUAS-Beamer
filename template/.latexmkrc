# latexmk 配置（可选）：latexmk HUAS-Beamer.tex 或 latexmk -pvc HUAS-Beamer.tex
# 参考 SCU-Beamer-Theme 的工程化配置（简化版）

# xelatex 引擎（5 = xelatex）
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 -file-line-error %O %S';

# bibtex 自动运行
$bibtex_use = 2;

# 最大重复编译次数（解决交叉引用）
$max_repeat = 5;

# 清理时删除的扩展名（latexmk -c）
$clean_ext = 'bbl blg nav snm vrb synctex.gz xdv run.xml';
