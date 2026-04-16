# Was du noch eintragen musst

Damit die Demos laufen, müssen ein paar Platzhalter ersetzt werden. Hier die komplette Liste — sammle alle Werte und ersetze sie dann in einem Rutsch in den jeweiligen Files.

---

## 1. Werte sammeln

| Platzhalter | Wo bekommen | Dein Wert (eintragen) |
|---|---|---|
| `<OPFER_EMAIL>` | E-Mail-Adresse des Opfer-Accounts (auf der VM) | `_____________________` |
| `<OPFER_APP_PASSWORD>` | Gmail App-Passwort des Opfer-Accounts (16-stellig) | `_____________________` |
| `<ANGREIFER_EMAIL>` | E-Mail-Adresse des Angreifer-Accounts (auf dem Mac) | `_____________________` |
| `<MAC_IP>` | IP des Macs im Netz (`ifconfig \| grep "inet "`) | `_____________________` |
| `<VM_USERNAME>` | Windows-Username in der VM (z.B. `Gabriel`) | `_____________________` |

---

## 2. Wo die Werte hin müssen

### `claude_desktop_config.json`
- `<OPFER_EMAIL>` → unter `gmail.env.GMAIL_USER`
- `<OPFER_APP_PASSWORD>` → unter `gmail.env.GMAIL_APP_PASSWORD`

### `demo1-email/mail-pirat.html`
- `<ANGREIFER_EMAIL>` → einmal im Footer (für den Reveal-Moment, nicht zwingend funktional)

### `demo1-email/mail-exfiltration.html`
- `<ANGREIFER_EMAIL>` → mehrfach (das ist die Adresse, an die exfiltriert wird)

### `demo2-website/index.html`
- `<ANGREIFER_EMAIL>` → mehrfach (Empfänger der Recon-Mail)

### `PRESENTATION.md`
- `<MAC_IP>` → in der URL die du Claude gibst

---

## 3. Schnell-Ersetzen mit `sed` (Mac-Terminal)

```bash
cd "/Users/gabriel/Library/Mobile Documents/com~apple~CloudDocs/Documents/4BHWII:2025-26/NWES/Referat/files/demo"

# Werte hier oben einmal setzen:
OPFER_EMAIL="gabriel.opfer.nwes@gmail.com"
ANGREIFER_EMAIL="gabriel.angreifer.nwes@gmail.com"
MAC_IP="192.168.1.42"
VM_USERNAME="Gabriel"

# Ersetzen in allen relevanten Files:
find . -type f \( -name "*.html" -o -name "*.md" -o -name "*.json" \) \
  -exec sed -i '' "s|<OPFER_EMAIL>|$OPFER_EMAIL|g" {} \; \
  -exec sed -i '' "s|<ANGREIFER_EMAIL>|$ANGREIFER_EMAIL|g" {} \; \
  -exec sed -i '' "s|<MAC_IP>|$MAC_IP|g" {} \; \
  -exec sed -i '' "s|<VM_USERNAME>|$VM_USERNAME|g" {} \;
```

> **Achtung:** Das App-Passwort musst du **manuell** in `claude_desktop_config.json` eintragen — sed mit Passwort wäre unschön (landet in Shell-History).

---

## 4. Verifikation

Nach dem Ersetzen:

```bash
grep -r "<OPFER_EMAIL>\|<ANGREIFER_EMAIL>\|<MAC_IP>\|<VM_USERNAME>" demo/
```

Wenn nichts mehr ausgegeben wird → alles ersetzt. Wenn doch was kommt → manuell nachziehen.

App-Passwort in der Config prüfen:

```bash
grep "GMAIL_APP_PASSWORD" demo/claude_desktop_config.json
```

Sollte das echte 16-stellige Passwort zeigen, nicht den Platzhalter.
