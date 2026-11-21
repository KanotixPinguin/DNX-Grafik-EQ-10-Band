# DNX Grafik-EQ 10 Band

Private, inoffizielle Hobby-Anpassung für eine vorhandene OpenWebRX+-Installation.

## Funktionen

- echter 10-Band-WebAudio-Equalizer
- Bypass/EQ AN-AUS
- abschaltbare animierte Pegelbalken und Spektrallinie
- Standardbänder 31 Hz bis 16 kHz
- Funk-/Sprachbänder 100 Hz bis 5 kHz
- Presets Flach, Sprache, Funk, Bass, Musik, Höhen und Rauscharm
- eigenes Preset durch Regleränderung
- kompakter auf-/zuklappbarer Bereich im Receiver-Panel
- großes verschiebbares, maximierbares und resizebares Fenster
- grüner Rahmen und sichtbare grüne Resize-Ecken
- globale oder profilspezifische Speicherung im Browser

## Installation

```bash
chmod +x install.sh
sudo ./install.sh install
```

## Update / Status / Entfernen

```bash
sudo ./install.sh update
./install.sh status
sudo ./install.sh uninstall
```

Backups liegen unter `/opt/dnx-graphic-eq-backups`.

## Technischer Hinweis

Das Modul schleift zehn `BiquadFilterNode`-Filter zwischen den vorhandenen OpenWebRX-GainNode und das AudioContext-Ziel. Ein `AnalyserNode` erzeugt die Animation. Bei Inkompatibilität sofort über den EQ-Schalter auf Bypass stellen oder das Modul deinstallieren.

## Haftung und Unabhängigkeit

Rein privates, unabhängiges Hobbyprojekt. Kein Projekt, Produkt oder offizielles Plugin von OpenWebRX oder OpenWebRX+. Keine Verbindung, Beauftragung, Unterstützung, Prüfung oder Empfehlung durch deren Entwickler oder Rechteinhaber.

Installation, Nutzung, Veränderung und Weitergabe vollständig auf eigene Gefahr. Soweit gesetzlich zulässig keine Haftung für Schäden, Ausfälle, Datenverlust, Hörschäden oder sonstige technische und rechtliche Folgen. Lautstärke vorsichtig einstellen, vorher Backups erstellen und zuerst auf einem Testsystem prüfen.
