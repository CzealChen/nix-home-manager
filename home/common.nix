{ config, pkgs, inputs, dotfiles, ... }:
{
  home.packages = with pkgs; [
    # --- Shells & Prompt (终端外壳与提示符) ---
    zsh
    fish
    nushell
    starship
    direnv
    zsh-powerlevel10k
    zsh-completions
    zsh-forgit

    libiconv

    
    # --- Modern CLI Replacements (现代 Rust 命令行替代工具) ---
    eza          # ls 替代
    bat          # cat 替代
    fd           # find 替代
    ripgrep      # grep 替代
    sd           # sed 替代
    procs        # ps 替代
    choose       # cut/awk 替代
    zoxide       # cd 替代
    delta        # diff 翻页器
    difftastic   # 结构化 diff
    tlrc         # tldr 客户端
    ouch         # 压缩/解压工具

    # --- Terminal Multiplexers & Session (终端复用与会话) ---
    tmux
    screen
    zellij
    dtach
    mosh

    # --- Editors (编辑器) ---
    neovim
    #helix
    # emacs

    # --- File & Disk Utilities (文件与磁盘管理) ---
    broot        # 树状文件管理器
    tree         # 传统树状查看
    fzf          # 模糊查找
    skim         # Rust 版 fzf
    dua          # 磁盘占用分析 (Rust)
    dust         # 磁盘占用分析 (Rust)
    rsync        # 文件同步
    coreutils    # 基础工具集
    # uutils-coreutils

    # --- System Monitoring & Information (系统监控与信息) ---
    htop         # 传统监控
    btop         # 现代监控 (C++)
    bottom       # 现代监控 (Rust)
    fastfetch    # 系统信息展示
    tokei        # 代码行数统计

    # --- Network & Download (网络工具与下载) ---
    curl
    wget
    xh           # HTTP 客户端 (类似 HTTPie)
    aria2        # 下载工具
    mihomo       # 代理工具 (Clash)
    proxychains-ng
    gping        # 图形化 ping
    rustscan     # 端口扫描
    bandwhich    # 流量监控

    # --- Data Processing (数据处理) ---
    jq           # JSON 处理 (C)
    jaq          # JSON 处理 (Rust)
    qsv          # CSV 处理

    # --- Development & Languages (开发工具与语言) ---
    git
    just         # 任务运行器 (类似 make)
    rustup       # Rust 工具链
    clang        # C 编译器
    openjdk      # Java 运行环境
    #zig         # Zig 编译器

    # --- Hardware & Simulation (硬件仿真与排版) ---
    qemu         # 虚拟机/仿真
    verilator    # Verilog 仿真
    gtkwave      # 波形查看

    # --- Typesetting (排版) ---
    typst        # 现代 LaTeX 替代
  ];

  programs.direnv = {
    enable = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
      
    # 开启自动补全
    enableCompletion = true;
      
    autosuggestion.enable = true;

    plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          name = "forgit";
          src = pkgs.zsh-forgit;
          file = "share/zsh-forgit/forgit.plugin.zsh";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [ 
        "git" 
        "sudo"
        ];
      };
      syntaxHighlighting.enable = true;
      syntaxHighlighting.highlighters = [
        "main" "brackets" "pattern" "cursor" "regexp" "root" "line"
      ];
      initContent = ''
        if [[ -r "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{USER}.zsh" ]]; then
          source "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{USER}.zsh"
        fi
        # 加载你放在 dotfiles 里的 p10k 配置文件
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        
        ${builtins.readFile ./dotfiles/.zshrc}
      '';
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "czealchen";
      email = "czealchen@gmail.com";
    };
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
    };
     extraConfig = {
      
      init.defaultBranch = "main";

      
      core.editor = "code --wait";
      color.ui = true;

      
      # 推送设置
      push.autoSetupRemote = true;
    };
  };

  # home.sessionVariables = {
  #   RUSTUP_HOME = "$HOME/.rustup";
  #   CARGO_HOME = "$HOME/.cargo";
  # };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
  home.file.".p10k.zsh".source = ./dotfiles/.p10k.zsh;


}