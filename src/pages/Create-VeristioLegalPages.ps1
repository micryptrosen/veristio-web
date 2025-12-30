$pagesRoot = "C:\Dev\HCJ\Veristio_Web\src\pages"

if (-not (Test-Path $pagesRoot)) {
  Write-Error "Pages directory not found: $pagesRoot"
  exit 1
}

$pages = @{
  "legal.astro" = @'
---
import "../styles/veristio.css";
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Legal & Trust | Veristio</title>
  </head>

  <body>
    <main class="section">
      <div class="container">
        <h1>Legal & Trust</h1>

        <p>
          This section contains Veristio legal policies and trust documentation.
        </p>

        <ul class="bullets">
          <li><a href="/terms">Terms of Service</a></li>
          <li><a href="/privacy">Privacy Policy</a></li>
        </ul>
      </div>
    </main>
  </body>
</html>
'@

  "terms.astro" = @'
---
import "../styles/veristio.css";
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Terms of Service | Veristio</title>
  </head>

  <body>
    <main class="section">
      <div class="container">
        <h1>Terms of Service</h1>

        <p>
          These Terms of Service will govern the use of Veristio products and services.
        </p>

        <p class="note">Content forthcoming.</p>
      </div>
    </main>
  </body>
</html>
'@

  "privacy.astro" = @'
---
import "../styles/veristio.css";
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Privacy Policy | Veristio</title>
  </head>

  <body>
    <main class="section">
      <div class="container">
        <h1>Privacy Policy</h1>

        <p>
          Veristio respects user privacy and data protection principles.
        </p>

        <p class="note">Content forthcoming.</p>
      </div>
    </main>
  </body>
</html>
'@
}

foreach ($file in $pages.Keys) {
  $path = Join-Path $pagesRoot $file

  if (Test-Path $path) {
    Write-Host "SKIPPED (exists): $file"
  } else {
    [System.IO.File]::WriteAllText(
      $path,
      $pages[$file],
      [System.Text.UTF8Encoding]::new($false)
    )
    Write-Host "CREATED: $file"
  }
}
