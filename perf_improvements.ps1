$files = Get-ChildItem 'D:\Desktop\Documents\portfolio\*.html'
foreach ($f in $files) {
    $c = Get-Content $f.FullName -Raw

    # Gallery images: lazy load + async decode
    $c = $c -replace '(<div class="gallery-img"><img)(?! loading=) (src=)', '$1 loading="lazy" decoding="async" $2'

    # Project card/full images: lazy load
    $c = $c -replace '(<div class="project-(?:card|full)-img">[^<]*<img)(?! loading=) (src=)', '$1 loading="lazy" $2'

    # About photo: lazy load
    $c = $c -replace '(<div class="about-photo">[^<]*<img)(?! loading=) (src=)', '$1 loading="lazy" $2'

    # Hero images: high fetch priority (loads faster, improves LCP)
    $c = $c -replace '(<div class="page-hero-img">[^<]*<img)(?! fetchpriority=) (src=)', '$1 fetchpriority="high" $2'
    $c = $c -replace '(<div class="hero-image">[^<]*<img)(?! fetchpriority=) (src=)', '$1 fetchpriority="high" $2'

    # Add fonts.gstatic.com preconnect if missing
    if ($c -notmatch 'fonts\.gstatic\.com') {
        $c = $c -replace '(<link rel="preconnect" href="https://fonts\.googleapis\.com">)', '<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
    }

    Set-Content $f.FullName $c -NoNewline
}
Write-Host "Done."
