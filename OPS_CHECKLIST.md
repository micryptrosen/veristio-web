Set-Location -LiteralPath "C:\Dev\HCJ\Veristio_Web"

@'
# OPS CHECKLIST — Veristio Web

## Repo
micryptrosen/veristio-web.git

## Framework
Astro (static build)

## Build Output
dist/ (includes /_astro/*)

## Domains
- veristio.com
- www.veristio.com

---

## ACTIVE OBJECTIVE — Route / Label Parity

Every navigation label must map 1:1 to its route.

### Required Parity
- Overview => /overview
- Company => /company
- Legal & Terms => /legal

---

## TASK CHECKLIST (LIVE)

### Phase 1 — Overview Page
- [x] Create route: src/pages/overview.astro
- [x] Use existing site layout (no new styles)

### Phase 2 — Navigation
- [ ] Header: update links to /overview, /company, /legal
- [ ] Footer: update links to /overview, /company, /legal

### Phase 3 — Verification
- [ ] npm run build
- [ ] Confirm dist/ output
- [ ] Confirm no broken links

### Phase 4 — Commit
- [ ] git status clean
- [ ] Commit + push

---

## RULES

- Execution tracking only
- No authority declarations
- Program Command governs separately
- Full-file replacements only
- Absolute paths only
'@ | Set-Content -Encoding ASCII -LiteralPath "C:\Dev\HCJ\Veristio_Web\OPS_CHECKLIST.md"
