#!/usr/bin/env bash
# Startet den Webserver für Demo 2.
# Erreichbar von der VM aus via http://<MAC_IP>:8000/

cd "$(dirname "$0")"

PORT=8000
echo "============================================================"
echo " Demo 2 — vergiftete Rezept-Seite wird gehostet"
echo "============================================================"
echo " URL (Mac):  http://localhost:$PORT/"
echo " URL (VM):   http://<MAC_IP>:$PORT/   (deine Mac-IP einsetzen)"
echo ""
echo " Mac-IP herausfinden:"
echo "   ifconfig | grep \"inet \" | grep -v 127.0.0.1"
echo ""
echo " Mac-Firewall: ggf. Python in System Settings → Network → Firewall erlauben."
echo "============================================================"
echo ""

python3 -m http.server "$PORT"
