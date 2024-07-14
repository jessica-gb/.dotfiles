# Install kitty term & essentials
brew install --cask wezterm
brew install neovim
brew install fzf
brew install ripgrep
brew install stow

# fzf bindings
/usr/local/opt/fzf/install

# install iosevka font
brew tap homebrew/cask-fonts
brew install --cask font-iosevka

# # install vim plugged
# echo "Installing vim plugged"
# if [ -d "$HOME/.local/share/nvim/site/autoload" ]
# then
#     echo "Vim plugged installed, continuing"
# else
#     sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# fi

# install plugins for vim
echo "Installing neovim plugins"  # TODO update this to install from packer
vim +’PlugInstall —sync’ +qa

# install oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]
then
    echo "oh-my-zsh install exists, continuing"
else
    echo "installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install powerlevel10k
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
then
    echo "p10k installation exists, continuing"
else
    # backup zshrc before installing p10k in case of issues
    cp ~/.zshrc ~/.backup-zshrc
    echo "installing p10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    exec zsh
fi

stow shell
stow config

echo "Finished installation"
