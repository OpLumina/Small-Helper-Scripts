# Custom Shell Utilities

A lightweight collection of Bash functions and aliases to streamline basic terminal tasks like PDF splitting, directory analysis, and file management.

---

## Features & Usage

### 1. `cntsz` (Count & Size)
Analyzes directories or files to calculate total size, item count, and total lines of text.

* **Usage:** `cntsz [-d] [-r] [-e exclude_pattern] [target1] [target2] ...`
* **Flags:**
    * `-d`: Displays the directory tree structure (requires `tree`).
    * `-r`: (Recursive) Enables deep analysis into subdirectories. Without this flag, the command performs a shallow check of the immediate targets only.
    * `-e`: (Exclude) Excludes specific patterns, files, or folders (e.g., `-e node_modules -e .git`).
* **Features:**
    * **Wildcard & Multi-Target Support:** Accepts multiple file/directory arguments or shell wildcards (e.g., `cntsz src/*`).
    * **Summary Overview:** Automatically provides a combined total summary when analyzing multiple targets.

### 2. `bak` (Quick Backup)
Creates a quick `.bak` copy of a specified file in the target destination.

* **Usage:** `bak <file> [destination_directory]`
* **Example:** `bak config.toml ~/.backup` (Defaults to the current directory if destination is omitted).
* **Output:** `~/.backup/config.toml.bak`

### 3. `pdfsplit` (PDF Splitter)
Splits one or more PDF files into chunks based on a maximum page count per file.

* **Dependencies:** `qpdf`
* **Usage:** `pdfsplit <pages_per_file> <input_file(s)> <output_directory_or_path>`
* **Example:** `pdfsplit 5 document.pdf ./output/`

### 4. `bcurl` (Tor Browser Curl)
An alias that routes `curl` through `proxychains4` using standard Tor traffic, bundled with standard browser headers for consistent web rendering.

* **Dependencies:** `proxychains4`, `tor`
* **Usage:** `bcurl https://example.com`

---

## Installation

1. Copy the utility functions into your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc`).
2. Install the required system dependencies using your package manager:
   ```bash
   # Debian/Ubuntu example
   sudo apt install qpdf tree proxychains4 tor

```

3. Reload your shell configuration to apply the changes:
```bash
source ~/.bashrc

```
