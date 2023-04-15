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
