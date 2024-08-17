# Directory Scanner

A lightweight directory and file brute-forcing tool written in Ruby. This tool helps in discovering hidden directories and files on a target web application by brute-forcing with a wordlist. It supports multithreading for faster results and allows you to specify HTTP status codes to identify valid resources.

## Features

- **Multithreaded Scanning**: Accelerates the scanning process by utilizing multiple threads.
- **Customizable Wordlist**: Use your own wordlist to target specific directories and files.
- **Configurable Status Codes**: Specify which HTTP status codes to look for to identify valid resources.
- **Clear Output**: Provides a clean and organized output of found directories and files.
- **Simple to Use**: Easy command-line interface for quick setup and execution.

## Installation

1. Ensure you have Ruby installed. You can check if Ruby is installed with:
    ```bash
    ruby -v
    ```
2. Clone the repository:
    ```bash
    git clone https://github.com/VexyPT/urlfinder.git
    ```
3. Navigate to the project directory:
    ```bash
    cd urlfinder
    ```

# Usage

To run the UrlFinder, use the following command:
```bash
ruby buster.rb -u TARGET_URL -w WORDLIST_PATH -t THREADS
```

# Command-Line Options
- **`-u`**, **`--url TARGET`** (required): The target URL to scan.
- **`-w`**, **`--wordlist WORDLIST`** (required): Path to the wordlist file.
- **`-t`**, **`--threads THREADS`** (optional): Number of threads to use (default: 10)
- **`--status-codes CODES`** (optional): Comma-separated list of HTTP status codes to look for (default: 200).

# Example
```bash
ruby dirscanner.rb -u http://example.com -w wordlist.txt -t 10
```

# Output
The tool will display the found directories and files along with their HTTP status codes. It will also provide summary information such as the start time and finish time of the scan.

# Contributing
Contributions are welcome! If you have any ideas, improvements, or bug fixes, please open an issue or submit a pull request.

License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/VexyPT/urlfinder/blob/main/LICENSE) file for details.

Acknowledgments
- [Ruby](https://www.ruby-lang.org/en/) for providing the scripting language.
- The community for various wordlists and tools that inspired this project.