#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTTMUX?"export DOTTMUX=~/dottmux"}/bin/lib/dry_run.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は ~/.tmux.conf の設定を行うスクリプトである。
  - ~/.tmux.conf に以下のファイルの内容を反映する
    - ${DOTTMUX}/etc/deploy/000_config/tmux.conf
    - ~/.tmux.conf のバックアップは作成するが、内容を置き換えてしまうため注意

Usage:
  $(basename ${0}) [-h] [-x]

Options:
  -h print this
  -x dry-run モードで実行する
EOF
  exit 0
}

while getopts hx OPT
do
  case "$OPT" in
    h) usage ;;
    x) enable_dryrun ;;
    \?) usage ;;
  esac
done

backup_file=~/.tmux.conf.`date +%Y%m%d%H%M%S`
tmux_conf=~/.tmux.conf
app_conf=${DOTTMUX}/etc/deploy/000_config/tmux.conf


# dry-run の場合は設定ファイルを cat で出力する
if [ ! -z ${dryrun} ]; then
  cat ${app_conf}
# dry-run ではない場合は ~/.tmux.conf のバックアップを作成して、アプリの設定ファイルに置き換える
else
  # ~/.tmux.conf のバックアップを作成する
  if [ -f ${tmux_conf} ]; then
    cp ${tmux_conf} ${backup_file}
  fi
  cp ${app_conf} ${tmux_conf}
fi

exit 0
