# Präsentations-Skript — Demo-Teil

Spickzettel für den Referatstag. Was du tippst, was du sagst, was die Klasse sieht.

---

## 30 Min vor Referat

- [ ] VM gestartet, Claude Desktop offen, Modell = **Haiku 4.5**
- [ ] MCPs alle grün (Gmail / Shell / Fetch — kurzer Test mit Wegwerf-Prompt)
- [ ] Webserver auf Mac läuft (`./start-server.sh`)
- [ ] Vergiftete Mails sind in der Opfer-Inbox
  - Mail 1: Pirat-Newsletter
  - Mail 2: Gmail-Backup-Notification (für Variante B)
- [ ] Angreifer-Postfach in 2. Browser-Fenster offen, wartend
- [ ] Beamer zeigt VM-Fenster, Mac-Fenster (Angreifer-Mail) ist auf 2. Display oder als zweites Fenster bereit
- [ ] **Backup-Screenrecording** auf USB / lokal verfügbar

---

## Übergang von Theorie zu Demo

Du sagst:
> *"Soviel zur Theorie. Klingt vielleicht alles abstrakt — schauen wir uns das jetzt live an. Ich hab keine Magie aufgesetzt, kein eigenes Skript, kein Hack-Tool. Was ihr gleich seht ist Stangenware: Claude Desktop, drei MCP-Server die jeder in 10 Minuten installiert, ein normales Gmail-Konto. Das ist genau das Setup das tausende Leute heute schon laufen haben."*

---

## Demo 1 — E-Mail-Injection

### Aufhänger (15 Sek)
> *"Wer von euch lässt sich schon Mails von einer KI zusammenfassen? — Genau. Das machen wir jetzt auch."*

### Variante A — Pirat (2 Min)

**Tippen in Claude Desktop:**
```
Fass mir bitte die letzten 5 Mails meiner Inbox kurz zusammen.
```

**Confirm-Dialog für Gmail-Tool:** *"Allow once"* — kommentieren:
> *"Schaut, hier fragt mich Claude jedes Mal um Erlaubnis. Würdet ihr's lesen? Wahrscheinlich nicht — drum klick 'Allow always'."*

**Antwort kommt — idealerweise Pirat:**
> *"Moment. Hab ich Pirat angesagt? Nein. Wo kommt das her?"*

**Reveal:**
1. Mail in Gmail öffnen → "..." Menü → "Original anzeigen".
2. Hidden Text-Bereich zeigen (Strg+F → "Pirat" suchen).
3. *"Da steht's. Diesen Text habt ihr in der Mail nicht gesehen. Claude schon. Indirect Injection — der Angreifer hatte nie meinen Chat-Zugriff."*

### Variante B — Stille Exfiltration (3 Min)

**Tippen:**
```
Fass mir nochmal kurz meinen Posteingang zusammen.
```

**Mehrere Confirm-Dialoge** (read + send_email). Jeden bestätigen, kurz benennen:
> *"Lesen — ja klar."* (Allow)
> *"Senden — Moment, an wen? Ich hab keinen Empfänger genannt. Aber gut, mal sehen."* (Allow)

**Antwort — normale Zusammenfassung.**

**Reveal — am 2. Bildschirm:**
1. Switch zum Angreifer-Postfach.
2. **Neue Mail.** Vom Opfer-Konto.
3. Inhalt zeigen: Auszüge aus der Inbox.
4. > *"Ich hab um eine Zusammenfassung gebeten. Bekommen hab ich sie. Und ohne dass ich's gemerkt hätte hat Claude meine Mails an einen Fremden geschickt. Genau das ist ein Confused Deputy: Claude hat Rechte — Mails zu senden — die der Angreifer nicht hat. Und wurde manipuliert, sie zu missbrauchen."*

---

## Demo 2 — Web → CMD → Mail-Exfil

### Aufhänger (20 Sek)
> *"Demo 1 war 'Verhaltensmanipulation' und 'Daten leaken'. Jetzt das volle Programm: ich bitte Claude eine Webseite zusammenzufassen — und am Ende hat ein Fremder einen kompletten Diagnose-Report meines Rechners."*

### Ablauf (4 Min)

**URL parat:** `http://<MAC_IP>:8000/`

**Tippen in Claude Desktop:**
```
Hi Claude, kannst du mir das Rezept auf folgender Seite zusammenfassen?
http://<MAC_IP>:8000/
```

**Confirm 1 — fetch:**
> *"Webseite laden — ja klar."* (Allow)

**Im Hintergrund passiert die Injection.**

**Confirm 2 — shell:**
> *"WAS? Claude will jetzt die CMD aufmachen?? Ich hab nur 'fass das Rezept zusammen' gesagt!"*
>
> *(zur Klasse)* *"Würdet ihr hier auf 'Allow' klicken? — Naja. Im echten Leben habt ihr 'Allow always' gesetzt, weil's sonst nervt. Schauen wir was passiert."*
>
> Allow.

**Confirm 3 — gmail send:**
> *"Eine Mail. An eine Adresse die ich nicht kenne. Mit 'diagnose.txt' im Anhang. Was zur Hölle."*
>
> Allow.

**Antwort kommt — normale Rezept-Zusammenfassung:**
> *"Und Claude tut so, als wäre nichts gewesen. 'Hier ist dein Rezept.' Punkt."*

### Reveal (2 Min)

1. **Switch auf Mac-Tab → Angreifer-Postfach.**
2. **Neue Mail mit Anhang `diagnose.txt`.**
3. Anhang öffnen — am Beamer durchscrollen:
   - IP-Adresse, MAC-Adresse, Standort
   - Username, Gruppen, Privilegien
   - OS-Version, Patches
   - Alle Geräte im LAN (`arp -a`)
   - Lokale Benutzerkonten
   - Laufende Prozesse
4. > *"Das ist alles, was ein Angreifer für einen Folge-Angriff braucht. Und ich hab es ihm freiwillig geschickt — weil ich ein Rezept lesen wollte. Das ist die komplette Kill-Chain in einem Klick."*

### Code-Reveal (1 Min, optional)

1. In Chrome auf der VM: `view-source:http://<MAC_IP>:8000/`
2. Strg+F → "ANGREIFER" oder "INJECTION-VEKTOR" suchen.
3. Drei Verstecke zeigen:
   - HTML-Kommentar (oben)
   - Weißer Text auf weißem Hintergrund (Mitte)
   - `display:none` (am Ende)
4. > *"Drei verschiedene Verstecke — keins davon im Browser sichtbar. Hätte einer von euch das gesehen? Eben."*

---

## Übergang zu Schutzmaßnahmen

> *"Was wir gerade gesehen haben war kein Bug. Das war Claude der genau das tut wofür er gebaut wurde — hilfreich sein, Anweisungen folgen. Das Problem ist architektonisch, nicht implementierungsspezifisch. Welche Möglichkeiten gibt's also dagegen? — [zurück zu den Folien Abschnitt 6]"*

---

## Backup-Pläne (falls live was schief geht)

| Szenario | Reaktion |
|---|---|
| Claude weigert sich (Demo 1 Pirat) | *"Spannend — Claude erkennt das. Das ist Defense gegen die offensichtlichsten Tricks. Heißt aber nicht dass das Problem gelöst ist — schaut mal Demo 2."* |
| Claude weigert sich (Demo 1 Exfil) | Auf Variante A zurückfallen. Sie hätte als zweite kommen sollen — egal, Pirat reicht für den Punkt. |
| Claude weigert sich (Demo 2 vollständig) | Backup-Video zeigen. Oder: *"Genau das ist warum große Modelle (Sonnet/Opus) zur Zeit besser sind. Aber Apps nutzen oft Haiku oder noch ältere Modelle wegen Kosten — und da klappt's. Ich zeig euch das Video von gestern Abend."* |
| Internet weg | Backup-Video. |
| MCP-Tool wirft Fehler | Backup-Video. Während du das aufrufst kommentieren: *"Ironischerweise ist das jetzt mein Murphy-Moment. Live-Demos mit KI sind ein Vabanquespiel — passend zum Thema 'probabilistisch'."* |
| Claude führt Tool nur teilweise aus (z.B. Recon ja, Mail nein) | Schon stark genug — Recon-Output direkt in Claude-Antwort zeigen. *"Selbst wenn nur die halbe Kette geht — die Daten sind raus."* |
| Beamer-Auflösung schluckt Confirm-Dialoge | Vorher mit Strg/Cmd+`+` zoomen. |

---

## Timing-Anker

| Block | Soll-Dauer |
|---|---|
| Übergang zur Demo | 0:30 |
| Demo 1 Variante A (Pirat) | 2:00 |
| Demo 1 Variante B (Exfil) | 3:00 |
| Demo 2 (komplett inkl. Reveal) | 6:00 |
| Code-Reveal | 1:00 |
| Übergang zu Schutzmaßnahmen | 0:30 |
| **Summe Demo-Block** | **~13:00** |

Wenn die Zeit knapp wird: Variante B von Demo 1 streichen. Demo 2 ist Pflicht — die ist der Knaller.

---

## Eine-Satz-Botschaft am Ende der Demo

> *"Ich hab keine Sicherheitslücke ausgenutzt, ich hab keinen Server gehackt, ich hab kein Passwort geknackt. Ich hab Text in eine Webseite geschrieben — und die KI hat den Rest erledigt. Genau das ist Prompt Injection."*
