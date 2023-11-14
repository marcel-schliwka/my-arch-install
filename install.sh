#/bin/bash

function mainMenu() {
    echo "This is my arch setup script to install DWM and some other suckless Software"
    echo "(y/n)"
    read -s -n 1 key
    case $key in
        y|Y)
            echo "You pressed 'Y'. Script starts now!"
            sleep 2
            main
            ;;
        n|N)
            echo "You pressed 'N'. Exiting..."
            sleep 2
            ;;
        *)
            echo "Wrong key was pressed! Try again"
            ;;
        esac
}



function main() {
    # Global Variables
    PIP_URL="https://bootstrap.pypa.io/get-pip.py"
    PWD=$(pwd)
    DWM_PATH="./displaymanager/dwm/"
    ST_PATH="./displaymanager/st/"
    DMENU_PATH="./displaymanager/dmenu/"
    getScriptPath



    # Install all necessary packages
    pacman -Syuu
    sudo pacman -S git nano vim zsh git xorg xorg-xinit python wget curl ttf-jetbrains-mono ttf-joypixels nitrogen picom imwheel --noconfirm

    wget $PIP_URL

    #Install Python and necessary packages like pywal for color scheme
    PYTHON_LIB_PATH=$(ls -d /usr/lib/python*)
    PYTHON_LIB_PATH="${PYTHON_LIB_PATH}/EXTERNALLY-MANAGED"

    echo $PYTHON_LIB_PATH
    sudo rm -rf $PYTHON_LIB_PATH 

    python ./get-pip.py

    cp $SCRIPT_PATH/dotfiles/.xinitrc ~/.xinitrc
    cp $SCRIPT_PATH/dotfiles/.zshrc ~/.zshrc
    cp $SCRIPT_PATH/dotfiles/.vimrc ~/.vimrc
    cp -r $SCRIPT_PATH/displaymanager/pictures ~/
    cp $SCRIPT_PATH/dotfiles/.xinitrc ~/.xinitrc

    export PATH="~/.local/bin/:$PATH"

    pywal -i ~/pictures/wallpaper01.png


    #Make Displaymanager and Terminal
    sudo make -C $SCRIPT_PATH/displaymanager/dwm clean install
    sudo make -C $SCRIPT_PATH/displaymanager/st clean install
    sudo make -C $SCRIPT_PATH/displaymanager/dmenu clean install
    
}

function getScriptPath() {
    SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
    SCRIPT_PATH="$(cd -- "$SCRIPT_PATH" && pwd)"    # absolutized and normalized
    if [[ -z "$SCRIPT_PATH" ]] ; then
    exit 1
    fi
    SCRIPT_PATH="${SCRIPT_PATH}/"
}

mainMenu