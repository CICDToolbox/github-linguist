<p align="center">
    <a href="https://github.com/WolfSoftware">
        <img src="https://raw.githubusercontent.com/WolfSoftware/branding/master/images/general/banners/64/black-and-white.png" alt="Wolf Software Logo" />
    </a>
    <br />
    <a href="https://github.com/CICDToolbox/github-linguist/actions/workflows/pipeline.yml">
        <img src="https://img.shields.io/github/workflow/status/CICDToolbox/github-linguist/pipeline/master?logo=github&logoColor=white&style=for-the-badge" alt="Github Build Status">
    </a>
    <a href="https://github.com/CICDToolbox/github-linguist/releases/latest">
        <img src="https://img.shields.io/github/v/release/CICDToolbox/github-linguist?color=blue&style=for-the-badge&logo=github&logoColor=white&label=Latest%20Release" alt="Release">
    </a>
    <a href="https://github.com/CICDToolbox/github-linguist/releases/latest">
        <img src="https://img.shields.io/github/commits-since/CICDToolbox/github-linguist/latest.svg?color=blue&style=for-the-badge&logo=github&logoColor=white" alt="Commits since release">
    </a>
    <br />
    <a href=".github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
    </a>
    <a href=".github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
    </a>
    <a href=".github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
    </a>
    <a href="https://github.com/CICDToolbox/github-linguist/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
    </a>
</p>

## Overview

A tool to run [github-linguist](https://github.com/github/linguist) against your repository in a CI/CD pipeline.

This tool has been written and tested using GitHub Actions but it should work out of the box with a lot of other CI/CD tools.

## Usage

```yml
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    - name: Set up Ruby 3.0
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.0
    - name: Run GitHun Linguist
      run: bash <(curl -s https://raw.githubusercontent.com/CICDToolbox/github-linguist/master/pipeline.sh)
```

## Example Output

This is an example of the output report generated by this tool, this is the actual output from the tool running against itself.

```
--------------------------------------------------------------------------------
           Scanning all files with github-linguist (version: 7.16.1)
--------------------------------------------------------------------------------
100.00% Shell

Shell:
pipeline.sh
--------------------------------------------------------------------------------
```

## File Identification

Github Linguist manages its own file identification.

<p align="right">
    <a href="https://github.com/TGWolf">
        <img src="https://img.shields.io/badge/Created%20by%20Wolf-black?style=for-the-badge" />
    </a>
    <br />
    <a href="https://ko-fi.com/wolfsoftware">
        <img src="https://img.shields.io/badge/Ko%20Fi-black?style=for-the-badge&logo=ko-fi&logoColor=white" />
    </a>
</p>
