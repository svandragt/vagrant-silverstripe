# vagrant-silverstripe
A robust Trusty 64bit SilverStripe vagrant base installation using shell provisioning. For when no amount of chefs or puppets will do. ;)

Fork it as a extensible base for your projects.

# Development Only
This Vagrant set up is for development use only it is deliberately in-secure and designed to be easy to access and work on with no consideration given to the security implications of this. Do not put this environment on any public network or use it for configuring external web servers.

# Install
* fork this repository
* clone it to your developer machine
* run `vagrant up`
* if you want to use your code you are done.
* To install a fresh SS install:
```
vagrant ssh
sh /vagrant/vagrant/install-silverstripe.sh
```
  Then open http://localhost:8080 in your browser
