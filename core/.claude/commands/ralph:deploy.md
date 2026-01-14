# /deploy - Deploy till VM via GitHub

Pusha projekt till GitHub och starta Ralph på VM.

## Usage
```
/deploy
/deploy --overnight   # Stäng av VM när klar
/deploy --skip-requirements  # Hoppa över requirements check
```

## Prerequisites
- IMPLEMENTATION_PLAN.md eller specs/*.md måste finnas
- VM måste vara konfigurerad (~/.ralph-vm)
- GitHub repo måste finnas

## Instructions

Du är en deployment-assistent. Kör dessa steg:

**STEG 1: VALIDERA**
1. Kolla att `docs/IMPLEMENTATION_PLAN.md` eller `specs/*.md` finns
2. Kolla att `~/.ralph-vm` finns och läs VM_IP, VM_USER
3. Kolla att git remote finns

**STEG 2: REQUIREMENTS CHECK (om inte --skip-requirements)**

Kör requirements check LOKALT först (inte på VM):

```bash
# Hitta requirements.sh från template eller scripts
if [ -f ".ralph/scripts/requirements.sh" ]; then
  .ralph/scripts/requirements.sh --check
elif [ -f ".ralph/templates/stacks/react-supabase/scripts/requirements.sh" ]; then
  .ralph/templates/stacks/react-supabase/scripts/requirements.sh --check
else
  echo "No requirements.sh found, skipping"
fi
```

Om requirements FAILAR:
- Visa vad som saknas
- Ge instruktioner för manuell fix (speciellt auth)
- STOPPA deploy tills fixat

Om requirements OK → fortsätt till steg 3.

**STEG 3: PUSHA TILL GITHUB**
```bash
git add -A
git commit -m "Deploy: $(date +%Y-%m-%d_%H:%M)" || true
git push origin main
```

**STEG 5: STARTA PÅ VM**
Kör via SSH:
```bash
# Hämta VM-config
source ~/.ralph-vm

# SSH till VM och kör
ssh $VM_USER@$VM_IP << 'EOF'
  cd ~/projects

  # Klona eller uppdatera repo
  REPO_NAME=$(basename $(git remote get-url origin 2>/dev/null || echo "project") .git)

  if [ -d "$REPO_NAME" ]; then
    cd "$REPO_NAME"
    git pull origin main
  else
    gh repo clone $(git remote get-url origin) "$REPO_NAME"
    cd "$REPO_NAME"
  fi

  # Installera node_modules om saknas
  [ -f "package.json" ] && [ ! -d "node_modules" ] && npm install

  # Gör ralph körbar
  chmod +x ralph .ralph/scripts/*.sh 2>/dev/null || true

  # Starta Ralph i bakgrunden
  # VIKTIGT: Kör ALLTID ./.ralph/scripts/ralph.sh - ALDRIG ./ralph build!
  nohup ./.ralph/scripts/ralph.sh > ralph-deploy.log 2>&1 &
  echo "Ralph startad med PID: $!"
EOF
```

**VIKTIGT - RÄTT KOMMANDO:**
- ✅ RÄTT: `./.ralph/scripts/ralph.sh`
- ❌ FEL: `./ralph build` (finns inte!)
- ❌ FEL: `./ralph run` (finns inte!)

**STEG 6: BEKRÄFTA**
Skriv ut:
```
✅ DEPLOY KLAR!

Ralph kör nu på VM: $VM_IP

Följ progress:
  - ntfy.sh (notifieringar)
  - ssh $VM_USER@$VM_IP 'tail -f ~/projects/REPO/ralph-deploy.log'

När klar:
  /review    # Öppna tunnlar och testa
```

**VIKTIGT:**
- Använd `gh repo clone` INTE `git clone` (hanterar auth)
- Kör ralph.sh i bakgrunden med nohup
- Ge användaren kommandon för att följa progress
