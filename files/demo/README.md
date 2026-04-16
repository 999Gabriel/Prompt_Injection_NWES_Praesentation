# Demo-Ordner — Übersicht

Hier liegt alles für die zwei Live-Demos im NWES-Referat.

## Was ist wo

```
demo/
├── DEMO.md                       Konzept-Doku (das große Bild — schon vorhanden)
├── README.md                     Dieses File — Orientierung
├── SETUP.md                      Einmal-Setup: VM, Claude Desktop, MCPs, Gmail
├── CONFIG-AUSFUELLEN.md          Was DU noch eintragen musst (E-Mails, IPs, Keys)
├── PRESENTATION.md               Skript für den Referatstag
├── claude_desktop_config.json    Template für Claude Desktop MCP-Config
│
├── demo1-email/                  DEMO 1 — Inbox-Zusammenfassung wird vergiftet
│   ├── ANLEITUNG.md
│   ├── mail-pirat.html           Variante A: Pirat-Modus (sicher, lustig)
│   └── mail-exfiltration.html    Variante B: Datenleak (ernst)
│
└── demo2-website/                DEMO 2 — Webseite → CMD-Recon → Mail-Exfil
    ├── ANLEITUNG.md
    ├── index.html                Vergiftete Rezept-Seite
    ├── style.css
    └── start-server.sh           Webserver starten
```

## Reihenfolge zum Loslesen

1. **`DEMO.md`** — verstehen worum's geht (hast du schon).
2. **`SETUP.md`** — einmal komplett durchspielen (Abend vorher).
3. **`CONFIG-AUSFUELLEN.md`** — Platzhalter ersetzen.
4. **`demo1-email/ANLEITUNG.md`** und **`demo2-website/ANLEITUNG.md`** — pro Demo durchgehen.
5. **`PRESENTATION.md`** — am Referatstag als Spickzettel.

## Wichtig — ehrliche Wahrheit über die Zuverlässigkeit

Moderne Claude-Modelle sind gegen offensichtliche Prompt Injections **trainiert**. Die Demos werden **nicht** zu 100% beim ersten Versuch klappen, vor allem nicht mit Sonnet/Opus.

**Empfehlungen für maximale Demo-Zuverlässigkeit:**

- In Claude Desktop **Haiku 4.5** als Modell wählen (kleiner, anfälliger, billiger, schneller — und genau das was viele Apps real einsetzen).
- Beide Demos **vor dem Referat mehrfach durchspielen**, Erfolgsquote messen.
- **Backup-Screenrecording** mitbringen — wenn live nichts geht, Video abspielen und kommentieren.
- Den didaktischen Punkt nutzen: *"Probabilistisch heißt — manchmal geht's, manchmal nicht. Genau das ist das Problem."*
