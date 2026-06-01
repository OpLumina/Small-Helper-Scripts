# Custom Shell Utilities

A lightweight collection of Bash functions and aliases to streamline directory analysis, file backups, PDF splitting, and Tor-routed web requests.

---

## Features & Usage

### 1. `cntsz` (Count & Size)
Analyzes a directory or file to calculate total size, item count, and total lines of text.
* **Usage:** `cntsz [-d] [-e exclude_pattern] [target]`
* **Flags:**
    * `-d`: Displays the directory tree structure (requires `tree`).
    * `-e`: Excludes specific patterns/folders (e.g., `-e node_modules -e .git`).

### 2. `bak` (Quick Backup)
Creates a quick `.bak` copy of a specified file in the target destination.
* **Usage:** `bak <file> [destination_directory]`
* **Example:** `bak config.toml ~/.backup` (Defaults to the current directory if destination is omitted).

### 3. `pdfsplit` (PDF Splitter)
Splits one or more PDF files into chunks based on a maximum page count per file.
* **Dependencies:** `qpdf`
* **Usage:** `pdfsplit <pages_per_file> <input_file(s)> <output_directory_or_path>`
* **Example:** `pdfsplit 5 document.pdf ./output/`

### 4. `bcurl` (Tor Browser Curl)
An alias that routes `curl` through `proxychains4` using standard Tor traffic, bundled with standard browser headers for consistent web rendering.
* **Usage:** `bcurl https://example.com`

---

## Installation

Copy these functions into your `~/.bashrc` or `~/.zshrc` file, install dependencies (qpdf), then reload your shell:

```bash
source ~/.bashrc
```
