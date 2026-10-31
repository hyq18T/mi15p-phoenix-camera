param(
    [Parameter(Mandatory=$true)][string]$WorkDir,
    [Parameter(Mandatory=$true)][string]$MergedTree,
    [string]$BuildTools='D:\GPT\_phoenix_build\_android-sdk\build-tools\35.0.0'
)
$ErrorActionPreference='Stop'
$runtimeRoot=Join-Path $WorkDir 'runtime_compile'
if (Test-Path -LiteralPath $runtimeRoot) { throw 'runtime 编译目录已存在' }
New-Item -ItemType Directory -Path $runtimeRoot | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'java') -Destination (Join-Path $runtimeRoot 'java') -Recurse
$projectRoot=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$stubs=Join-Path $projectRoot '04_交付\git仓库-Phoenix-1.3.0-15Pro-槐蔭區2改\addons\NaturalTuning\source\lsp-src\stubs'
Copy-Item -LiteralPath $stubs -Destination (Join-Path $runtimeRoot 'stubs') -Recurse
$classes=Join-Path $runtimeRoot 'classes'
$dex=Join-Path $runtimeRoot 'dex'
New-Item -ItemType Directory -Path $classes,$dex | Out-Null
$androidJar='D:\GPT\_phoenix_build\_android-sdk\platforms\android-35\android.jar'
$javaFiles=@(Get-ChildItem -LiteralPath (Join-Path $runtimeRoot 'java'),(Join-Path $runtimeRoot 'stubs') -Recurse -Filter '*.java' | ForEach-Object { $_.FullName })
& javac "-J-Djava.io.tmpdir=$WorkDir\tmp" -encoding UTF-8 -source 8 -target 8 -Xlint:-options -classpath $androidJar -d $classes @javaFiles
if ($LASTEXITCODE -ne 0) { throw 'runtime javac 失败' }
$compiledFiles=@(Get-ChildItem -LiteralPath (Join-Path $classes 'com\prometheus\camera\meditor210') -Filter '*.class' | ForEach-Object { $_.FullName })
& (Join-Path $BuildTools 'd8.bat') --release --min-api 31 --lib $androidJar --output $dex @compiledFiles
if ($LASTEXITCODE -ne 0) { throw 'runtime d8 失败' }
New-Item -ItemType Directory -Path (Join-Path $MergedTree 'unknown') -Force | Out-Null
Copy-Item -LiteralPath (Join-Path $dex 'classes.dex') -Destination (Join-Path $MergedTree 'unknown\classes15.dex')
Write-Output 'RUNTIME_JAVA_D8=PASS'
