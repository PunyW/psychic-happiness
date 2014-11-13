# Week 2

### Two at once
```
ls ~/ ~/nothing > stdout.txt 2> stderr.txt
```
### Pipelines

```
puny@puny:~/Documents/linuxFun/psychic-happiness/week-2$ /bin/ls ~ | wc -l
12
```
```
puny@puny:~/Documents/linuxFun/psychic-happiness/week-2$ ls ~ > home-directory.txt
puny@puny:~/Documents/linuxFun/psychic-happiness/week-2$ wc -l home-directory.txt 
12 home-directory.txt
```
### Filters 

```
puny@puny:~/Documents/linuxFun/psychic-happiness/week-2$ ls ~ | grep 'e' | wc -l
7
```
### Interlude: Bash

```
#!/bin/bash
# Counts how many files are in the home directory.

ls ~ | wc -l
```
```
puny@puny:~/Documents/linuxFun/psychic-happiness/week-2$ ~/scripts/count-homedir.sh 
13

```

### Some assembly required

```
#!/bin/bash
# List all files and subdirectories from Exactum camera November 2011

ls -R ~tkt_cam/public_html/2011/11/
```

### Just the pics, Ma'am
```
#!/bin/bash
# List images from Exactum camera November 2011

ls -R ~tkt_cam/public_html/2011/11/ | grep .jpg
```

### Umm, how much is that?

```
#!/bin/bash
# Count images from Exactum camera November 2011

ls -R ~tkt_cam/public_html/2011/11/ | grep .jpg | wc -l
```

```
jajojajo@melkki:~/scripts$ ./count-images-from-exactum-cam.sh 
720
```

### Remember the backticks

```
#!/bin/bash
# Count how many images Exactum cam has taken in the current month

ls -R ~tkt_cam/public_html/$(date +%Y/%m/) | grep .jpg | wc -l
```

```
jajojajo@melkki:~/scripts$ ./count-images-from-exactum-cam-current-month.sh 
302
```
### Everybody together now!

```
#!/bin/bash
# Count how many images Exactum cam has taken in the current month

find ~tkt_cam/public_html/$(date +%Y/%m/) -type f | wc -l
```

### Intro to variables

* BASH_ALIASES
   Elementit tässä arrayssä lisätään alias listaan
* HOME
   Tämän hetkisen käyttäjän kotihakemisto, oletus cd komennolle ja käytetään käyttäessä ~
* TMPDIR
   Jos asetettu bash käyttää tätä hakemistoa kun luodaan temp filuja shellin käyttöön.

### Special shell variables

```
#!/bin/bash
# Echoes command-line arguments

echo "$*"
```
```
puny@puny:~/scripts$ ./echo.sh 

puny@puny:~/scripts$ ./echo.sh Lotsa text here to test something?
Lotsa text here to test something?
puny@puny:~/scripts$ ./echo.sh I see a lot of files: `ls`
I see a lot of files: count-homedir.sh echo.sh
```

### The difference between BASH and BASH

```
#!/bin/bash
# Demonstrate the variable visibility within different shells

foo="bar"
echo within first shell \(pid $BASHPID\): \$foo\=$foo
bash -c 'echo within second shell \(pid $BASHPID\): \$foo\=$foo'

```

```
puny@puny:~/scripts$ ./variable-visibility.sh 
within first shell (pid 9568): $foo=bar
within second shell (pid 9569): $foo=
```
### Remote invocation
```
#!/bin/bash
# Execute at given hostname a given command

ssh $1 $2
```
```
puny@puny:~/scripts$ ./remote-invocation.sh jajojajo@melkki.cs.helsinki.fi "uptime"
 14:19:03 up 181 days,  4:17, 371 users,  load average: 3.50, 7.81, 9.16
 ```