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

## Auto Keep-Alive Script

Since the session may expire, a script `auto_login.sh` is provided to perform login operations periodically (every 30 minutes).

### Principle
The script runs an infinite loop. In each iteration, it executes the login command and then sleeps for 30 minutes. This ensures that even if the session is disconnected by the server, it will be re-established automatically.

### Usage
1. Make the script executable:
   ```bash
   chmod +x auto_login.sh
   ```
2. Run it manually (for testing):
   ```bash
   ./auto_login.sh
   ```

## System Service (Auto-start on Boot)

To ensure the network is automatically logged in when the computer starts and keeps running in the background, you can set it up as a systemd service.

### Setup Steps

1. **Edit Configuration**: Open `srun-login.service` and modify the following fields to match your environment:
   - `User`: Change to your Linux username.
   - `WorkingDirectory`: Change to the absolute path of this project.
   - `ExecStart`: Change the path to `auto_login.sh`.
   Also edit `auto_login.sh` if your binary path is different.

2. **Make Executable**:
   ```bash
   # Replace /path/to/project with your actual project path
   chmod +x /path/to/project/auto_login.sh
   chmod +x /path/to/project/bin/srun-bit-windows-linux.bin

   # Set account ID and Password
   chmod +x /path/to/project/bin/srun-bit-windows-linux.bin config
   ```

3. **Copy Service File**:
   Copy the provided `srun-login.service` file to the systemd directory (force overwrite if exists).
   ```bash
   sudo cp -f /path/to/project/srun-login.service /etc/systemd/system/
   ```

4. **Reload Systemd**:
   ```bash
   sudo systemctl daemon-reload
   ```

5. **Enable and Start Service**:
   ```bash
   # Enable auto-start on boot
   sudo systemctl enable srun-login.service
   
   # Start the service immediately
   sudo systemctl start srun-login.service
   ```

6. **Check Status**:
   ```bash
   systemctl status srun-login.service
   ```
   If successful, you should see "active (running)".

### Stop and Remove Service

If you want to stop the auto-login service or remove it completely:

1. **Stop the service**:
   ```bash
   sudo systemctl stop srun-login.service
   ```

2. **Disable auto-start**:
   ```bash
   sudo systemctl disable srun-login.service
   ```

3. **Remove service file** (Optional, for complete uninstallation):
   ```bash
   sudo rm /etc/systemd/system/srun-login.service
   sudo systemctl daemon-reload
   ```

## Thanks to

[https://github.com/vouv/srun](https://github.com/vouv/srun)

[Nuitka](https://nuitka.net/)

