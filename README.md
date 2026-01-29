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

## FAQ

### Why does the login expire after about 2 hours?
This tool performs a one-time login action and then exits. It does not run in the background to send "heartbeat" packets to the server. Most campus network systems have session timeouts (idle or hard limits). Since this tool does not actively maintain the session (keep-alive), the server may disconnect you after a certain period of inactivity or session duration. You will need to run the login command again.

### Where are credentials stored and is it safe?
The credentials (username and password) configured via `config` command are stored in your user home directory in a file named `.bitsrun` (e.g., `~/.bitsrun` on Linux or `C:\Users\YourName\.bitsrun` on Windows).

**Safety Warning**: The credentials are stored using Base64 encoding, which is **NOT encryption**. It effectively obfuscates the text but anyone with access to the file can easily decode it to retrieve your username and password. Do not use this on a shared computer without proper file permissions.

## Thanks to

[https://github.com/vouv/srun](https://github.com/vouv/srun)

[Nuitka](https://nuitka.net/)

