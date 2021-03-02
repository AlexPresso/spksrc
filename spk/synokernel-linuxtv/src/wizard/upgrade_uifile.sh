#!/bin/sh
set +x

CFG_FILE="/usr/local/${SYNOPKG_PKGNAME}/etc/${SYNOPKG_PKGNAME}.ini"
. ${CFG_FILE}

# Ensure to add any new entries in the $OPTIONS
# variable below so it always get a value
# even though it didn't exist previously in the
# .ini configuration file
OPTIONS=( PCTV461E HAUPPAUGE_WINTV_DUALHD MYGICA_T230 SMS_SIANO_MDTV )

for option in "${OPTIONS[@]}"; do
   var=${option%%=*}
   [ -z "${!var}" ] \
      && eval ${var}=false
done

FIRST=`/bin/cat<<EOF
{
    "step_title": "SynoKernel USB Serial kernel module configuration",
    "items": [{
        "type": "multiselect",
        "subitems": [{
            "key": "default",
            "desc": "V4L2-core",
            "disabled": true,
            "defaultValue": true
        },
        {
            "key": "PCTV461E",
            "desc": "Allegro A8293, Empia EM28178, Montage M88DS3103, Montage M88TS2022",
            "defaultValue": $PCTV461E
        },
        {
            "key": "HAUPPAUGE_WINTV_DUALHD",
            "desc": "Hauppauge WinTV Dual-HD",
            "defaultValue": $HAUPPAUGE_WINTV_DUALHD
        },
        {
            "key": "MYGICA_T230",
            "desc": "MyGica T230A, MyGica T230C, MyGica T230C2, MyGica T230C2 Lite",
            "defaultValue": $MYGICA_T230
        },
        {
            "key": "SMS_SIANO_MDTV",
            "desc": "Siano Mobile Digital MDTV Receiver",
            "defaultValue": $SMS_SIANO_MDTV
        }]
    }]
}

EOF`

echo "[$FIRST]" > $SYNOPKG_TEMP_LOGFILE

exit 0
