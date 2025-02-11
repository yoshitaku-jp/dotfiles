# cdコマンド実行後、lsを実行する
function cd() {
   builtin cd $@ && ls;
}

function pecofind() { # find コマンドの出力結果をpeco する
  if [ $# -eq 0 ]; then
    find . | peco
  else
    find $1 | peco
  fi
}
function pecofindd() { # find コマンドの出力結果をpeco する。 ファイルが選ばれたら1つ手前のディレクトリを返す
  if [ $# -eq 0 ]; then
    finded=`find . | peco`
  else
    finded=`find $1 | peco`
  fi
  if [ -f $finded ]; then
    echo $finded | perl -pe 's/\/[^\/]*$/\n/g'
  else
    echo $finded
  fi
}
function cdp() {
  dir=$(pecofindd $1)
  echo "\e[32;1mcd\e[m \e[32;1;4m$dir\e[m"
  cd $dir
}
function lsp() {
  file=$(pecofind $1)
  echo "\e[32;1mls\e[m \e[32;1;4m$file\e[m"
  ls $file
}
function rmp() {
  file=$(pecofind $1)
  echo "\e[32;1mrm\e[m \e[32;1;4m$file\e[m"
  rm $file
}
function treep() {
  file=$(pecofind $1)
  echo "\e[32;1mtree\e[m \e[32;1;4m$file\e[m"
  tree $file
}
function catp() {
  file=$(pecofind $1)
  echo "\e[32;1mcat\e[m \e[32;1;4m$file\e[m"
  cat $file
}
function vimp() {
  file=$(pecofind $1)
  echo "\e[32;1mvim\e[m \e[32;1;4m$file\e[m"
  vim $file
}
