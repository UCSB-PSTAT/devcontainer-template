# UCSB PSTAT Department Development Container Template

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/UCSB-PSTAT/devcontainer-template/HEAD?urlpath=terminals%2F1)

This template repository creates a starter [development container](https://computing.pstat.ucsb.edu/docs/devcontainer.html) setup suitable for use in the department research computing server.

## Generating Starter Code

To create your setup, follow these steps:

1. [Start a terminal session on Binder](https://mybinder.org/v2/gh/UCSB-PSTAT/devcontainer-template/HEAD?urlpath=terminals%2F1).
1. Enter the following command to generate your starter code to directory named `starter-code`: 
    ```bash
    copier copy gh:UCSB-PSTAT/devcontainer-template starter-code
    ```
1. View generated files:
    ```bash
    tree -a starter-code
    ```
1. Use generated files:  
    - (Recommended) [Upload `starter-code` to a GitHub repository](#upload-to-github-repository) 
    - [Create and download a zip file](#download)

## Upload to GitHub Repository

1. Authenticate with your GitHub account:
    ```bash
    /home/jovyan/gh auth login
    ```
1. Convert generated files to a repository:
    ```bash
    cd /home/jovyan/starter-code
    git init
    git add *
    git commit -m "first commit"
    git branch -M main
    ```
1. Upload local repository to a new GitHub repository.  
    **Be sure to choose, "Push an existing local repository to GitHub"**:
    ```bash
    cd /home/jovyan/starter-code
    /home/jovyan/gh repo create 
    ```

## Download

1. Create a zip file of `starter-code` contents:
    ```bash
    zip -r starter-code.zip starter-code
    ```
1. Click on Jupyter logo to open Jupyter Lab.
1. Download the zipfile, `starter-code.zip`
1. Once downloaded, unzip the contents and add the `.devcontainer` folder to the root of your project folder.

