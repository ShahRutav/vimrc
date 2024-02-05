# vimrc

## Installtion

[vim-plug](https://github.com/junegunn/vim-plug): For unix based systems, simply run:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Python Installations

```
pip install pycodestyle pylint
```

## Setup

For [openAI GPT4 access](https://github.com/madox2/vim-ai):
```
# save api key to `~/.config/openai.token` file
echo "YOUR_OPENAI_API_KEY" > ~/.config/openai.token

# alternatively set it as an environment variable
export OPENAI_API_KEY="YOUR_OPENAI_API_KEY"
```

# Mac Installation

## Vim

```
brew install vim
brew update
brew upgrade vim
alias vim='/opt/homebrew/Cellar/vim/9.0.1450/bin/vim'
```

## vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

For Plugins (`:source %` and): `:PlugInstall`

## copilot

1. Install [nodejs](https://nodejs.org/en/download)
2. `:Copilot setup`

## gpt-4

```
# save api key to `~/.config/openai.token` file
echo "YOUR_OPENAI_API_KEY" > ~/.config/openai.token

# alternatively set it as an environment variable
export OPENAI_API_KEY="YOUR_OPENAI_API_KEY"
```

## jupyter vim

For detailed [instructions](https://github.com/jupyter-vim/jupyter-vim)
1. `pip install jupyter`
2. Follow the steps [here](https://github.com/jupyter-vim/jupyter-vim?tab=readme-ov-file#jupyter-configuration)
3. To begin a session:
```
$ jupyter qtconsole &  # open a jupyter console window
$ vim <your_script>.py
:JupyterConnect
```

## vimtex setup

1. Install basic mac-tex: `https://www.ctan.org/pkg/mactex-basic`
2. Upgrade it: `sudo tlmgr update --self`
3. latexmk: `sudo tlmgr install latexmk`
4. Install: `brew install --cask skim`
4. Change the pdfviewer to `skim` instead of `zathura`
