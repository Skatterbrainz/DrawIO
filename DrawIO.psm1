# DrawIO PowerShell Module
# Dot-source private (internal) functions
$privatePath = Join-Path $PSScriptRoot "private"
if (Test-Path $privatePath) {
    Get-ChildItem -Path $privatePath -Filter "*.ps1" -Recurse | ForEach-Object {
        . $_.FullName
    }
}

# Dot-source public (exported) functions
$publicPath = Join-Path $PSScriptRoot "public"
if (Test-Path $publicPath) {
    Get-ChildItem -Path $publicPath -Filter "*.ps1" -Recurse | ForEach-Object {
        . $_.FullName
    }
}
