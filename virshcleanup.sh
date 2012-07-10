#!/bin/bash
ALL=($(virsh list | grep "i-" | awk '{print $2}'))
for v in `echo ${ALL[@]}`; do
    b=($(grep ${v} /var/log/eucalyptus/* | grep -i teardown ))
    if [ -n "$b" ]; then
        TSDATE=($(date +%H%M%S.%m%d%Y))
        for x in `virsh list | grep "i-" | grep ${v} | awk '{print $1}'`; do
            TSDATE=($(date +%H%M%S.%m%d%Y))
            echo $TSDATE "Detected bad instance, destroying domain: " ${x} " instance id: "${v}
            virst destroy ${x}
            done
    else
        echo "domain: " ${x} " instance id: "${v} "is good.  Leaving alone."
    fi
done