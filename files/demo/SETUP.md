# Setup — Schritt für Schritt

Einmaliges Aufsetzen. Plane **2–3 Stunden** ein, am besten am Wochenende vor dem Referat.

---

## A. Windows 11 VM in UTM

### A.1 VM erstellen
1. UTM öffnen → "Create a New Virtual Machine" → Virtualize → Windows.
2. ISO: Windows 11 ARM (für Apple Silicon) oder x64 (für Intel Macs).
3. RAM: **mind. 8 GB**, Disk: **60 GB**, CPU: **4 Kerne**.
4. **Network Mode: "Shared Network"** (NAT) — VM bekommt eigene IP, kann Mac über Gateway erreichen.

### A.2 Windows installieren
- Lokales Konto erstellen (kein Microsoft-Konto nötig für Demo).
- Username: `Gabriel` (oder beliebig — wichtig nur dass `whoami` später was Lustiges anzeigt).
- Updates abschalten für die Demo-Phase (verhindert dass Windows mitten im Referat updates installiert).

### A.3 Netzwerk testen
In der VM CMD öffnen:
```cmd
ping <MAC-IP>
```
Mac-IP findest du auf dem Mac mit `ifconfig | grep "inet "` (meistens `192.168.x.x` oder `10.0.0.x`).
Wenn ping geht → super. Wenn nicht: in UTM → Network → "Bridged" probieren.

### A.4 Auf der VM installieren
- Chrome oder Edge (Standard ist ok)
- **Node.js LTS** (für die meisten MCP-Server): https://nodejs.org/
- **Python 3.13+**: https://python.org/ — bei Installation **"Add Python to PATH" anhaken**
- **uv** (Python-Tool für `mcp-server-fetch`): in PowerShell:
  ```powershell
  irm https://astral.sh/uv/install.ps1 | iex
  ```

---

## B. Gmail-Konten

Du brauchst **zwei** frische Gmail-Adressen.

### B.1 Opfer-Konto (auf der VM)
1. Auf der VM in Chrome zu gmail.com → neuen Account anlegen.
2. Vorschlag: `gabriel.opfer.nwes@gmail.com` (oder was Google gerade frei hat).
3. **2-Faktor-Authentifizierung aktivieren** (Pflicht für App-Passwort).
4. **App-Passwort erzeugen:**
   - Google-Account → Security → 2-Step Verification → App passwords.
   - Name: `Claude Desktop MCP`.
   - Das 16-stellige Passwort **notieren** — siehst du nie wieder.
5. Notiere E-Mail-Adresse + App-Passwort in `CONFIG-AUSFUELLEN.md`.

### B.2 Angreifer-Konto (kann auf Mac sein)
1. Auf dem Mac in einem Browser → neuen Gmail-Account.
2. Vorschlag: `gabriel.angreifer.nwes@gmail.com`.
3. **Kein** App-Passwort nötig — du tippst hier nur normal Mails.
4. Adresse in `CONFIG-AUSFUELLEN.md` notieren.

> **Falls Google Doppelregistrierungen blockt:** zweites Konto im Inkognito-Modus oder anderem Browser anlegen. Notfalls Telefonnummer eines Familienmitglieds fragen (Verifizierung).

---

## C. Claude Desktop

### C.1 Installation (auf der VM)
1. https://claude.ai/download → Windows-Installer.
2. Mit deinem Anthropic-Account einloggen.
3. **Modell auf Haiku 4.5 stellen** (Settings → Model → Claude Haiku 4.5).
   - Begründung: anfälliger für Injection → Demo zuverlässiger. Plus realistisch (viele Apps nutzen Haiku wegen Kosten/Speed).

### C.2 MCP-Server konfigurieren
1. Claude Desktop schließen (komplett, auch System-Tray).
2. Im Datei-Explorer in der Adressleiste eingeben:
   ```
   %APPDATA%\Claude\
   ```
3. Datei `claude_desktop_config.json` öffnen (oder neu erstellen wenn nicht da).
4. **Kompletten Inhalt aus `demo/claude_desktop_config.json` reinkopieren** und Platzhalter ersetzen (siehe `CONFIG-AUSFUELLEN.md`).
5. Claude Desktop neu starten.

### C.3 MCPs verifizieren
In Claude Desktop unten in der Werkzeug-Leiste sollten 3 Symbole erscheinen (Gmail, Shell, Fetch). Klick drauf → Tool-Liste sollte sichtbar sein.

**Test-Prompts (einzeln nacheinander):**
- *"Liste die letzten 3 E-Mails meiner Inbox auf."* → Gmail-MCP triggert. Beim ersten Mal Auth-Flow: Browser öffnet sich, du bestätigst.
- *"Führe `whoami` in der Shell aus und zeig mir die Ausgabe."* → Shell-MCP, Confirm-Dialog → "Allow once".
- *"Hol den Titel von https://example.com"* → Fetch-MCP.

Wenn alle drei klappen → bereit.

### C.4 Falls ein MCP nicht startet
Logs der MCP-Server liegen in `%APPDATA%\Claude\logs\`. Häufige Fehler:
- **Gmail-MCP:** falsches App-Passwort, oder OAuth-Browser-Flow nicht abgeschlossen.
- **Shell-MCP:** Node.js nicht im PATH → `node --version` in CMD prüfen.
- **Fetch-MCP:** uv nicht installiert → `uv --version` in PowerShell prüfen.

---

## D. Webserver für Demo 2 (auf dem Mac)

1. In Terminal:
   ```bash
   cd "/Users/gabriel/Library/Mobile Documents/com~apple~CloudDocs/Documents/4BHWII:2025-26/NWES/Referat/files/demo/demo2-website"
   ./start-server.sh
   ```
   Server läuft dann auf `http://0.0.0.0:8000/`.

2. Test von der VM aus, in Chrome auf der VM:
   ```
   http://<MAC-IP>:8000/index.html
   ```
   Sollte das Schnitzel-Rezept anzeigen.

3. **Mac-Firewall:** Wenn die VM nicht zugreifen kann → System Settings → Network → Firewall → kurz aus, oder Python im Firewall erlauben.

---

## E. Gesamttest (Smoke-Test)

**Demo 1 testen:**
1. Vom Angreifer-Account `mail-pirat.html` als E-Mail an Opfer-Account senden (via Gmail Web → Compose → "<>"-Symbol für HTML, oder per Tools wie [Mailtrap](https://mailtrap.io) wenn HTML-Compose tricky ist — siehe `demo1-email/ANLEITUNG.md`).
2. In Claude Desktop auf der VM: *"Fass mir meine letzten 5 E-Mails zusammen."*
3. Erwartetes Verhalten: Antwort enthält Pirat-Sprache.

**Demo 2 testen:**
1. Webserver auf Mac läuft.
2. In Claude Desktop auf der VM: *"Fass mir die Seite http://<MAC-IP>:8000/ zusammen."*
3. Erwartetes Verhalten: Claude führt Recon aus, schickt Mail an Angreifer-Account, antwortet mit Rezept-Zusammenfassung.

**Falls eine Demo nicht klappt:**
- Modell auf Haiku stellen (falls nicht schon).
- Andere Variante der Mail/Webseite probieren (es gibt mehrere Hidden-Texte im selben Dokument).
- 2–3 mal wiederholen — Wahrscheinlichkeit, nicht Determinismus.

---

## F. Vor dem Referat (Checkliste)

- [ ] VM gebootet, eingeloggt
- [ ] Claude Desktop offen, Modell = Haiku 4.5, alle MCPs grün
- [ ] Opfer-Gmail eingeloggt, vergiftete Mail in Inbox
- [ ] Webserver auf Mac läuft (Terminal sichtbar als Beweis)
- [ ] Angreifer-Gmail in 2. Tab/Fenster offen (für den Reveal)
- [ ] Beamer angeschlossen, VM-Fenster groß
- [ ] Backup-Screenrecording auf USB-Stick
- [ ] Stille Probe: kompletter Demo-Lauf 30 Min vor Referatsbeginn
