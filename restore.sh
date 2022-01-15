#!/bin/bash
#Name: Atahan Kucuk
#Purpose: Complete Lab 4 in CNIT 340 
#Last Revision Date:  12.05.2020



REST=$1


if [[ -f $REST ]]; then 
    printf "Are you sure you want to restore backup: $REST\n"
    select answer in Yes No; do
        case $answer in
            "Yes")
                tar --overwrite -xzf $REST -C /
                ;;
            "No")
                printf "Aborting..."
                ;;
        esac
        break;
    done
else
    printf "Not a valid file..Aborting"
fi