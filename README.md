# Profiles

Sync profiles across all my workstations


## Installs

#### Dev Tools

* Notepad++
	* Compare
	* JSTool
	
* Cygwin (see below)

* AutoHotKey

* Sourcetree

* Visual Studio
	* ReSharper
	  * Import preferred keyboard shortcuts from VisualStudio directory
	* Productivity Power Tools
		* NB: Right-click on scrollbar > Scrollbar options > Use map mode for vertical scroll (narrow)
	* [Microsoft Code Analysis](https://marketplace.visualstudio.com/items?itemName=VisualStudioPlatformTeam.MicrosoftCodeAnalysis2019) - @@@ decide if this is actually worth having
	
* VS Code

* SSMS

  * [Redgate SQL Search](https://www.red-gate.com/dynamic/products/sql-development/sql-search/download)
  * View > Registered Servers

* Typora

* Postman

* RabbitMQ

	​	
#### Miscellaneous

* [Free Cam](https://www.freescreenrecording.com/)
* Paint.NET
* [FastStone Viewer](https://www.faststone.org/)
* Slack


### Cygwin

#### Installation suggestions

* Editors
	* nano
	* emacs
	* vim
* Python
* Web
	* email
	* curl
	* wget
	* ping
* Other
	* dos2unix
	* unzip
	* grep (if not a default)
	* sed (if not a default)


#### Setup

Load Profiles from Github into C:\Dev\Profiles

Modify home directory:
`nano /etc/nsswitch.conf`

```db_home:  /cygdrive/c/Dev/Profiles```

Run dos2unix on files [if necessary](https://stackoverflow.com/questions/11616835/r-command-not-found-bashrc-bash-profile):

```
cd /cygdrive/c/Dev/Profiles/
dos2unix .bash_profile
dos2unix .bashrc
```

### Node / NPM

After installing Cygwin, follow [these instructions](https://github.com/nvm-sh/nvm?tab=readme-ov-file#intro) to install NVM, ie. run:

`curl -o- httpscurl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash`

`nvm install 21` to install node v21, `node -v` to check which version of node is in use.
