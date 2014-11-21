# Week 3

### Not glue but tar
```
-rw-rw-r-- 1 puny puny   481 marra 20 14:11 scriptsbz.tar.bz2
-rw-rw-r-- 1 puny puny   481 marra 20 14:10 scriptsgz.tar.gz
-rw-rw-r-- 1 puny puny 10240 marra 20 14:11 scriptstar.tar
```

Using pipeline
```
tar cf - *sh | gzip -9 > scripts-pipe-gz.tar.gz

tar cf - *sh | lbzip2 > scripts-pipe-bzip2.tar.bz2
```

Using laptop ext4

### Fetch and Extract

```
lbzip2 -dc lost24-monitor-temps-and-fans-v2.tar.bz2 | tar -xf -
```
### No more disk space
```
ssh ukko160.hpc.cs.helsinki.fi "cat lost24-monitor-temps-and-fans-v2.tar.bz2|bzip2 -cd"|tar xf -
```

### Ready, Steady, Go

| Ukko  | Local
|-------|------
|37.769s|50.036
|35.236s|51.898
|35.861s|41.377s

### Grep and Cut
```
grep -r --include "hp-temps.txt" PROCESSOR | rev | cut -c 18-20 | rev | sort -u
```

```
22C
23C
24C
25C
26C
27C
28C
29C
30C
31C
```

### Don't run with scissors
```
sed -e 's/\ \+/,/g' -e 's/\/\+/,/g'
```
### TLDR

```
puny@puny:~/lost24/monitor$ find 2011.11.* -name "hp-temps.txt" | xargs grep "PROCESSOR_ZONE" | rev | cut -c 18-20 | rev | sort -u
11C
12C
13C
14C
15C
16C
17C
18C
19C
20C
21C
22C
23C
24C
25C
26C
27C
28C
29C
```
```
find 2011.11.* -name "hp-temps.txt" -exec grep "PROCESSOR_ZONE" {} \;
```

### The immelmann
```
#!/bin/bash
# Hipstafy all *.jpg images in the given folder.

for file in $(find $1 -name '*jpg' )
do
        prefix=${file%.jpg}
        outputfile=$prefix-hipstah.jpg
        convert -sepia-tone 60% +polaroid $file $outputfile
done
```

### Sidestep: Testing

