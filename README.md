# nvimconfig

该分支使用vim.pack管理插件

该分支不会添加过多的美化插件,以便于在低性能电脑上保持高效.

## folders

```text
.
├── after/
│   └── ftplugin/   # 用于覆盖默认 ftplugin 配置
├── lsp/            # 各语言服务端的独立配置
├── lua/
│   ├── lsp/        # Neovim LSP 相关设置
│   └── plugins/    # 各功能插件配置
└── plugin/         # 启动时自动加载的临时测试代码
```

## Plugins

| 名称            | 注释                                |
| --------------- | ----------------------------------- |
| hop             | 快捷跳转文档中任意位置              |
| nvim-autopairs  | 自动添加成对符号                    |
| nvim-lspconfig  | nvim lsp配置器                      |
| nvim-surround   | 成对符号的添加修改和删除(例如{},"") |
| nvim-treesitter | 语法树解析器的安装,更新和功能       |

## keymap
