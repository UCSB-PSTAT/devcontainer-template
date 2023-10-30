# UCSB PSTAT Department Development Container Template
test
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/UCSB-PSTAT/devcontainer-template/HEAD?urlpath=terminals%2F1)

This template repository creates a starter [development container](https://computing.pstat.ucsb.edu/docs/devcontainer.html) setup suitable for use in the department research computing server.

## Generating Starter Code

To create your setup, follow these steps:

1. [Start a terminal session on Binder](https://mybinder.org/v2/gh/UCSB-PSTAT/devcontainer-template/HEAD?urlpath=terminals%2F1).
1. Enter the following command to generate your starter code to directory named `starter-code`: 
    ```bash
    copier copy gh:UCSB-PSTAT/devcontainer-template starter-code
    ```  
    The output would look similar to the following:  
    ```
    jovyan@jupyter-ucsb-2dpstat-2ddevcontainer-2dtemplate-2dfpo1c8gv:~$ copier copy gh:UCSB-PSTAT/devcontainer-template starter-code
    🎤 What is your project names?
    qwer
    🎤 What language(s) will you use in this project?
    R and Python
    🎤 Do you want to install Visual Studio Code extensions for Jupyter notebooks, R and Python?
    Yes
    🎤 Install Jupyter Lab? Jupyter Lab is optional if using VS Code and Python extensions for development.
    No
    🎤 Install Rstudio? Rstudio is optional if using VS Code and R extensions for development.
    No
    🎤 Install Quarto? Quarto is optional publishing system compatible with R and Python.
    No
    🎤 Do you want to include example files?
    Yes

    Copying from template version 1.0.0
        create  .
        create  example.Rmd
        create  .devcontainer
        create  .devcontainer/Dockerfile
        create  .devcontainer/devcontainer.json
    ```

1. View generated files:
    ```bash
    tree -a starter-code
    ```  
    The output would look similar to the follwing:  
    ```
    jovyan@jupyter-ucsb-2dpstat-2ddevcontainer-2dtemplate-2dfpo1c8gv:~$ tree -a starter-code/
    starter-code/
    ├── .devcontainer
    │   ├── devcontainer.json
    │   └── Dockerfile
    └── example.Rmd

    1 directory, 3 files
    ```
1. Use generated files:  
    - [Upload `starter-code` to a GitHub repository](#upload-to-github-repository) to start a new repository for your project.
    - [Create and download a zip file](#download) to manually add `.devcontainer` directory and its contents to an existing project.

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

