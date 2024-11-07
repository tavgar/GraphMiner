# GraphMiner

![Bash](https://img.shields.io/badge/Scripting-Bash-blue.svg)
![GitHub Issues](https://img.shields.io/github/issues/tavgar/GraphMiner.svg)
![GitHub Stars](https://img.shields.io/github/stars/tavgar/GraphMiner.svg?style=social)

**GraphMiner** is a powerful Bash script designed to extract GraphQL queries and mutations from JavaScript (JS) files associated with a specified domain. Leveraging the capabilities of [`waymore`](https://github.com/Xnl-h4ck3r/waymore) and [`httpx`](https://github.com/projectdiscovery/httpx), GraphMiner automates the process of discovering JS URLs, retrieving their responses, and parsing them for valuable GraphQL operations.

---

## 📋 Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Output](#output)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

---

## 🚀 Features

- **Automated JS URL Retrieval**: Uses `waymore` to gather all JavaScript URLs related to the target domain.
- **GraphQL Extraction**: Utilizes `httpx` to probe JS responses and extract GraphQL queries and mutations.
- **Organized Output**: Stores results in structured directories for easy access and analysis.
- **Dependency Checks**: Verifies the presence of required tools before execution, providing clear installation instructions if any are missing.
- **User-Friendly**: Provides clear prompts and summaries to guide users through the extraction process.

---

## 🛠 Prerequisites

Before using **GraphMiner**, ensure that the following tools are installed and accessible in your system's `PATH`:

1. **Bash**: Most Unix-like systems come with Bash pre-installed.
2. **waymore**: Tool to retrieve URLs and responses from the Wayback Machine.
3. **httpx**: Fast and multi-purpose HTTP toolkit.
4. **grep**: Text search utility.
5. **sed**: Stream editor for filtering and transforming text.
6. **bc**: Basic calculator for floating-point arithmetic.

### Installing Dependencies

- **Debian/Ubuntu:**

  ```bash
  sudo apt-get update
  sudo apt-get install bc grep sed
  ```

- **macOS (using Homebrew):**

  ```bash
  brew install bc grep gnu-sed
  ```

  *Note: On macOS, GNU `sed` might be installed as `gsed`. You may need to adjust the script accordingly.*

- **Install `waymore`:**

  Follow the installation instructions from the [waymore GitHub repository](https://github.com/Xnl-h4ck3r/waymore).

- **Install `httpx`:**

  Follow the installation instructions from the [httpx GitHub repository](https://github.com/projectdiscovery/httpx).

---

## 🛠 Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/tavgar/GraphMiner.git
   ```

2. **Navigate to the Directory:**

   ```bash
   cd GraphMiner
   ```

3. **Make the Script Executable:**

   ```bash
   chmod +x graphminer.sh
   ```

---

## 📖 Usage

Execute the **GraphMiner** script using the terminal:

```bash
./graphminer.sh
```

### Script Workflow

1. **Tool Verification**: The script first checks if all required tools (`waymore`, `httpx`, `grep`, `sed`, `bc`) are installed. If any are missing, it provides installation instructions and exits.

2. **User Prompt**: Prompts the user to enter the target domain.

3. **JS URL Retrieval**: Uses `waymore` to fetch all JS URLs and their responses associated with the domain.

4. **GraphQL Extraction**: Employs `httpx` to probe the retrieved JS URLs, extracting GraphQL mutations and queries.

5. **Result Organization**: Saves the extracted data into structured directories for easy access.

6. **Summary Display**: Provides a summary of the extraction process, including the number of JS URLs processed and the counts of extracted mutations and queries.

---

## 🗂 Output

Upon successful execution, **GraphMiner** creates the following directories in the current working directory:

- **`graphminer_waymore_results`**
  - `urls.txt`: Contains all extracted URLs from `waymore`.
  - `js_urls.txt`: Contains filtered JS URLs.

- **`graphminer_js_responses`**
  - Stores the downloaded JS response files from `waymore`.

- **`graphminer_httpx_results`**
  - `extracted_matches.txt`: Raw extracted mutations and queries.
  - `mutations.txt`: List of extracted GraphQL mutations.
  - `queries.txt`: List of extracted GraphQL queries.

---

## 💡 Example

```bash
$ ./graphminer.sh
Checking for required tools...
All required tools are installed.
Enter the domain: example.com
[*] Running waymore to retrieve JS URLs and responses...
[+] waymore completed.
[*] Extracting JS URLs...
[+] Found 15 JS URLs.
[*] Running httpx to extract mutations and queries...
[+] httpx extraction completed.
[*] Processing extracted matches...
[+] Mutations and queries extracted.
----------------------------------------
Summary:
Total JS URLs processed: 15
Total Mutations Extracted: 5
Total Queries Extracted: 8
----------------------------------------
[*] Extraction completed successfully.
Results are saved in the following directories:
 - JS Responses: ./graphminer_js_responses
 - Waymore URLs: ./graphminer_waymore_results
 - Httpx Results: ./graphminer_httpx_results
```

---

## 🤝 Contributing

Contributions are welcome! Whether it's improving the script, adding new features, or enhancing documentation, your input is valuable.

1. **Fork the Repository**
2. **Create a New Branch**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add feature: YourFeatureName"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeatureName
   ```

5. **Open a Pull Request**

   Describe your changes and submit the pull request for review.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## ⚠️ Disclaimer

**GraphMiner** is provided **for educational and informational purposes only**. The use of this tool to scan, extract, or manipulate data from websites without explicit permission is strictly **prohibited** and may be **illegal**. By using **GraphMiner**, you agree to comply with all applicable laws and regulations.

The authors and contributors of this project are **not responsible** for any misuse or damage resulting from the use of this tool. Always ensure you have proper authorization before performing any security assessments or data extraction activities on target domains.

Use **GraphMiner** **responsibly** and **ethically**.

---

## 📞 Contact

For any questions, suggestions, or feedback, feel free to reach out:

- **GitHub Issues:** [https://github.com/tavgar/GraphMiner/issues](https://github.com/tavgar/GraphMiner/issues)
---

## 📝 Acknowledgements

- [waymore](https://github.com/Xnl-h4ck3r/waymore) by @Xnl-h4ck3r
- [httpx](https://github.com/projectdiscovery/httpx) by ProjectDiscovery
- Inspired by the need to streamline GraphQL operation extraction from JS files.
