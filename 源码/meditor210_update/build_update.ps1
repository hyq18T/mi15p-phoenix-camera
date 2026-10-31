param(
    [string]$OutDir,
    [string]$ApktoolJar = 'D:\GPT\_phoenix_build\tools\vendor\apktool_2.12.1.jar',
    [string]$BuildTools = 'D:\GPT\_phoenix_build\_android-sdk\build-tools\35.0.0'
)

$ErrorActionPreference = 'Stop'
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$slug = '2026-10-30_meditor210_update'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
if (-not $OutDir) { $OutDir = Join-Path $projectRoot "03_输出\$slug\rebuild-$stamp" }
$outputAbsolute = [System.IO.Path]::GetFullPath($OutDir)
if (-not $outputAbsolute.StartsWith($projectRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw '输出必须在本项目目录内'
}
if (Test-Path -LiteralPath $outputAbsolute) { throw '输出目录已存在，请使用新目录' }
$tempPhysical = Join-Path $projectRoot "99_临时\rebuild-meditor210-$stamp"
$baselineApk = Join-Path $projectRoot "02_数据\$slug\rollback\old_allinone_lsp.apk"
$editorApk = Join-Path $projectRoot "04_交付\$slug\MediaEditor_2.10.43.0.8.apk"
$oldModule = Join-Path $projectRoot '04_交付\git仓库-Phoenix-1.3.0-15Pro-槐蔭區2改\成品\Phoenix_15Pro_Camera_M3_AllInOne-1.3.0.zip'
$keystore = Join-Path $projectRoot '04_交付\Phoenix-LSP-AllInOne-20261018\签名\allinone.keystore'
foreach ($path in @($baselineApk, $editorApk, $oldModule, $keystore, $ApktoolJar)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "构建输入不存在：$path" }
}
$drive = @('V:', 'W:', 'X:', 'Y:', 'Z:') | Where-Object { -not (Test-Path "$_\") } | Select-Object -First 1
if (-not $drive) { throw '没有可用的临时盘符' }
$previousTemp = $env:TEMP
$previousTmp = $env:TMP
$previousStorePassword = $env:PHOENIX_STORE_PASSWORD
$previousKeyPassword = $env:PHOENIX_KEY_PASSWORD
$mapped = $false

function Assert-Exit([string]$Name) {
    if ($LASTEXITCODE -ne 0) { throw "$Name 失败（exit=$LASTEXITCODE）" }
}

try {
    New-Item -ItemType Directory -Path $tempPhysical, $outputAbsolute | Out-Null
    subst $drive $tempPhysical
    Assert-Exit 'ASCII 临时盘符映射'
    $mapped = $true
    $work = "$drive\"
    New-Item -ItemType Directory -Path "$work\input", "$work\framework", "$work\tmp", "$work\out" | Out-Null
    $env:TEMP = "$work\tmp"
    $env:TMP = "$work\tmp"
    $env:PHOENIX_STORE_PASSWORD = 'android'
    $env:PHOENIX_KEY_PASSWORD = 'android'
    Copy-Item -LiteralPath $baselineApk -Destination "$work\input\baseline.apk"
    Copy-Item -LiteralPath $editorApk -Destination "$work\input\editor.apk"
    Copy-Item -LiteralPath $keystore -Destination "$work\input\allinone.keystore"
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'merged_lsp') -Destination "$work\merged" -Recurse
    & (Join-Path $PSScriptRoot 'compile_runtime.ps1') -WorkDir $work -MergedTree "$work\merged" -BuildTools $BuildTools
    Assert-Exit '新版运行接口编译'

    & java "-Djava.io.tmpdir=$work\tmp" -jar $ApktoolJar d -p "$work\framework" -o "$work\baseline" "$work\input\baseline.apk"
    Assert-Exit '基线 APK 解包'
    & java "-Djava.io.tmpdir=$work\tmp" -jar $ApktoolJar b -p "$work\framework" -o "$work\out\unsigned.apk" "$work\merged"
    Assert-Exit '合并源码回编译'
    & python -B -X utf8 (Join-Path $PSScriptRoot 'preserve_dex.py') `
        --baseline-apk "$work\input\baseline.apk" --baseline-tree "$work\baseline" `
        --merged-tree "$work\merged" --unsigned "$work\out\unsigned.apk" `
        --report (Join-Path $outputAbsolute 'preserved_dex_report.json')
    Assert-Exit '未改动 dex 校验与保留'
    & (Join-Path $BuildTools 'zipalign.exe') -f 4 "$work\out\unsigned.apk" "$work\out\aligned.apk"
    Assert-Exit 'APK 对齐'
    $signedApk = "$work\out\Phoenix_LSP_AllInOne-MEditor210-1.3.0-15Pro.apk"
    & java "-Djava.io.tmpdir=$work\tmp" -jar (Join-Path $BuildTools 'lib\apksigner.jar') sign `
        --ks "$work\input\allinone.keystore" --ks-key-alias phoenixall `
        --ks-pass env:PHOENIX_STORE_PASSWORD --key-pass env:PHOENIX_KEY_PASSWORD `
        --v4-signing-enabled false --out $signedApk "$work\out\aligned.apk"
    Assert-Exit '原密钥签名'
    & java "-Djava.io.tmpdir=$work\tmp" -jar (Join-Path $BuildTools 'lib\apksigner.jar') verify --print-certs $signedApk
    Assert-Exit '签名验证'
    & (Join-Path $BuildTools 'zipalign.exe') -c 4 $signedApk
    Assert-Exit '对齐验证'
    & python -B -X utf8 (Join-Path $PSScriptRoot 'package_update.py') `
        --base-module $oldModule --lsp-apk $signedApk --editor-apk "$work\input\editor.apk" `
        --output (Join-Path $outputAbsolute 'Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip') `
        --module-source (Join-Path $outputAbsolute 'module_source') `
        --report (Join-Path $outputAbsolute 'module_report.json')
    Assert-Exit '整合包构建与验证'
    Copy-Item -LiteralPath $signedApk -Destination $outputAbsolute
    Write-Output "构建完成：$outputAbsolute"
}
finally {
    $env:TEMP = $previousTemp
    $env:TMP = $previousTmp
    $env:PHOENIX_STORE_PASSWORD = $previousStorePassword
    $env:PHOENIX_KEY_PASSWORD = $previousKeyPassword
    if ($mapped) { subst $drive /D }
    $verifiedTemp = [System.IO.Path]::GetFullPath($tempPhysical)
    $allowedTemp = [System.IO.Path]::GetFullPath((Join-Path $projectRoot '99_临时')) + '\'
    if ($verifiedTemp.StartsWith($allowedTemp, [StringComparison]::OrdinalIgnoreCase) -and
        (Test-Path -LiteralPath $verifiedTemp)) {
        Remove-Item -LiteralPath $verifiedTemp -Recurse -Force
    }
}
