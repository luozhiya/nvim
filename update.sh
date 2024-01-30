# !/bin/bash

DirPath=$(cd "$(dirname "$0")" && pwd)

make_neovim() {
    if [ -d ${DirPath}/neovim ]
        mkdir -p ${DirPath}/neovim
    	cd ${DirPath}
    	git clone https://github.com/neovim/neovim neovim
    then
    	echo "The directory exists"
    fi
    cd ${DirPath}/neovim
    make clean
    rm compile_commands.json
    rm -rf build
    git pull
    git rebase origin/master
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_EXPORT_COMPILE_COMMANDS=True -DCMAKE_INSTALL_PREFIX=${DirPath}/nvim"
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

install_neovim() {
    ln -s build/compile_commands.json compile_commands.json
    rm -rf ${DirPath}/nvim
    make install
    rm -rf ${DirPath}/nvim/lib/nvim/parser
}

RED='\e[1;31m'
YELLOW='\e[1;33m'
ZERO='\033[0m'
RESET='\e[0m'

make_neovim
if [ $? -eq 0 ]; then 
    install_neovim;
else
    echo -e "${YELLOW}[Neovim Update] Failed: make neovim failed stop installing.${RESET}"
fi 
