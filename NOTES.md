# Debian
https://aruljohn.com/blog/install-python-debian/

```
# If these packages aren't installed, they will be needed.
$ sudo apt update
$ sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev

# Down load the version you want to install.
$ wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz
$ tar -xzvf Python-3.12.2.tgz
$ cd Python-3.12.2/

# Configure and use altinstall so you don't overwrite the symlinks to the existing installed version
$ ./configure --enable-optimizations
$ sudo make altinstall
```

# Ubuntu
https://askubuntu.com/questions/1398568/installing-python-who-is-deadsnakes-and-why-should-i-trust-them


# Optimizations 
https://luis-sena.medium.com/creating-the-perfect-python-dockerfile-51bdec41f1c8


# Best Practices
https://testdriven.io/blog/docker-best-practices/
