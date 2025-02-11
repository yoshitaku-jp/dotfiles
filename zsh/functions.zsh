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
