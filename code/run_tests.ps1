# Valhalla incubation test package — one-shot runner (Windows / PowerShell)
#
# Usage (from the root of the Valhalla repo, after installing the bins
# as described in TEST_PACKAGE.md):
#   .\run_tests.ps1              # full package (Suite 2 takes ~13 min)
#   .\run_tests.ps1 -Quick       # skip the two long relation suites
#
# Logs are written to .\test_logs\<bin>.log (UTF-8).
param([switch]$Quick)

$ErrorActionPreference = "Continue"
$env:RUSTFLAGS = "-L C:\Ai\cuda-libx64"
$env:PATH = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.4\bin;C:\Ai\cuda-libx64;$env:PATH"

New-Item -ItemType Directory -Force "test_logs" | Out-Null

function Run-Bin([string]$Name) {
    Write-Host "== $Name =="
    $out = cargo run -p hub-f64 --bin $Name 2>$null
    $out | ForEach-Object { Write-Host $_ }
    $out | Set-Content -Path "test_logs\$Name.log" -Encoding utf8
}

# Fast causal/health layer first
Run-Bin "valhalla_fate_decision_check"
Run-Bin "valhalla_incubation_proof"
Run-Bin "valhalla_industry_battery"

if (-not $Quick) {
    if (-not $env:VALHALLA_REL_ROUNDS) { $env:VALHALLA_REL_ROUNDS = "5" }
    Run-Bin "valhalla_relation_incubate"
    Run-Bin "valhalla_relation_incubate2"   # fixed 20-round curriculum
}

Write-Host "Done. Logs in .\test_logs\"
