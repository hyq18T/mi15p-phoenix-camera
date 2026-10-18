param(
    [string]$Stage = 'D:\GPT\_phoenix_build\_natural15pro_build',
    [string]$AndroidJar = '',
    [string]$OutDir = ''
)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not $OutDir) {
    $OutDir = Join-Path (Split-Path $src -Parent) 'module'
}
$sdk = 'D:\GPT\_phoenix_build\_android-sdk'
$buildTools = Join-Path $sdk 'build-tools\35.0.0'
$javaHome = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
$javac = Join-Path $javaHome 'bin\javac.exe'
$keytool = Join-Path $javaHome 'bin\keytool.exe'
$jar = Join-Path $javaHome 'bin\jar.exe'
$aapt2 = Join-Path $buildTools 'aapt2.exe'
$d8 = Join-Path $buildTools 'd8.bat'
$zipalign = Join-Path $buildTools 'zipalign.exe'
$apksigner = Join-Path $buildTools 'apksigner.bat'

if (-not $AndroidJar) {
    $sdkJar = Join-Path $sdk 'platforms\android-35\android.jar'
    if (Test-Path -LiteralPath $sdkJar) {
        $AndroidJar = $sdkJar
    } else {
        $AndroidJar = 'D:\GPT\2026-09-27_小米15Pro_Phoenix相机适配\99_临时\android-platform-35\android-35\android.jar'
    }
}
if (-not (Test-Path -LiteralPath $AndroidJar)) {
    throw "android.jar not found: $AndroidJar"
}

if (Test-Path -LiteralPath $Stage) {
    Remove-Item -LiteralPath $Stage -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $Stage | Out-Null
Copy-Item -LiteralPath (Join-Path $src 'AndroidManifest.xml') -Destination $Stage
Copy-Item -LiteralPath (Join-Path $src 'res') -Destination $Stage -Recurse
Copy-Item -LiteralPath (Join-Path $src 'assets') -Destination $Stage -Recurse
Copy-Item -LiteralPath (Join-Path $src 'java') -Destination $Stage -Recurse
Copy-Item -LiteralPath (Join-Path $src 'stubs') -Destination $Stage -Recurse

$lutPath = Join-Path $src 'assets\prometheus\natural-15pro\lut_cvstyle_natural.png'
$lutBase64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($lutPath))
$lutDataDir = Join-Path $Stage 'java\com\prometheus\camera\natural15pro'
$lutDataSource = @"
package com.prometheus.camera.natural15pro;

final class LutData {
    static final String PNG_BASE64 =
            "$lutBase64";

    private LutData() {
    }
}
"@
[IO.File]::WriteAllText(
    (Join-Path $lutDataDir 'LutData.java'),
    $lutDataSource,
    (New-Object Text.UTF8Encoding($false)))

$classes = Join-Path $Stage 'classes'
$dexDir = Join-Path $Stage 'dex'
$resZip = Join-Path $Stage 'res.zip'
$baseApk = Join-Path $Stage 'base.apk'
$alignedApk = Join-Path $Stage 'aligned.apk'
$unsignedApk = Join-Path $Stage 'unsigned.apk'
$finalApk = Join-Path $Stage 'PhoenixAddon-NaturalTuning-15Pro-V1.4.0-槐蔭區2改.apk'
New-Item -ItemType Directory -Force -Path $classes, $dexDir | Out-Null

$sources = @()
$sources += Get-ChildItem -LiteralPath (Join-Path $Stage 'java') -Recurse -Filter '*.java' |
    ForEach-Object { $_.FullName }
$sources += Get-ChildItem -LiteralPath (Join-Path $Stage 'stubs') -Recurse -Filter '*.java' |
    ForEach-Object { $_.FullName }

& $javac -encoding UTF-8 -source 8 -target 8 -Xlint:-options `
    -classpath $AndroidJar `
    -d $classes @sources
if ($LASTEXITCODE -ne 0) {
    throw 'javac failed'
}

$moduleClasses = Get-ChildItem -LiteralPath (Join-Path $classes 'com\prometheus\camera\natural15pro') `
    -Filter '*.class' | ForEach-Object { $_.FullName }
& $d8 --release --min-api 31 --lib $AndroidJar --output $dexDir @moduleClasses
if ($LASTEXITCODE -ne 0) {
    throw 'd8 failed'
}

& $aapt2 compile --dir (Join-Path $Stage 'res') -o $resZip
if ($LASTEXITCODE -ne 0) {
    throw 'aapt2 compile failed'
}
& $aapt2 link -o $baseApk -I $AndroidJar `
    --manifest (Join-Path $Stage 'AndroidManifest.xml') `
    --min-sdk-version 31 --target-sdk-version 35 `
    --version-code 4 --version-name '1.4.0-15Pro-4' `
    $resZip
if ($LASTEXITCODE -ne 0) {
    throw 'aapt2 link failed'
}

Copy-Item -LiteralPath $baseApk -Destination $unsignedApk -Force
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::Open($unsignedApk, 'Update')
try {
    $dex = Join-Path $dexDir 'classes.dex'
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $zip, $dex, 'classes.dex',
        [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
    $assetRoot = Join-Path $Stage 'assets'
    Get-ChildItem -LiteralPath $assetRoot -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($assetRoot.Length + 1).Replace('\', '/')
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $_.FullName, 'assets/' + $relative,
            [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
} finally {
    $zip.Dispose()
}

& $zipalign -f -p 4 $unsignedApk $alignedApk
if ($LASTEXITCODE -ne 0) {
    throw 'zipalign failed'
}

$keystore = Join-Path $src 'keystore\natural15pro.jks'
if (-not (Test-Path -LiteralPath $keystore)) {
    & $keytool -genkeypair -keystore $keystore -alias natural15pro `
        -keyalg RSA -keysize 2048 -validity 10000 `
        -storepass phoenixnatural -keypass phoenixnatural `
        -dname 'CN=Phoenix NaturalTuning 15Pro, OU=Huaiyin, O=PhoenixAddon, C=CN'
    if ($LASTEXITCODE -ne 0) {
        throw 'keytool failed'
    }
}

& $apksigner sign --ks $keystore --ks-key-alias natural15pro `
    --ks-pass pass:phoenixnatural --key-pass pass:phoenixnatural `
    --min-sdk-version 31 --v2-signing-enabled true --v3-signing-enabled true `
    --out $finalApk $alignedApk
if ($LASTEXITCODE -ne 0) {
    throw 'apksigner failed'
}

& $apksigner verify --print-certs $finalApk
if ($LASTEXITCODE -ne 0) {
    throw 'apksigner verify failed'
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$target = Join-Path $OutDir (Split-Path $finalApk -Leaf)
Copy-Item -LiteralPath $finalApk -Destination $target -Force
Get-Item -LiteralPath $target | Select-Object FullName, Length
Get-FileHash -LiteralPath $target -Algorithm SHA256
