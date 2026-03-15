param(
    [Parameter(Mandatory=$true)]
    [string]$ThemeName
)

$themeConfigPath = Join-Path $PSScriptRoot "config\themes\$ThemeName.toml"
$hugoConfigPath = Join-Path $PSScriptRoot "hugo.toml"

if (-not (Test-Path $themeConfigPath)) {
    Write-Host "Error: Theme configuration file for '$ThemeName' not found." -ForegroundColor Red
    Write-Host "Available themes:" -ForegroundColor Yellow
    Get-ChildItem (Join-Path $PSScriptRoot "config\themes") | ForEach-Object {
        Write-Host "  $($_.BaseName)"
    }
    exit 1
}

# 复制主题配置文件
Copy-Item -Path $themeConfigPath -Destination $hugoConfigPath -Force

# 添加必要的配置
Add-Content -Path $hugoConfigPath -Value "`n[params]"

# 根据主题设置正确的favicon路径
if ($ThemeName -eq 'Lowkey') {
    Add-Content -Path $hugoConfigPath -Value "  favicon = 'icons/favicon.ico'"
} else {
    Add-Content -Path $hugoConfigPath -Value "  favicon = 'favicon.ico'"
}

Add-Content -Path $hugoConfigPath -Value "`n[[menu.main]]"
Add-Content -Path $hugoConfigPath -Value "  identifier = 'posts'"
Add-Content -Path $hugoConfigPath -Value "  name = 'Posts'"
Add-Content -Path $hugoConfigPath -Value "  url = '/posts/'"

Write-Host "Successfully switched to theme: $ThemeName" -ForegroundColor Green
Write-Host "Run 'hugo server --buildDrafts' to start the server." -ForegroundColor Cyan