#!/bin/bash
if [[ $1 = "--list" ]]
  then
    cat ./inventory.json
fi
if [ $# -eq 0 ]
  then 
    echo "Pseudo_Dynamic_Inventory_Script. Use --list to show inv"
    exit 1
fi
