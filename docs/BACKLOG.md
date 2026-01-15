# Ralph Inferno Backlog

## 🔥 Middle Loop Orchestrator

**Koncept:** Automatisera test → CR → rebuild cykeln på VM

```
┌─────────────────────────────────────────────────────────────┐
│ OUTER LOOP (Lokal)                                          │
│ Du + Claude Code                                            │
│ • /discover - skapa PRD                                     │
│ • /plan - första implementation plan                        │
│ • /deploy - skicka till VM                                  │
│ • Sov 😴                                                    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│ MIDDLE LOOP (VM) - NY!                                      │
│ Ralph Orchestrator                                          │
│ • Kör specs (inner loop)                                    │
│ • Headless browser test (Playwright)                        │
│ • Analysera resultat                                        │
│ • Skapa CR-specs automatiskt                                │
│ • Kör igen tills PASS eller MAX_ITERATIONS                  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│ INNER LOOP (VM)                                             │
│ Ralph Build                                                 │
│ • Kör en spec                                               │
│ • npm run build                                             │
│ • Commit                                                    │
└─────────────────────────────────────────────────────────────┘
```

### Middle loop ska:
1. Köra alla specs (inner loop)
2. Starta Supabase + dev server
3. Köra Playwright E2E-tester headless
4. Om fel → skapa CR-specs automatiskt (AI-genererat)
5. Köra igen (max 3 iterationer)
6. Notifiera via ntfy när klar eller blockerad

### Implementation:
- `orchestrator.sh` - huvudscript
- Playwright för headless testing (redan i stack)
- Claude API för CR-generering
- Max iterations config

### Fördel:
- Användaren gör bara första /plan
- Ralph fixar sina egna buggar
- Vaknar till mer polerad kod

---

## 📋 Andra backlog items

### /ralph:status
Realtime status från VM utan SSH
- WebSocket eller polling
- Visar nuvarande spec, progress, errors

### /ralph:abort
Stoppa Ralph på VM
- Graceful shutdown
- Spara progress

### Multi-repo support
Köra Ralph på flera projekt parallellt
- Worktrees per projekt
- Separat logging

### Cost tracking
Visa API-kostnad per run
- Token counting
- Estimat före deploy
