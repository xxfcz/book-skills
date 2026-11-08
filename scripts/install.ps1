# install.ps1
# 把 book-skills 里每本书的 skill/ 目录链接( junction )到 WorkBuddy 的 skills 目录。
# junction 不需要管理员权限；首次使用建议开启 Windows 开发者模式以获得完整符号链接支持。
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repoRoot   = Split-Path -Parent $MyInvocation.MyCommand.Path
$booksRoot  = Join-Path $repoRoot 'books'
$skillsRoot = Join-Path $env:USERPROFILE '.workbuddy\skills'

if (-not (Test-Path $booksRoot)) {
    Write-Error "找不到 books 目录: $booksRoot"
    exit 1
}

if (-not (Test-Path $skillsRoot)) {
    New-Item -ItemType Directory -Path $skillsRoot -Force | Out-Null
    Write-Host "已创建 skills 目录: $skillsRoot"
}

$count = 0
Get-ChildItem -Directory $booksRoot | ForEach-Object {
    $slug = $_.Name
    $src  = Join-Path $_.FullName 'skill'
    $dst  = Join-Path $skillsRoot $slug

    if (-not (Test-Path $src)) {
        Write-Warning "跳过 '$slug' : 找不到 $src"
        return
    }
    if (Test-Path $dst) {
        Write-Host "已存在，跳过: $dst"
        return
    }

    # mklink /J 创建目录 junction（指向 src，不需要管理员）
    $null = cmd /c "mklink /J `"$dst`" `"$src`""
    if (Test-Path $dst) {
        Write-Host "已链接: $slug -> $dst"
        $count++
    } else {
        Write-Warning "链接失败: $slug"
    }
}

Write-Host "完成。共链接 $count 个 skill。请重启 WorkBuddy 以加载。"
