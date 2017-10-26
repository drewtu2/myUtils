# myUtils
A repository for useful tools and templates. 

## Contents
1. scripts: useful scripts to use including a setup script for dot files
2. dot-files: configuration files for main applications. `./scripts/setConfigs` 
will automatically create soft-links in the home directory to the configs in this
folder IF another version of the config does not already exist on the system. 
3. cpp\_project: basic gnu-make based cpp project structure ready to be used.

## Setup 
1. Clone repo
2. From home directory of repo, call `./scripts/setConfigs.sh`

## TODO
- Add CMake cpp project structure 
- Add Google Test to both cpp project templates
- Run system check on what programs are installed (that are commonly used)





