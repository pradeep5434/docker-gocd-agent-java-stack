# packages

`packages` contains folders each of which represents a single package that needs to be installed. The reason for doing this is because the `run.sh` on this directory acts as a single point of all installation and we can just add more packages that we need to install as part of this docker image. 

## Creating a new Package
1. Create a unique folder name for each package that you wish to install. 
2. Create a file called `install.sh` inside that folder. 
3. Add commands to install the specific package as desired. 

All the packages will be installed in the alphabetical order of the package name. If you've certain dependencies between the packages, consider adding numbers against them so they can be run in a sequence.
