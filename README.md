## Install

### Via pip

`python -m pip install -U srun-cli-bit`

### Via binary

Download binary file from GitHub  [release page](https://github.com/c-my/srun-cli-bit/releases/latest) .
(If you are using Linux, you may need  to run `chmod +x [binary_file]` first.)

### Via source
1. Clone this repo
2. Install dependencies using `pip install -r requirements.txt`
3. Run `python src/main.py login`

## Usage

`srun-bit config`: set account ID and Password

`srun-bit login`: sign in the network account

`srun-bit logout`: disconnect the network 

`srun-bit info`: show account information

## Note
### Latest Binary Version Compile Option
* Windows10(python3.9.15): `python -m nuitka src/main.py --onefile --standalone --mingw64`
* Ubuntu(python3.9.15): `python -m nuitka --onefile --standalone src/main.py`

**_Windows binary version NOT works on Windows7_**

## Thanks to

[https://github.com/vouv/srun](https://github.com/vouv/srun)

[Nuitka](https://nuitka.net/)

## 常见问题

### 1. 为什么登录状态会过期？

本工具只负责执行登录和注销操作，并未实现任何会话保持（Keep-Alive）或自动重新登录的功能。登录状态在约两小时后过期是由**校园网认证服务器的策略**决定的，并非本工具的设定。这是一种常见的网络管理措施，旨在提高网络安全性和资源利用率。当会话过期后，您需要手动再次执行 `login` 命令以重新连接。

### 2. 账号和密码存储在哪里？是否安全？

当您使用 `config` 命令设置账号和密码时，这些信息会以**未加密的纯文本形式**保存在您系统用户主目录下的一个名为 `.srun.json` 的隐藏文件中。

-   在 Linux 和 macOS 上，路径通常是 `~/.srun.json`。
-   在 Windows 上，路径通常是 `C:\Users\YourUsername\.srun.json`。

由于凭据是以纯文本形式存储的，任何能够访问此文件的用户或程序都可以轻易读取到您的账号和密码。**这存在一定的安全风险**，请确保您的用户主目录具有适当的访问权限控制。

