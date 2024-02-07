DirPath=$(cd "$(dirname "$0")" && pwd)

ln -sf ${DirPath}/.vimrc ~/.vimrc
ln -sf ${DirPath} ~/.config/nvim
