# Copyright (C) 2026 bsxiaocai
# SPDX-License-Identifier: LPPL-1.3c
# HUAS-Beamer build helper. See LICENSE and NOTICE.md.
[CmdletBinding()]
param(
    [ValidateSet('all', 'main', 'academic', 'seminar', 'cool')]
    [string]$Target = 'all',
    [string]$Engine = 'xelatex'
)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$sources = [ordered]@{
    main = 'main.tex'
    academic = 'examples/academic-demo.tex'
    seminar = 'examples/seminar-demo.tex'
    cool = 'examples/cool-demo.tex'
}
$targets = if ($Target -eq 'all') { @($sources.Keys) } else { @($Target) }
$compiler = (Get-Command $Engine -CommandType Application -ErrorAction Stop).Source
Push-Location -LiteralPath $projectRoot
try {
    foreach ($name in $targets) {
        $outputDir = "build/$name"
        New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
        for ($pass = 1; $pass -le 2; $pass++) {
            Write-Host "Compiling $name ($pass/2)"
            & $compiler '-interaction=nonstopmode' '-halt-on-error' "-output-directory=$outputDir" $sources[$name]
            if ($LASTEXITCODE -ne 0) {
                throw "XeLaTeX failed for $name. See $outputDir for the log."
            }
        }
        $stem = [System.IO.Path]::GetFileNameWithoutExtension($sources[$name])
        Write-Host "PDF: $projectRoot/$outputDir/$stem.pdf"
    }
}
finally {
    Pop-Location
}
