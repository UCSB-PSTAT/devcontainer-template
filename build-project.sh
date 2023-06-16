#!/bin/bash

valid_directory=false
while [ "$valid_directory" = false ]; do
    read -p "Enter a project name: " directory_name
    if [[ "$directory_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        valid_directory=true
    else
        echo "Invalid directory name. Please try again."
    fi
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2/3) Select project language(s):"
    select option in "Python" "R" "Both"; do
        case $option in
            Python ) 
                python=true;
                r=false;
                valid_selection=true;
                break;;
            R ) 
                python=false;
                r=true;
                valid_selection=true;
                break;;
            Both ) 
                python=true
                r=true;
                valid_selection=true;
                break;;
        esac
    done
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2) Do you want to install Visual Studio Code extensions for Jupyter notebooks?"
    select option in "Yes" "No"; do
        case $option in
            Yes ) extension=true; valid_selection=true; break;;
            No ) extension=false; valid_selection=true; break;;
        esac
    done
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2) Install Jupyter Lab? Jupyter Lab is optional if using VS Code and Python extensions for development."
    select option in "Yes" "No"; do
        case $option in
            Yes ) jupyterlab=true; valid_selection=true; break;;
            No ) jupyterlab=false; valid_selection=true; break;;
        esac
    done
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2) Install RStudio? RStudio is optional if using VS Code and R extensions for development."
    select option in "Yes" "No"; do
        case $option in
            Yes ) rstudio=true; valid_selection=true; break;;
            No ) rstudio=false; valid_selection=true; break;;
        esac
    done
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2) Install Quarto? Quarto is an optional publishing system compatible with R and Python."
    select option in "Yes" "No"; do
        case $option in
            Yes ) quarto=true; valid_selection=true; break;;
            No ) quarto=false; valid_selection=true; break;;
        esac
    done
done

valid_selection=false
while [ "$valid_selection" = false ]; do
    echo -e "\n(Select 1/2) Do you want to include example files?"
    select option in "Yes" "No"; do
        case $option in
            Yes ) example=true; valid_selection=true; break;;
            No ) example=false; valid_selection=true; break;;
        esac
    done
done

########################################
##########  BEGIN GENERATING  ##########
########################################

if [ -d "$directory_name" ]; then 
    echo "    '$directory_name' already exists, skipping..."
else
    mkdir "$directory_name"
    echo "    create $directory_name"
fi

cd $directory_name

if [ "$example" -a "$python" = true -a "$quarto" = true ]; then
touch ./example-python.qmd
echo "    create $directory_name/example-python.qmd"
echo $'---
title: "Example Quarto Document using R"
format: pdf
date: "2023-02-17"
---

## Quarto

Quarto enables you to weave together content and executable code into a finished document. To learn more about Quarto see <https://quarto.org>.

## Running Code

When you click the **Render** button a document will be generated that includes both content and the output of embedded code. You can embed code like this:

```{python}
1 + 1
```

You can add options to executable code like this

```{python}
#| echo: false
2 * 2
```

The `echo: false` option disables the printing of code (only output is displayed).' \
> "./example-python.qmd"
fi

if [ "$example" -a "$r" = true ]; then
touch ./example.Rmd
echo "    create $directory_name/example.Rmd"
echo $'---
title: "Example R Markdown Document"
output: pdf_document
date: "2023-02-17"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.' \
> "./example.Rmd"
fi

if [ "$example" -a "$r" = true -a "$quarto" = true ]; then
touch ./example-R.qmd
echo "    create $directory_name/example-R.qmd"
echo $'---
title: "Example Quarto Document using R"
format: pdf
date: "2023-02-17"
---

## Quarto

Quarto enables you to weave together content and executable code into a finished document. To learn more about Quarto see <https://quarto.org>.

## Running Code

When you click the **Render** button a document will be generated that includes both content and the output of embedded code. You can embed code like this:

```{r}
1 + 1
```

You can add options to executable code like this

```{r}
#| echo: false
2 * 2
```

The `echo: false` option disables the printing of code (only output is displayed).' \
> "./example-R.qmd"
fi

if [ ! -d ".devcontainer" ]; then
    mkdir .devcontainer
    echo "    create $directory_name/.devcontainer/"
fi
cd ./.devcontainer

########################################
########## VS Code Extensions ##########
########## devcontainer.json  ##########
########################################

touch devcontainer.json
echo "    create $directory_name/.devcontainer/devcontainer.json"

echo $'{
    "name": "{{ project_name }}",
    "build": {
        "dockerfile": "Dockerfile"
    },

    "workspaceMount": "source=${localWorkspaceFolder},target=/home/jovyan/work,type=bind",
    "workspaceFolder": "/home/jovyan/work",

    "forwardPorts": [8888],
    "overrideCommand": true,
    "postStartCommand": "nohup bash -c \'jupyter {{ \'lab\' if use_jupyterlab else \'server\' }} --allow-root --ip 0.0.0.0 --ServerApp.allow_origin=\\"*\\" &\'",

    "remoteUser": "root",
    "runArgs": [
        "--user=root",
        "--env=GRANT_SUDO=yes",
        "--memory=1.8g",
        "--cpu-shares=300"
    ],

    "customizations": {

        "vscode": {
            "settings": {' \
> "devcontainer.json"
if [ "$extension" = true ]; then
    if [ "$python" = true ]; then
        echo $'
                "python.defaultInterpreterPath": "/opt/conda/bin/python",' \
        >> "./devcontainer.json"
    fi
    if [ "$r" = true ]; then
        echo $'
                "r.rterm.linux": "/opt/conda/bin/radian",
                "r.bracketedPaste": true,
                "r.plot.useHttpgd": true' \
        >> "./devcontainer.json"
    fi
fi

echo $'
            },
            "extensions": [' \
>> "./devcontainer.json"

if [ "$extension" = true ]; then
    if [ "$python" = true ]; then
        echo $'                "ms-python.python",
                "ms-toolsai.jupyter",
                "ms-toolsai.jupyter-keymap",' \
        >> "./devcontainer.json"
    fi
    if [ "$quarto" = true ]; then
        echo $'
                "quarto.quarto",' \
        >> "./devcontainer.json"
    fi
    if [ "$r" = true ]; then
        echo $'
                "reditorsupport.r",
                "RDebugger.r-debugger",' \
        >> "./devcontainer.json"
    fi
fi

echo $'
                "analytic-signal.preview-pdf"
            ]
        }
    }
}
' >> "./devcontainer.json"

###########################################
########## Development Container ##########
##########       Dockerfile      ##########
###########################################

touch "Dockerfile"
echo "    create $directory_name/.devcontainer/Dockerfile"

if [ "$python" = true -a "$r" = true ]; then
    echo "FROM docker.io/jupyter/datascience-notebook:x86_64-2023-03-06" > "./Dockerfile";
elif [ "$python" = true ]; then
    echo "FROM docker.io/jupyter/scipy-notebook:x86_64-2023-03-06" > "./Dockerfile";
elif [ "$r" = true ]; then
    echo "FROM docker.io/jupyter/r-notebook:x86_64-2023-03-06" > "./Dockerfile";
fi

echo "
USER root

### System dependencies
RUN apt-get update && \\
    apt-get install -y --no-install-recommends \\
        lmodern file curl tmux && \\
    apt-get clean -y && \\
    rm -rf /var/lib/apt/lists/* /tmp/library-scripts" \
>> "./Dockerfile"

if [ "$quarto" = true ]; then
echo $'
### Quarto
# versions: https://quarto.org/docs/download/_download.json
# neat setup: https://github.com/jeremiahpslewis/reproducibility-with-quarto
RUN curl --silent -L --fail \
        https://github.com/quarto-dev/quarto-cli/releases/download/v1.2.269/quarto-1.2.269-linux-amd64.deb > /tmp/quarto.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/quarto.deb && \
    rm -rf /tmp/quarto.deb /var/lib/apt/lists/* /tmp/library-scripts' \
>> "./Dockerfile"
fi

echo $'
RUN apt update -qq && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:nrbrtx/libssl1 && \
    apt update -qq && \
    apt upgrade -y && \
    apt install -y \
        libssl-dev \
        libcairo2-dev \
        lib32gcc-s1 \
        lib32stdc++6 \
        libc6-i386 \
        libclang-14-dev \
        libclang-common-14-dev \
        libclang-dev \
        libclang1-14 \
        libgc1 \
        libllvm14 \
        libobjc-11-dev \
        libobjc4 \
        libpq5 \
        libxcb-xkb1 \
        libxkbcommon-x11-0 \
        psmisc'\
>> "./Dockerfile"

if [ "$rstudio" = true ]; then
echo $'
## Install rstudio from source package
ENV R_STUDIO_VERSION 2022.12.0-353

RUN wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-${R_STUDIO_VERSION}-amd64.deb && \
    apt-get install -yq --no-install-recommends ./rstudio*.deb && \
    rm -f ./rstudio*.deb && \
    apt-get clean && \
    chmod 777 /var/run/rstudio-server && \
    chmod +t /var/run/rstudio-server' \
>> "./Dockerfile"
fi

if [ "$r" = true ]; then
echo $'
## R compiler settings
RUN R -e "dotR <- file.path(Sys.getenv('HOME'), '.R'); if(!file.exists(dotR)){ dir.create(dotR) }; Makevars <- file.path(dotR, 'Makevars'); if (!file.exists(Makevars)){  file.create(Makevars) }; cat('\nCXX14FLAGS=-O3 -fPIC -Wno-unused-variable -Wno-unused-function', 'CXX14 = g++ -std=c++1y -fPIC', 'CXX = g++', 'CXX11 = g++', file = Makevars, sep = '\n', append = TRUE)"' \
>> "./Dockerfile"
fi

echo $'
USER ${NB_USER}' \
>> "./Dockerfile"

if [ "$rstudio" = true ]; then
echo $'
## Create Rstudio launch button in Jupyter lab
RUN mamba install -y -c conda-forge --freeze-installed jupyter-server-proxy jupyter-rsession-proxy && \
    mamba clean --all' \
>> "./Dockerfile"
fi

echo $'
RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix 

### Prints Jupyter server token when terminal is opened
RUN echo "echo \"Jupyter server token: \$(jupyter server list 2>&1 | grep -oP \'(?<=token=)[[:alnum:]]*\')\"" > ${HOME}/.get-jupyter-url.sh && \
    echo "sh \${HOME}/.get-jupyter-url.sh" >> ${HOME}/.bashrc' \
>> "./Dockerfile"

if [ "$r" = true -a "$extension" = true ]; then 
echo $'
### R development
RUN pip install radian && \
    R -q -e \'install.packages(c("markdown", "languageserver", "httpgd"), repos="cloud.r-project.org")\' &&\
    R -q -e \'remotes::install_github("ManuelHentschel/vscDebugger")\'' \
>> "./Dockerfile"
fi
