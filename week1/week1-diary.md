# Week 1 - Diary

### Ukko alias
```
alias irc='ssh melkki -t screen -dr'
alias ls='ls --color=auto'
alias manh='man --html=chromium-browser'
alias o='ls -latr'
```

### New ls alias
ls --color=auto tai tilanteesta riippuen ls -alF --color=auto

### Ukko ls stuff
##### Login session
```
jajojajo@ukko160:~$ ls
Backup            config     DSC_0012.JPG         lapio komento  manuals    NetBeansProjects  scripts    var
bakup.log         Desktop    hs_err_pid11841.log  lapio.txt      Moi.class  Pictures          Templates  Videos
bakup.log~        Documents  kron.tab             lock           Moi.java   Public            testi.txt  Windows
build.properties  Downloads  kron.tab~            Mail           Music      public_html       työväline
```

##### Non-login session
```
jajojajo@melkki:~$ ssh ukko160.hpc.cs.helsinki.fi "ls"
Backup
bakup.log
bakup.log~
build.properties
config
Desktop
Documents
Downloads
DSC_0012.JPG
hs_err_pid11841.log
kron.tab
kron.tab~
lapio komento
lapio.txt
lock
Mail
manuals
Moi.class
Moi.java
Music
NetBeansProjects
Pictures
Public
public_html
scripts
Templates
testi.txt
työväline
var
Videos
Windows
```

### Shared Home Directories
```
jajojajo@melkki:~$ ssh ukko160.hpc.cs.helsinki.fi
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.2.0-60-generic x86_64)

jajojajo@ukko160:~$ cat linuxFu/hostname.txt 
melkki

jajojajo@melkki:~$ ssh ukko160.hpc.cs.helsinki.fi "hostname > ~/linuxFu/hostname.txt ; cat linuxFu/hostname.txt"
ukko160
```

### RSYNC
##### rsync into populated folder
```
Number of files: 25
Number of files transferred: 0
Total file size: 11179311 bytes
Total transferred file size: 0 bytes
Literal data: 0 bytes
Matched data: 0 bytes
File list size: 467
File list generation time: 0.013 seconds
File list transfer time: 0.000 seconds
Total bytes sent: 476
Total bytes received: 12
```

##### rsync into empty folder
```
Number of files: 25
Number of files transferred: 24
Total file size: 11179311 bytes
Total transferred file size: 11179311 bytes
Literal data: 11179311 bytes
Matched data: 0 bytes
File list size: 467
File list generation time: 0.067 seconds
File list transfer time: 0.000 seconds
Total bytes sent: 11182146
Total bytes received: 471

sent 11182146 bytes  received 471 bytes  4473046.80 bytes/sec
total size is 11179311  speedup is 1.00
```

Rsync performs a quick check that looks for files that have changed by default in size or in last-modified time. If there is no changes nothing is downloaded.

### Date
```
jajojajo@melkki:~/linuxFu$ date +%A.%Y.%m.%d
perjantai.2014.11.07
```
### Sync todays date
``` bash
rsync --archive --stats ~tkt_cam/public_html/`date +%Y/%m/%d/` ~/linuxFu/rsync/tkt_cam/`date +%A.%Y.%m.%d/`
``` 
