#!/bin/bash
tput reset
echo "###############################################################"
echo " _____  ____     _____ _      ____  _   _ _   _ ______ _____   "
echo "|  __ \|  _ \   / ____| |    / __ \| \ | | \ | |  ____|  __ \  "
echo "| |  | | |_) | | |    | |   | |  | |  \| |  \| | |__  | |__) | "
echo "| |  | |  _ <  | |    | |   | |  | | .   | .   |  __| |  _  /  "
echo "| |__| | |_) | | |____| |___| |__| | |\  | |\  | |____| | \ \  "
echo "|_____/|____/   \_____|______\____/|_| \_|_| \_|______|_|  \_\ "
echo "                                              v0.1 by guilleee "
echo "###############################################################"
echo "(1) Download database to file"
echo "(2) Clone database to another database"
echo ""
read -n 1 -p "Enter your choice (q to quit):" choice
if [ "$choice" = "q" ]; then
    echo ""
    echo "bye!"
    exit 0
elif [ "$choice" = "1" ]; then
    tput reset
    echo "                      DOWNLOAD DATABASE                       "
    echo "###############################################################"
    echo "(1) Download data and tables"
    echo "(2) Download tables"
    read -n 1 -p "Enter your choice (q to quit, else return to main menu):" choice1
    if [ "$choice1" = "1" ]; then
        echo ""
        read -p "Enter IP Adress of source database (localhost by default):"  ipadrss
        read -p "Enter port of source database (3306 by default):"  prt
        read -p "Enter database name of source database (mysql by default):"  dbnm
        read -p "Enter username of source database (root by default):"  usr
        read -s -p "Enter password of source database (1234 by default):"  psswd
        if [ "$ipadrss" = "" ]; then
            ipadrss="localhost"
        fi
        if [ "$prt" = "" ]; then
            prt="3306"
        fi
        if [ "$dbnm" = "" ]; then
            dbnm="mysql"
        fi
        if [ "$usr" = "" ]; then
            usr="root"
        fi
        if [ "$psswd" = "" ]; then
            psswd="1234"
        fi
        fl="${dbnm}.sql"
        echo ""
        echo "Downloading database..."
        export MYSQL_PWD=$psswd
        mysqldump -P $prt -h $ipadrss -u $usr -B $dbnm > $fl --set-gtid-purged=OFF
        read -n 1 -p "Done! Database stored in $fl (Press any key to continue...)" none
        $0
    elif [ "$choice1" = "2" ]; then
        echo ""
        read -p "Enter IP Adress of source database (localhost by default):"  ipadrss
        read -p "Enter port of source database (3306 by default):"  prt
        read -p "Enter database name of source database (mysql by default):"  dbnm
        read -p "Enter username of source database (root by default):"  usr
        read -s -p "Enter password of source database (1234 by default):"  psswd
        if [ "$ipadrss" = "" ]; then
            ipadrss="localhost"
        fi
        if [ "$prt" = "" ]; then
            prt="3306"
        fi
        if [ "$dbnm" = "" ]; then
            dbnm="mysql"
        fi
        if [ "$usr" = "" ]; then
            usr="root"
        fi
        if [ "$psswd" = "" ]; then
            psswd="1234"
        fi
        fl="${dbnm}.sql"
        echo ""
        echo "Downloading database..."
        export MYSQL_PWD=$psswd
        mysqldump --no-data -P $prt -h $ipadrss -u $usr -B $dbnm > $fl --set-gtid-purged=OFF
        read -n 1 -p "Done! Database stored in $fl (Press any key to continue...)" none
        $0
    elif [ "$choice1" = "q" ]; then
        echo ""
        echo "bye!"
        exit 0
    else
        $0
    fi

elif [ "$choice" = "2" ]; then
    tput reset
    echo "                        CLONE DATABASE                         "
    echo "###############################################################"
    echo "(1) Clone data and tables"
    echo "(2) Clone tables"
    read -n 1 -p "Enter your choice (q to quit, else return to main menu):" choice2
    if [ "$choice2" = "1" ]; then
        echo ""
        read -p "Enter IP Adress of source database (localhost by default):"  ipadrss
        read -p "Enter port of source database (3306 by default):"  prt
        read -p "Enter database name of source database (mysql by default):"  dbnm
        read -p "Enter username of source database (root by default):"  usr
        read -s -p "Enter password of source database (1234 by default):"  psswd
        if [ "$ipadrss" = "" ]; then
            ipadrss="localhost"
        fi
        if [ "$prt" = "" ]; then
            prt="3306"
        fi
        if [ "$dbnm" = "" ]; then
            dbnm="mysql"
        fi
        if [ "$usr" = "" ]; then
            usr="root"
        fi
        if [ "$psswd" = "" ]; then
            psswd="1234"
        fi
        fl="${dbnm}.sql"
        echo ""
        
        read -p "Enter IP Adress of destiny database (localhost by default):"  dipadrss
        read -p "Enter port of destiny database (3306 by default):"  dprt
        read -p "Enter database name of destiny database (mysql by default):"  ddbnm
        read -p "Enter username of destiny database (root by default):"  dusr
        read -s -p "Enter password of destiny database (1234 by default):"  dpsswd
        if [ "$dipadrss" = "" ]; then
            dipadrss="localhost"
        fi
        if [ "$dprt" = "" ]; then
            dprt="3306"
        fi
        if [ "$ddbnm" = "" ]; then
            ddbnm="mysql"
        fi
        if [ "$dusr" = "" ]; then
            dusr="root"
        fi
        if [ "$dpsswd" = "" ]; then
            dpsswd="1234"
        fi
        echo ""
        echo "Downloading database..."
        export MYSQL_PWD=$psswd
        mysqldump -P $prt -h $ipadrss -u $usr $dbnm > $fl --set-gtid-purged=OFF
        echo "Inserting database..."
        export MYSQL_PWD=$dpsswd


        mysql -P $dprt -h $dipadrss -u $dusr -e "CREATE DATABASE IF NOT EXISTS $ddbnm;"
        mysql -P $dprt -h $dipadrss -u $dusr $ddbnm < $fl
        rm $fl
        read -n 1 -p "Done! Database clonned in ${dipadrss}:${dprt} (Press any key to continue...)" none
        $0
    elif [ "$choice2" = "2" ]; then
        echo ""
        read -p "Enter IP Adress of source database (localhost by default):"  ipadrss
        read -p "Enter port of source database (3306 by default):"  prt
        read -p "Enter database name of source database (mysql by default):"  dbnm
        read -p "Enter username of source database (root by default):"  usr
        read -s -p "Enter password of source database (1234 by default):"  psswd
        if [ "$ipadrss" = "" ]; then
            ipadrss="localhost"
        fi
        if [ "$prt" = "" ]; then
            prt="3306"
        fi
        if [ "$dbnm" = "" ]; then
            dbnm="mysql"
        fi
        if [ "$usr" = "" ]; then
            usr="root"
        fi
        if [ "$psswd" = "" ]; then
            psswd="1234"
        fi
        fl="${dbnm}.sql"
        echo ""
        
        read -p "Enter IP Adress of destiny database (localhost by default):"  dipadrss
        read -p "Enter port of destiny database (3306 by default):"  dprt
        read -p "Enter database name of destiny database (mysql by default):"  ddbnm
        read -p "Enter username of destiny database (root by default):"  dusr
        read -s -p "Enter password of destiny database (1234 by default):"  dpsswd
        if [ "$dipadrss" = "" ]; then
            dipadrss="localhost"
        fi
        if [ "$dprt" = "" ]; then
            dprt="3306"
        fi
        if [ "$ddbnm" = "" ]; then
            ddbnm="mysql"
        fi
        if [ "$dusr" = "" ]; then
            dusr="root"
        fi
        if [ "$dpsswd" = "" ]; then
            dpsswd="1234"
        fi
        echo ""
        echo "Downloading database..."
        export MYSQL_PWD=$psswd
        mysqldump --no-data -P $prt -h $ipadrss -u $usr $dbnm > $fl --set-gtid-purged=OFF
        echo "Inserting database..."
        export MYSQL_PWD=$dpsswd


        mysql -P $dprt -h $dipadrss -u $dusr -e "CREATE DATABASE IF NOT EXISTS $ddbnm;"
        mysql -P $dprt -h $dipadrss -u $dusr $ddbnm < $fl
        rm $fl
        read -n 1 -p "Done! Database clonned in ${dipadrss}:${dprt} (Press any key to continue...)" none
        $0
    elif [ "$choice2" = "q" ]; then
        echo ""
        echo "bye!"
        exit 0
    else
        $0
    fi
else
    $0
fi
