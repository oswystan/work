#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2018 wystan
##
##       filename: monitor.sh
##    description:
##        created: 2018-09-15 22:18:37
##         author: wystan
##
###########################################################################

servicefile="services"

trap end INT
end() {
    echo ""
    echo "exit monitoring!"
    exit 0
}

dead() {
    printf "%30s - [\e[31m %s \e[0m]\n" $1 dead
}
alive() {
    printf "%30s - [\e[32m %s \e[0m]\n" $1 live
}

monitor() {
    while read oneline
    do
        name=$(echo $oneline|cut -f1 -d' ')
        ip=$(echo $oneline|cut -f2 -d' '|cut -f1 -d':')
        port=$(echo $oneline|cut -f2 -d' '|cut -f2 -d':')
        name="$name($ip:$port)"
        nc -z -w2 $ip $port 2>/dev/null 1>&2 && alive $name || dead $name
    done < $servicefile
}

run() {
    while [ 1 ]
    do
        clear
        date +'%Y-%m-%d %T'
        echo '----------------------------'
        monitor
        echo '----------------------------'
        sleep 4
    done
}

main() {
    run
}

main

###########################################################################
