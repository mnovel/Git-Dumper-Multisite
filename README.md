# Git Dumper Script

## Overview

This Bash script utilizes the `git-dumper` tool to download multiple Git repositories based on a list of URLs. It extracts repository names from the URLs and organizes them in the current working directory.

## Prerequisites

- **git-dumper**: Ensure that the `git-dumper` tool is installed. You can install it by following the instructions in its repository: [git-dumper](https://github.com/arthaud/git-dumper)

## Installation

1. Make the script executable:
    ```bash
    chmod +x git-dumper-multi.sh
    ```

## Usage

Run the script with a list of Git repository URLs. The script will download each repository and organize them in the current working directory.

```bash
./git-dumper-multi.sh < input_list.txt
```

### Input List Format

The input list should contain Git repository URLs. Each URL will be processed, and the corresponding repositories will be downloaded.

### Example

```bash
echo "https://github.com/example/repo1.git" > input_list.txt
echo "https://github.com/example/repo2.git" >> input_list.txt
./git-dumper-multi.sh < input_list.txt
```

## Author

[Muhammad Novel]
