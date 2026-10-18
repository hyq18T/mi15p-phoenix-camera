<#
Phoenix LSP 三合一合并脚本

用途：
  把以下三个 LSPosed 模块合并成一个 APK（保留主 LSP 包名 com.prometheus.camera.rev）：
    1. Phoenix 主 LSP
    2. LegendM3 LSP（com.phoenix.camera.m3）
    3. NaturalTuning LSP（com.prometheus.camera.natural15pro）

依赖：
  - JDK（java 在 PATH 中）
  - apktool 2.12.1
  - Android Build-Tools（zipalign、apksigner）

示例：
  powershell -ExecutionPolicy Bypass -File .\merge_lsp.ps1 `
    -MainApk  "D:\path\Phoenix_LSP_Phoenix-1.3.0.apk" `
    -M3Apk    "D:\path\PhoenixAddon-LegendM3-V1.0.0-LSP.apk" `
    -NaturalApk "D:\path\PhoenixAddon-NaturalTuning-15Pro.apk"
#>
param(
    [Parameter(Mandatory = $true)][string]$MainApk,
    [Parameter(Mandatory = $true)][string]$M3Apk,
    [Parameter(Mandatory = $true)][string]$NaturalApk,
    [string]$OutDir = (Join-Path $PSScriptRoot 'out'),
    [string]$WorkDir = 'D:\GPT\_phoenix_build\lsp_merge_work',
    [string]$ApktoolJar = 'D:\GPT\_phoenix_build\tools\vendor\apktool_2.12.1.jar',
    [string]$BuildTools = 'D:\GPT\_phoenix_build\_android-sdk\build-tools\35.0.0',
    [string]$Keystore = (Join-Path $PSScriptRoot '..\签名\allinone.keystore'),
    [string]$KeystorePass = 'android',
    [string]$KeyAlias = 'phoenixall',
    [string]$VersionName = 'Phoenix-1.3.0-AllInOne',
    [int]$VersionCode = 2010400,
    [string]$Label = 'Phoenix 三合一 · 槐蔭區2改',
    [string]$Description = 'Phoenix 主 LSP + LegendM3 + NaturalTuning 三合一｜Xiaomi 15 Pro 适配 · 槐蔭區2改'
)

$ErrorActionPreference = 'Stop'

function Assert-File([string]$Path, [string]$Name) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "$Name 不存在: $Path"
    }
}

function Get-NextSmaliDir([string]$Tree) {
    for ($i = 2; $i -lt 100; $i++) {
        $candidate = Join-Path $Tree "smali_classes$i"
        if (-not (Test-Path -LiteralPath $candidate)) {
            return $candidate
        }
    }
    throw '找不到可用的 smali_classesN 目录'
}

function Merge-Smali([string]$DonorDir, [string]$TargetDir) {
    $donorSmali = Get-ChildItem -LiteralPath $DonorDir -Directory |
        Where-Object { $_.Name -eq 'smali' -or $_.Name -match '^smali_classes\d+$' } |
        Sort-Object Name
    foreach ($dir in $donorSmali) {
        $slot = Get-NextSmaliDir $TargetDir
        New-Item -ItemType Directory -Force -Path $slot | Out-Null
        Copy-Item -Path (Join-Path $dir.FullName '*') -Destination $slot -Recurse -Force
        Write-Host ("smali: {0} -> {1}" -f $dir.FullName, $slot)
    }
}

function Merge-Assets([string]$DonorDir, [string]$TargetDir) {
    $assets = Join-Path $DonorDir 'assets'
    if (Test-Path -LiteralPath $assets) {
        Copy-Item -Path (Join-Path $assets '*') -Destination $TargetDir -Recurse -Force
    }
}

Assert-File $MainApk 'MainApk'
Assert-File $M3Apk 'M3Apk'
Assert-File $NaturalApk 'NaturalApk'
Assert-File $ApktoolJar 'ApktoolJar'
Assert-File $Keystore 'Keystore'

New-Item -ItemType Directory -Force -Path $OutDir, $WorkDir | Out-Null
$mainDir = Join-Path $WorkDir 'main'
$m3Dir = Join-Path $WorkDir 'm3'
$natDir = Join-Path $WorkDir 'nat'
foreach ($dir in @($mainDir, $m3Dir, $natDir)) {
    if (Test-Path -LiteralPath $dir) {
        [System.IO.Directory]::Delete($dir, $true)
    }
}

Write-Host '[1/8] 反编译三个 APK'
& java -jar $ApktoolJar d -f -o $mainDir $MainApk
if ($LASTEXITCODE -ne 0) { throw '主 LSP 反编译失败' }
& java -jar $ApktoolJar d -f -o $m3Dir $M3Apk
if ($LASTEXITCODE -ne 0) { throw 'M3 LSP 反编译失败' }
& java -jar $ApktoolJar d -f -o $natDir $NaturalApk
if ($LASTEXITCODE -ne 0) { throw 'Natural LSP 反编译失败' }

Write-Host '[2/8] 合并 smali'
Merge-Smali $m3Dir $mainDir
Merge-Smali $natDir $mainDir

Write-Host '[3/8] 合并 assets'
$mainAssets = Join-Path $mainDir 'assets'
New-Item -ItemType Directory -Force -Path $mainAssets | Out-Null
Merge-Assets $m3Dir $mainAssets
Merge-Assets $natDir $mainAssets

Write-Host '[4/8] 合并 xposed_init'
$initFiles = @(
    (Join-Path $mainAssets 'xposed_init'),
    (Join-Path $m3Dir 'assets\xposed_init'),
    (Join-Path $natDir 'assets\xposed_init')
)
$entries = @()
foreach ($file in $initFiles) {
    if (Test-Path -LiteralPath $file) {
        $entries += Get-Content -LiteralPath $file -Encoding UTF8 |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ -and -not $_.StartsWith('#') }
    }
}
$entries = [string[]]($entries | Select-Object -Unique)
[System.IO.File]::WriteAllLines(
    (Join-Path $mainAssets 'xposed_init'),
    $entries,
    (New-Object System.Text.UTF8Encoding($false))
)

Write-Host '[5/8] 修改 AndroidManifest.xml'
$manifestPath = Join-Path $mainDir 'AndroidManifest.xml'
$manifest = [System.IO.File]::ReadAllText($manifestPath)
$manifest = $manifest -replace 'android:label="[^"]*"', ('android:label="' + $Label + '"')
$manifest = $manifest -replace '(<meta-data android:name="xposeddescription" android:value=")[^"]*(")', ('${1}' + $Description + '${2}')
$manifest = $manifest -replace '(<meta-data android:name="xposedminversion" android:value=")[^"]*(")', '${1}93${2}'
[System.IO.File]::WriteAllText($manifestPath, $manifest, (New-Object System.Text.UTF8Encoding($false)))

Write-Host '[6/8] 修改模块元数据'
$moduleProp = Join-Path $mainDir 'unknown\META-INF\xposed\module.prop'
if (Test-Path -LiteralPath $moduleProp) {
    $prop = Get-Content -LiteralPath $moduleProp -Encoding UTF8
    $prop = $prop -replace '^minApiVersion=.*$', 'minApiVersion=93'
    $prop = $prop -replace '^targetApiVersion=.*$', 'targetApiVersion=93'
    [System.IO.File]::WriteAllLines($moduleProp, $prop, (New-Object System.Text.UTF8Encoding($false)))
}
$apktoolYml = Join-Path $mainDir 'apktool.yml'
$yml = [System.IO.File]::ReadAllText($apktoolYml)
$yml = $yml -replace 'versionCode: \d+', ('versionCode: ' + $VersionCode)
$yml = $yml -replace 'versionName: .*', ('versionName: ' + $VersionName)
[System.IO.File]::WriteAllText($apktoolYml, $yml, (New-Object System.Text.UTF8Encoding($false)))

Write-Host '[7/8] 回编译'
$unsigned = Join-Path $OutDir 'unsigned.apk'
$aligned = Join-Path $OutDir 'aligned.apk'
$final = Join-Path $OutDir ("Phoenix_LSP_AllInOne-{0}.apk" -f $VersionName)
& java -jar $ApktoolJar b $mainDir -o $unsigned
if ($LASTEXITCODE -ne 0) { throw '回编译失败' }
& (Join-Path $BuildTools 'zipalign.exe') -f 4 $unsigned $aligned
if ($LASTEXITCODE -ne 0) { throw 'zipalign 失败' }

Write-Host '[8/8] 签名与校验'
& (Join-Path $BuildTools 'apksigner.bat') sign `
    --ks $Keystore `
    --ks-key-alias $KeyAlias `
    --ks-pass ("pass:" + $KeystorePass) `
    --key-pass ("pass:" + $KeystorePass) `
    --out $final $aligned
if ($LASTEXITCODE -ne 0) { throw '签名失败' }
& (Join-Path $BuildTools 'apksigner.bat') verify --print-certs $final
& (Join-Path $BuildTools 'zipalign.exe') -c -v 4 $final | Select-Object -Last 3

Write-Host ''
Write-Host ("完成: " + $final)
Get-FileHash -LiteralPath $final -Algorithm SHA256 | Format-List
