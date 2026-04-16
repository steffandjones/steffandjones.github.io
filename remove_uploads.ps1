$files = Get-ChildItem 'D:\Desktop\Documents\portfolio\*.html'
foreach ($f in $files) {
    $c = Get-Content $f.FullName -Raw
    $c = $c -replace '\s*<label class="upload-slot">.*?</label>', ''
    Set-Content $f.FullName $c -NoNewline
}
Write-Host "Done."
