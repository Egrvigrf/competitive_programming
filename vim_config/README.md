## 安装
For windows: %LOCALAPPDATA%/nvim  
For Linux: "$HOME/.config/nvim"  

## 可能出现的问题
- lualine和telescope的符号显示乱码，需要设置支持图形字符的终端字体（比如Nerd fonts） 
[Nerd_font](https://www.nerdfonts.com/)  
  

- 解决windows下lsp clangd报错检测不到c++头文件的问题  
在%LOCALAPPDATA%/clangd目录下建立新建一个config.yaml文件  
配置如下  [参考Github讨论](https://github.com/clangd/clangd/issues/537#issuecomment-1479544442)  
```  
CompileFlags:  
  Add:
    - --target=x86_64-w64-windows-gnu
```  
- 使用clang-format 格式化代码  
用mason-tool由于网络原因没法安装llvm，手动安装llvm（含有clang-format）  
把/bin添加到环境变量后  
[llvm](https://github.com/llvm/llvm-project/releases/)  
然后在conform自动补全插件里设置  

安装失败可以尝试直接用:MasonInstall clang-format --force  
:MasonInstall clangd --force  

- windows cmd 没有添加到环境变量，手动添加C:\Windows\System32即可  
- linux clangd-format 如果用:Masoninstall 安装失败，可以手动安装,可能是没有国内源  

