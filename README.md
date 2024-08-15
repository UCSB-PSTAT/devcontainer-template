# Development Container Configuration Generator Template

This template repository creates a starter [development container](https://computing.pstat.ucsb.edu/docs/devcontainer.html) setup suitable for use in the department research computing server.

## Generating Starter Code

To create your setup, follow these steps:

1. Enter the following command to generate your project starter code: 
    ```bash
    copier copy gh:UCSB-PSTAT/devcontainer-template <name-of-project-directory>
    ```  
    where `<name-of-project-directory>` is the name of the directory you wish to save your project files to. The output would look similar to the following for a project called `my-awesome-project`:  
    ```
    $> copier copy gh:UCSB-PSTAT/devcontainer-template my-awesome-project-folder
    🎤 What is the name of your project? (Must be unique and use lowercase, dashes -, underscores _ ONLY)
    my-awesome-project
    🎤 What language(s) will you use in this project?
    R and Python
    🎤 Do you want to install Visual Studio Code extensions for Jupyter notebooks using R and Python?
    Yes
    🎤 Install RStudio Server? This is optional if using VS Code and R extensions for development.
    No
    🎤 Install Quarto? Quarto is optional publishing system compatible with R and Python.
    No
    🎤 Do you want to include example files?
    Yes

    Copying from template version 1.4.2
        create  .
        create  README.md
        create  example.Rmd
        create  .devcontainer
        create  .devcontainer/Dockerfile
        create  .devcontainer/devcontainer.json
    ```

1. View generated files:
    ```bash
    tree -a <name-of-project>
    ```  
    The output would look similar to the follwing:  
    ```
    $> tree -a my-awesome-project-folder
    starter-code/
    ├── .devcontainer
    │   ├── devcontainer.json
    │   └── Dockerfile
    ├── example.Rmd
    └── README.md

    1 directory, 4 files
    ```
1. Use generated files:  
    - [Upload `my-awesome-project-folder` to a GitHub repository](#upload-to-github-repository) to start a new repository for your project.
    - [Create and download a zip file](#download) to manually add `.devcontainer` directory and its contents to an existing project.

## Upload to GitHub Repository

1. Authenticate with your GitHub account:
    ```bash
    gh auth login
    ```
1. Convert generated files to a repository:
    ```bash
    cd /home/jovyan/work/
    git init
    git add *
    git commit -m "first commit"
    git branch -M main
    ```
1. Upload local repository to a new GitHub repository.  
    **Be sure to choose, "Push an existing local repository to GitHub"**:
    ```bash
    cd /home/jovyan/work/
    gh repo create 
    ```

## Download

1. Create a zip file of `starter-code` contents:
    ```bash
    zip -r my-awesome-project.zip my-awesome-project-folder
    ```
1. Click on Jupyter logo to open Jupyter Lab.
1. Download the zipfile, `my-awesome-project.zip`
1. Once downloaded, unzip the contents and add the `.devcontainer` folder to the root of your project folder.

