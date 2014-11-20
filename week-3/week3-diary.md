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
