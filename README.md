# memos

个人备忘录

## 环境设置

### Windows 环境（使用 Python venv）

由于 Windows 下无法使用 Docker，可以使用 Python venv 来设置开发环境。

#### 快速开始

1. **安装 Python**
   - 确保已安装 Python 3.8 或更高版本
   - 从 https://www.python.org/ 下载安装

2. **设置虚拟环境**

   使用批处理脚本（推荐）：
   ```cmd
   setup_venv.bat
   ```

   或使用 PowerShell 脚本：
   ```powershell
   .\setup_venv.ps1
   ```

3. **激活虚拟环境**

   使用批处理脚本：
   ```cmd
   activate_venv.bat
   ```

   或使用 PowerShell 脚本：
   ```powershell
   .\activate_venv.ps1
   ```

   或手动激活：
   ```cmd
   venv\Scripts\activate.bat
   ```
   ```powershell
   .\venv\Scripts\Activate.ps1
   ```

4. **构建文档**
   ```cmd
   make.bat html
   ```

5. **启动实时预览服务器**
   ```cmd
   make.bat livehtml
   ```

#### 说明

- `setup_venv.bat` / `setup_venv.ps1`: 创建 Python 虚拟环境并安装所有依赖
- `activate_venv.bat` / `activate_venv.ps1`: 激活虚拟环境
- `make.bat`: 构建文档（会自动检测并使用 venv 中的命令）
- `.devcontainer/requirements.txt`: Python 依赖包列表

#### 注意事项

- 如果 PowerShell 执行策略限制，可能需要运行：
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```
- 虚拟环境目录 `venv\` 已添加到 `.gitignore`，不会被提交到仓库
