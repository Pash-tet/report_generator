# REPORT GENERATOR
## Run
`FILENAME=path_to_file ruby app.rb`


## Benchmarks
`ruby bench.rb`
#### data_bench.txt
```
Rehearsal -------------------------------------------------
my generator    0.349261   0.017540   0.366801 (  0.370106)
old generator 106.592397   3.593717 110.186114 (120.596414)
-------------------------------------- total: 110.552915sec
```
```
                    user     system      total        real
my generator    0.300203   0.012176   0.312379 (  0.316529)
old generator  98.143439   3.696374 101.839813 (112.556172)
```
#### data_large.txt
```
Rehearsal -------------------------------------------------
my generator   42.239387   2.339625  44.579012 ( 47.387331)
old generator  after 3 hours, i aborted execution :)
```

```
                     user     system      total        real
my generator    40.239837   1.065504  41.305341 ( 41.750901)
old generator   after 3 hours, i aborted execution :)

```