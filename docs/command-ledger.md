# Veristio Command Ledger
Status: Active
Program: VERISTIO

Purpose:
This document is the canonical location for reusable commands, procedures,
and operational rules for the Veristio web projects.
Commands live here, not buried in chat history.

Rule:
- ASCII-only source files
- Prefer whole-file replacement over line edits
- Explicit paths required to avoid terminal path drift

---

## Canonical Repo Root

Veristio Main Site (Windows):

C:\Dev\HCJ\Veristio_Web

Recommended per-session anchor:

$VROOT = "C:\Dev\HCJ\Veristio_Web"
cd $VROOT

All commands below assume execution from repo root unless otherwise stated.

---

## Dev Server

Start dev server (safe, path-explicit):

cd C:\Dev\HCJ\Veristio_Web; npm run dev

Stop dev server:

Ctrl+C

If routes behave unexpectedly:
- Stop server
- Restart from repo root
- Hard-refresh browser (Ctrl+Shift+R)

---

## Astro Route Ownership (Critical)

Astro routes collide when BOTH exist:
- src/pages/<route>.astro (or .md/.mdx)
- src/pages/<route>/index.astro

Examples encountered:
- /products
- /company
- /legal

Astro currently warns; future versions will hard-error.
Collisions must be resolved immediately.

---

## Route Collision Detection

Example: detect /products collisions

cd C:\Dev\HCJ\Veristio_Web; Get-ChildItem .\src\pages -Recurse -File |
  Where-Object {
    $_.FullName -match '\\products\.(astro|md|mdx)$' -or
    $_.FullName -match '\\products\\index\.(astro|md|mdx)$'
  } |
  Select-Object FullName

---

## Route Collision Resolution (Standard)

Rule:
- Folder-based route wins
- Flat file is quarantined, never deleted

Convention:
Rename flat file to *_LEGACY_HOLD.*

Examples:

cd C:\Dev\HCJ\Veristio_Web; Rename-Item .\src\pages\products.astro products_LEGACY_HOLD.astro
cd C:\Dev\HCJ\Veristio_Web; Rename-Item .\src\pages\company.astro company_LEGACY_HOLD.astro
cd C:\Dev\HCJ\Veristio_Web; Rename-Item .\src\pages\legal.astro legal_LEGACY_HOLD.astro

Restart dev server after renames.

---

## Route Validation

Check if a route file exists:

cd C:\Dev\HCJ\Veristio_Web; Test-Path .\src\pages\products\ultranox\index.astro

List product folders:

cd C:\Dev\HCJ\Veristio_Web; Get-ChildItem .\src\pages\products -Directory | Select-Object Name

Optional: list all Astro routes

cd C:\Dev\HCJ\Veristio_Web; npx astro routes

---

## Canonical Product Naming

Decision:
UltraNetOps has been renamed to UltraNOx.

Canonical URL:
/products/ultranox

Canonical folder:
src/pages/products/ultranox/

Search for stale references:

cd C:\Dev\HCJ\Veristio_Web; Select-String -Path .\src\**\*.* -Pattern "UltraNetOps|ultranetops" -SimpleMatch

---

## Link and Route Alignment Policy

Rule:
Link labels must match destination intent.

Examples:
- "Legal & Terms" -> /legal
- "Products" -> /products
- Avoid routing "Legal & Terms" to /company

Search for a specific href:

cd C:\Dev\HCJ\Veristio_Web; Select-String -Path .\src\**\*.* -Pattern 'href="/company"' -SimpleMatch

Audit legal-related links:

cd C:\Dev\HCJ\Veristio_Web; Select-String -Path .\src\**\*.* -Pattern "/legal|/terms|Legal & Terms" -SimpleMatch

---

## ASCII-First Source Policy

Smart punctuation and non-ASCII characters are not allowed in committed sources.

Common offenders:
’ “ ” — – … →

Scan for common violations:

cd C:\Dev\HCJ\Veristio_Web; Select-String -Path .\src\**\*.* -Pattern "’|“|”|—|–|…|→" -SimpleMatch

Best-effort non-ASCII scan:

cd C:\Dev\HCJ\Veristio_Web; Get-ChildItem .\src -Recurse -File |
  ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes | Where-Object { $_ -gt 127 }) { $_.FullName }
  }

---

## Standard Reorganization Practices

- Prefer folder-based routes over flat files
- Use *_LEGACY_HOLD.* to quarantine old routes
- Replace entire files instead of editing fragments
- Restart dev server after route or folder renames
- Keep procedures here, not in chat threads

---

End of Veristio Command Ledger
