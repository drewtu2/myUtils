# myUtils
A repository for useful tools and templates. 

## Contents
Each top level should have its own README
1. scripts: useful scripts to use including a setup script for dot files
2. dot-files: configuration files for main applications. `./scripts/setConfigs` 
will automatically create soft-links in the home directory to the configs in this
folder IF another version of the config does not already exist on the system. 
3. cpp: cpp project templates


## Setup 
1. Clone repo
2. From home directory of repo, call `./scripts/install.sh`

## TODO
- Add CMake cpp project structure 
- Add Google Test to both cpp project templates
- Run system check on what programs are installed (that are commonly used)

## Useful links
[Colored print statments linux][1]
[Markdown cheat sheet][2]
[Docker Tutorial][3]




[1]: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
[2]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
[3]: https://docker-curriculum.com

