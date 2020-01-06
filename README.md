# Profiles

Sync profiles across all my workstations

## Cygwin

### Installation suggestions

* Editors
	* Nano
	* Emacs
	* Vim
* Python
* Other
	* Email
	* dos2unix
	* curl
	* wget


### Setup

Load Profiles from Github into {$HOME}\Profiles

Modify home directory:
nano `/etc/nsswitch.conf`

```db_home:  /home/%U/Profiles```

Run dos2unix on files if necessary : https://stackoverflow.com/questions/11616835/r-command-not-found-bashrc-bash-profile