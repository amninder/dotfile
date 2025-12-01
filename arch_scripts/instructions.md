# Add yaourt #

Add the following to the end of `/etc/pacman.conf`

```
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
```
and update the pacman base. Run

```
sudo pacman -Suy
```

Now install `yaourt` by `sudo pacman -S yaourt`

# packet\_write\_wait: Connection to 18.205.93.1 port 22: Broken pipe

Run

`sudo pacman -U https://archive.archlinux.org/packages/o/openssh/openssh-7.7p1-2-x86_64.pkg.tar.xz`

# SDDM

Run

`copy /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf`
