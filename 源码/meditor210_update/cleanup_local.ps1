#requires -Version 7.0
<##
仅清理 2026-10-30 相册更新任务的临时目录和构建中间产物。
此脚本因自动安全审查拒绝代理执行删除而提供，需用户在 PowerShell 7 运行。
保留源码、成品、作者输入、验证证据和回退备份。
##>

$ErrorActionPreference = 'Stop'
$cameraProjectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$cameraExpectedProject = 'D:\GPT\2026-09-27_小米15Pro_Phoenix相机适配'
if ($cameraProjectRoot -ne $cameraExpectedProject) { throw '项目目录不匹配，停止清理' }
$cameraSlug = '2026-10-30_meditor210_update'
$cameraDeliveryRoot = Join-Path $cameraProjectRoot "04_交付\$cameraSlug"
$cameraModule = Join-Path $cameraDeliveryRoot 'Phoenix_15Pro_Camera_M3_MEditor210_AllInOne-1.3.0.zip'
$cameraBackupRoot = Join-Path $cameraProjectRoot "02_数据\$cameraSlug\rollback"
if (-not (Test-Path -LiteralPath $cameraModule -PathType Leaf)) { throw '正式整合包缺失，停止清理' }
if ((Get-FileHash -LiteralPath $cameraModule -Algorithm SHA256).Hash -ne 'EEE9ECDBC6A87A8D56B5FCF121B9DD7E34293939B93AB75C19131C6E0693D607') {
    throw '正式整合包摘要不匹配，停止清理'
}
foreach ($cameraBackupFile in @('old_allinone_lsp.apk','old_mediaeditor.apk','mediaeditor_data_before.tar.gz','lsposed_config_before.tar.gz')) {
    if (-not (Test-Path -LiteralPath (Join-Path $cameraBackupRoot $cameraBackupFile) -PathType Leaf)) {
        throw "回退备份缺失：$cameraBackupFile"
    }
}
$cameraCleanupTargets = @(
    (Join-Path $cameraProjectRoot "99_临时\$cameraSlug"),
    (Join-Path $cameraProjectRoot "03_输出\$cameraSlug")
)
$cameraRemovedBytes = 0L
$cameraRemovedFiles = 0
$cameraValidatedTargets = @()
foreach ($cameraTarget in $cameraCleanupTargets) {
    $cameraAbsolute = [IO.Path]::GetFullPath($cameraTarget)
    if ($cameraAbsolute -notin $cameraCleanupTargets -or
        -not $cameraAbsolute.StartsWith($cameraProjectRoot + '\',[StringComparison]::OrdinalIgnoreCase)) {
        throw '清理对象越界，停止清理'
    }
    if (-not (Test-Path -LiteralPath $cameraAbsolute)) { continue }
    $cameraRootItem = Get-Item -LiteralPath $cameraAbsolute -Force
    if (-not $cameraRootItem.PSIsContainer -or ($cameraRootItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw '清理目标类型异常或是链接，停止清理'
    }
    $cameraItems = @(Get-ChildItem -LiteralPath $cameraAbsolute -Recurse -Force -ErrorAction Stop)
    foreach ($cameraItem in $cameraItems) {
        if (-not $cameraItem.FullName.StartsWith($cameraAbsolute + '\',[StringComparison]::OrdinalIgnoreCase) -or
            ($cameraItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw '发现越界对象或链接，停止清理'
        }
    }
    $cameraFiles = @($cameraItems | Where-Object { -not $_.PSIsContainer })
    $cameraRemovedFiles += $cameraFiles.Count
    $cameraRemovedBytes += [long](($cameraFiles | Measure-Object -Property Length -Sum).Sum)
    $cameraValidatedTargets += $cameraAbsolute
}
foreach ($cameraTarget in $cameraValidatedTargets) {
    Remove-Item -LiteralPath $cameraTarget -Recurse -Force -ErrorAction Stop
    if (Test-Path -LiteralPath $cameraTarget) { throw "目录仍存在：$cameraTarget" }
}
$cameraSidecar = Join-Path $cameraDeliveryRoot 'Phoenix_LSP_AllInOne-MEditor210-1.3.0-15Pro.apk.idsig'
if (Test-Path -LiteralPath $cameraSidecar -PathType Leaf) {
    $cameraRemovedBytes += (Get-Item -LiteralPath $cameraSidecar).Length
    $cameraRemovedFiles += 1
    Remove-Item -LiteralPath $cameraSidecar -ErrorAction Stop
}
$cameraReport = [ordered]@{
    status = 'PASS'
    removed_files = $cameraRemovedFiles
    removed_bytes = $cameraRemovedBytes
    removed_targets = $cameraValidatedTargets
    formal_artifacts_and_backups_preserved = $true
}
$cameraReportPath = Join-Path $cameraProjectRoot "06_测试\$cameraSlug\local_cleanup_completed.json"
$cameraReport | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $cameraReportPath -Encoding utf8
Write-Output ('本轮缓存清理完成，释放 {0:N2} GB；正式成品和回退备份已保留。' -f ($cameraRemovedBytes / 1e9))
