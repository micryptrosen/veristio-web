# Normalize-VeristioNav.ps1
# Safe navigation normalization for Veristio Astro site
# Idempotent, UTF-8 (no BOM), non-destructive

$ErrorActionPreference = "Stop"

$repoRoot = "C:\Dev\HCJ\Veristio_Web"
$pagesDir = Join-Path $repoRoot "src\pages"

$targets = @(
    "index.astro",
    "products.astro",
    "ultrapro.astro"
)

Write-Host "Normalizing Veristio navigation links..." -ForegroundColor Cyan

foreach ($file in $targets) {
    $path = Join-Path $pagesDir $file

    if (-not (Test-Path $path)) {
        Write-Host "SKIPPED (missing): $file" -ForegroundColor DarkYellow
        continue
    }

    $content = Get-Content $path -Raw

    $original = $content

    # HEADER: Products link
    $content = $content -replace '<a\s+href=\{?ULTRAPRO_URL\}?\s+[^>]*>Products<\/a>', '<a href="/products">Products</a>'

    # HERO + PRODUCT CTA: View UltraPro
    $content = $content -replace '<a\s+class="link primary"\s+href=\{?ULTRAPRO_URL\}?\s+[^>]*>', '<a class="link primary" href="/ultrapro">'

    # FOOTER: UltraPro link
    $content = $content -replace '<a\s+href=\{?ULTRAPRO_URL\}?\s+[^>]*>UltraPro<\/a>', '<a href="/ultrapro">UltraPro</a>'

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText(
            $path,
            $content,
            [System.Text.UTF8Encoding]::new($false)
        )
        Write-Host "UPDATED: $file" -ForegroundColor Green
    } else {
        Write-Host "OK (no change): $file" -ForegroundColor DarkGreen
    }
}

Write-Host "Navigation normalization complete." -ForegroundColor Cyan
