# NPM Publish Checklist

## Status: REDO FÖR PUBLISH

### Klart ✅
- [x] package.json konfigurerad med bin för npx
- [x] .npmignore skapad
- [x] /ralph:change-request kommando skapat
- [x] Alla 5 commands finns:
  - ralph:discover
  - ralph:plan
  - ralph:deploy
  - ralph:review
  - ralph:change-request (NY)

### Att göra
- [ ] Logga in på npm: `npm login`
- [ ] Publicera: `cd ralph-inferno && npm publish`

### Kommandon att köra

```bash
# 1. Gå till ralph-inferno
cd /Users/petersandstrom/Documents/development/claude_code/ralph-inferno

# 2. Logga in på npm (öppnar webbläsare)
npm login

# 3. Publicera
npm publish

# 4. Testa att det fungerar
npx ralph-inferno install
```

### Om det misslyckas

Om paketnamnet är taget:
```bash
# Byt namn i package.json till t.ex. @sandstream/ralph-inferno
# Publicera som scoped package:
npm publish --access public
```
