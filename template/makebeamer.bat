@echo off
rem ===================================================================
rem HUAS-Beamer 一键编译脚本（Windows）
rem 双击运行即可编译全部四个版本；或指定单个目标：
rem   makebeamer.bat HUAS-Beamer         （中文暖色）
rem   makebeamer.bat HUAS-Beamer-EN      （英文暖色）
rem   makebeamer.bat HUAS-Beamer-Blue    （中文冷色）
rem   makebeamer.bat HUAS-Beamer-Blue-EN （英文冷色）
rem 需要：TeX Live / MiKTeX（xelatex、bibtex 已加入 PATH）
rem ===================================================================
chcp 65001 >nul
setlocal enabledelayedexpansion

if not "%1"=="" (set TARGETS=%1) else (set TARGETS=HUAS-Beamer HUAS-Beamer-EN HUAS-Beamer-Blue HUAS-Beamer-Blue-EN)

for %%F in (%TARGETS%) do (
  echo.
  echo ===== Building %%F =====
  xelatex -interaction=nonstopmode %%F.tex
  bibtex %%F
  xelatex -interaction=nonstopmode %%F.tex
  xelatex -interaction=nonstopmode %%F.tex
)

echo.
echo ===== Cleaning auxiliary files =====
del /q *.aux *.log *.out *.toc *.bbl *.blg *.nav *.snm *.vrb *.synctex.gz 2>nul
echo Done! PDF: HUAS-Beamer.pdf / HUAS-Beamer-EN.pdf / HUAS-Beamer-Blue.pdf / HUAS-Beamer-Blue-EN.pdf
pause
