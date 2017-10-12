# dottmux

dottmux とは以下を実行するプロジェクトである。

- ~/.tmux.conf の設定


# セットアップ手順

セットアップ手順は以下の通り。

```
$ cd ~/
$ git clone https://github.com/tomoyamkung/dottmux.git
$ cd dottmux
$ export DOTTMUX=~/dottmux
$ ./etc/deploy.sh  # 本プロジェクトが提供する機能を設定にする
```


# 提供機能

本プロジェクトが提供する機能は非常にシンプルであり、以下だけである。

- ~/.tmux.conf の設定


## ~/.tmux.conf の設定について

~/.tmux.conf が以下の内容で置き換わる（この内容は etc/deploy/000_config/tmux.conf に書かれている）。

```
# 設定ファイルをリロードする         
bind r source-file ~/.tmux.conf \; display "Reloaded!"                     

# prefix を C-b から C-t に変更      
set-option -g prefix C-t             
unbind-key C-b                       
bind-key C-t send-prefix             

# キーストロークのディレイを減らす   
set -sg escape-time 1                

# マウス操作を有効にする             
setw -g mouse on                     

# 256色端末を使用する                
set -g default-terminal "screen-256color"                                  

# ステータスバーをトップに配置する   
set-option -g status-position top    
# 左端に セッション番号 を表示       
set-option -g status-left "#[fg=colour255,bg=colour241]Session: #S #[default]"                                                                        # 右端に マシン名、ペイン番号と現在時刻 を表示                             
set-option -g status-right "#[fg=colour255,bg=colour241] #h | #P | [%Y-%m-%d %H:%M]"                                                                  # ステータスバーのフォーマットを指定する。                                 
set-window-option -g window-status-format " #I: #W "                       
# カレントウィンドウの window-status のフォーマットを指定する              
set-window-option -g window-status-current-format "#[fg=colour255,bg=colour27,bold] #I: #W #[default]"                                                # センタライズ                       
set-option -g status-justify centre  
# ステータスバーの色を設定する       
set -g status-fg white               
set -g status-bg black               
# ヴィジュアルノーティフィケーションを有効にする                           
setw -g monitor-activity on          
set -g visual-activity on            

# コマンドラインの色を設定する       
set -g message-fg white              
set -g message-bg black              
set -g message-attr bright           

# ウィンドウのインデックスを1から始める                                    
set -g base-index 1                  
# ウィンドウリストの色を設定する     
setw -g window-status-fg cyan        
setw -g window-status-bg default     
setw -g window-status-attr dim       
# アクティブなウィンドウを目立たせる 
setw -g window-status-current-fg white                                     
setw -g window-status-current-bg red 
setw -g window-status-current-attr bright                                  

# ペインのインデックスを1から始める  
setw -g pane-base-index 1            
# ペインの縦分割を "|" に割り当てて、かつ、分割サイズを均等にする          
bind | split-window -h \; select-layout even-horizontal                    
# ペインの横分割を "-" に割り当てて、かつ、分割サイズを均等にする          
bind - split-window -v \; select-layout even-vertical                      
# ペインの移動を vim のキーバインドに変更する                              
bind h select-pane -L                
bind j select-pane -D                
bind k select-pane -U                
bind l select-pane -R                
# ペインをリサイズを vim のキーバインドに変更する                          
bind -r H resize-pane -L 5           
bind -r J resize-pane -D 5           
bind -r K resize-pane -U 5           
bind -r L resize-pane -R 5           
# ペインボーダーの色を設定する       
set -g pane-border-fg green          
set -g pane-border-bg black          
# アクティブなペインを目立たせる     
set -g pane-active-border-fg white   
set -g pane-active-border-bg yellow  

# コピーモードを vim のキーバインドに変更する                              
setw -g mode-keys vi                 
bind-key -T copy-mode-vi v send-keys -X begin-selection                    
bind-key -T copy-mode-vi y send-keys copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"                                                         unbind -T copy-mode-vi Enter         
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
```


# 仕様・制限事項

本プロジェクトの全体的な仕様、および、制限事項は以下の通り。

- 本プロジェクトは CentOS で開発され CentOS 上での使用を想定しているため、基本的に CentOS 以外での使用は考慮していない
- Git は既に環境にインストールされている状態とする
- シェルは bash を対象とする
- tmux 自体のインストールは行わない
- 確認に使用した tmux のバージョンは 2.5 である
