#!/bin/bash

#valid ids
IDS=("_km"
"_kms"
"_au"
"_aus"
"_speed"
"_lt")

KEYS=('$5$6$7$8'
'$5$6$7$8'
'$5'
'$5'
'$4$5'
'$6')

while :
do
    echo -n "$(date +%T) " >> /tmp/debug
    chromium \
	    --disable-gpu \
	    --disable-gpu-compositing \
	    --disable-gpu-driver-bug-workarounds \
	    --disable-gpu-early-init \
	    --disable-gpu-memory-buffer-compositor-resources \
	    --disable-gpu-memory-buffer-video-frames \
	    --disable-gpu-process-crash-limit \
	    --disable-gpu-process-for-dx12-info-collection \
	    --disable-gpu-program-cache \
	    --disable-gpu-rasterization \
	    --disable-gpu-sandbox \
	    --disable-gpu-shader-disk-cache \
	    --disable-gpu-vsync \
	    --disable-gpu-watchdog \
	    --add-gpu-appcontainer-caps \
	    --disable-software-rasterizer \
	    --no-sandbox \
	    --headless \
	    --dump-dom \
	    'https://voyager.jpl.nasa.gov/mission/status/' > /tmp/voydata
    if [ -e /tmp/voydata ]; then
        for n in 1 2
        do
            for i in ${!IDS[@]}
            do
                var=voy$n${IDS[i]}
                grep $var /tmp/voydata | awk -F'[>, <]' '{print '${KEYS[i]}'; exit}' > /tmp/$var
            done
        done
	    cat /tmp/voy2_kms >> /tmp/debug
	    rm /tmp/voydata
    else
	    echo "fail?" >> /tmp/debug
    fi
    sleep 5
    echo " " >> /tmp/debug
done
