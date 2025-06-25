# PowerShell Log Monitor

A simple PowerShell script that monitors `.log` files for `ERROR` and `CRITICAL` lines, writes them to a `report.txt` file, and archives logs older than 7 days.

## Features
- Scans `.log` files in `C:\Logs`
- Generates a `report.txt` with error/critical lines
- Archives logs older than 7 days into zip files

## How to Use
1. Save the `logManager.ps1` script to `C:\Logs`
2. Run it with:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "C:\Logs\logManager.ps1"
