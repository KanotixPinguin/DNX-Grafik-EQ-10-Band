#!/usr/bin/env bash
set -Eeuo pipefail
CMD=${1:-install};CONTAINER=${CONTAINER:-owrx-8013};HERE=$(cd "$(dirname "$0")"&&pwd);BACK=/opt/dnx-graphic-eq-backups
paths(){ SRC=$(docker inspect "$CONTAINER" --format '{{range .Mounts}}{{if eq .Destination "/usr/lib/python3/dist-packages/htdocs/plugins"}}{{.Source}}{{end}}{{end}}');[[ -n $SRC ]]||exit 1;INIT="$SRC/receiver/init.js";DEST="$SRC/receiver/dnx_graphic_eq";}
remove(){ python3 - "$INIT" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);t=p.read_text();a='/* DNX_GRAPHIC_EQ_START */';b='/* DNX_GRAPHIC_EQ_END */'
if a in t and b in t:x,y=t.split(a,1);_,z=y.split(b,1);p.write_text(x+z)
PY
}
install(){ [[ $EUID -eq 0 ]]||exit 1;paths;S=$(date +%F-%H%M%S);mkdir -p "$BACK/$S" "$DEST";cp -a "$INIT" "$BACK/$S/init.js";[[ -d $DEST ]]&&cp -a "$DEST" "$BACK/$S/"||true;cp "$HERE/dnx_eq.js" "$HERE/dnx_eq.css" "$DEST/";remove;cat >>"$INIT" <<'JS'
/* DNX_GRAPHIC_EQ_START */
(function(){if(window.__dnxGraphicEqLoader)return;window.__dnxGraphicEqLoader=true;var B='/static/plugins/receiver/dnx_graphic_eq/';var c=document.createElement('link');c.rel='stylesheet';c.href=B+'dnx_eq.css';document.head.appendChild(c);var s=document.createElement('script');s.src=B+'dnx_eq.js';document.head.appendChild(s)})();
/* DNX_GRAPHIC_EQ_END */
JS
command -v node>/dev/null&&node --check "$INIT";docker restart "$CONTAINER";echo 'Installiert. 60–90 Sekunden warten.';}
uninstall(){ [[ $EUID -eq 0 ]]||exit 1;paths;S=$(date +%F-%H%M%S);mkdir -p "$BACK/$S";cp -a "$INIT" "$BACK/$S/init.js";remove;rm -rf "$DEST";docker restart "$CONTAINER";echo 'Entfernt.';}
status(){ paths;grep -q DNX_GRAPHIC_EQ_START "$INIT"&&echo installiert||echo fehlt;du -sh "$DEST" 2>/dev/null||true;}
case "$CMD" in install|update)install;;uninstall)uninstall;;status)status;;*)echo 'install | update | status | uninstall';;esac
