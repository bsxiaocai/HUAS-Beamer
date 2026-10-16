#=======================================================================
# HUAS-Beamer 构建脚本（Makefile）
# 用法：
#   make / make all              - 编译全部四个版本
#   make HUAS-Beamer.pdf         - 仅编译中文暖色版
#   make HUAS-Beamer-EN.pdf      - 仅编译英文暖色版
#   make HUAS-Beamer-Blue.pdf    - 仅编译中文冷色版
#   make HUAS-Beamer-Blue-EN.pdf - 仅编译英文冷色版
#   make clean                   - 清理辅助文件
#   make distclean               - 清理辅助文件与 PDF
# 需要：TeX Live / MiKTeX（xelatex、bibtex）
#=======================================================================
ENGINE = xelatex
FLAGS  = -interaction=nonstopmode
AUX    = *.aux *.log *.out *.toc *.bbl *.blg *.nav *.snm *.vrb *.synctex.gz *.fls *.fdb_latexmk
TARGETS = HUAS-Beamer.pdf HUAS-Beamer-EN.pdf HUAS-Beamer-Blue.pdf HUAS-Beamer-Blue-EN.pdf

.PHONY: all clean distclean help

all: $(TARGETS)

HUAS-Beamer.pdf: HUAS-Beamer.tex huasbeamer.sty reference.bib
	$(ENGINE) $(FLAGS) HUAS-Beamer.tex
	bibtex HUAS-Beamer
	$(ENGINE) $(FLAGS) HUAS-Beamer.tex
	$(ENGINE) $(FLAGS) HUAS-Beamer.tex

HUAS-Beamer-EN.pdf: HUAS-Beamer-EN.tex huasbeamer.sty reference.bib
	$(ENGINE) $(FLAGS) HUAS-Beamer-EN.tex
	bibtex HUAS-Beamer-EN
	$(ENGINE) $(FLAGS) HUAS-Beamer-EN.tex
	$(ENGINE) $(FLAGS) HUAS-Beamer-EN.tex

HUAS-Beamer-Blue.pdf: HUAS-Beamer-Blue.tex huasbeamer.sty reference.bib
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue.tex
	bibtex HUAS-Beamer-Blue
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue.tex
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue.tex

HUAS-Beamer-Blue-EN.pdf: HUAS-Beamer-Blue-EN.tex huasbeamer.sty reference.bib
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue-EN.tex
	bibtex HUAS-Beamer-Blue-EN
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue-EN.tex
	$(ENGINE) $(FLAGS) HUAS-Beamer-Blue-EN.tex

clean:
	@echo "Cleaning up auxiliary files..."
	@rm -f $(AUX)
	@echo "Done!"

distclean: clean
	@rm -f $(TARGETS)

help:
	@echo "HUAS-Beamer Makefile:"
	@echo "  all / (default)  - Build all four versions"
	@echo "  HUAS-Beamer.pdf         - Chinese, warm palette"
	@echo "  HUAS-Beamer-EN.pdf      - English, warm palette"
	@echo "  HUAS-Beamer-Blue.pdf    - Chinese, cool (blue-white) palette"
	@echo "  HUAS-Beamer-Blue-EN.pdf - English, cool (blue-white) palette"
	@echo "  clean            - Remove auxiliary files"
	@echo "  distclean        - Remove auxiliary files and PDFs"
