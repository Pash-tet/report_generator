# REPORT GENERATOR
## Run
`FILENAME=path_to_file ruby app.rb`


## Benchmarks
`ruby bench.rb`
#### data_bench.txt
```
Rehearsal -------------------------------------------------
my generator    0.376916   0.020520   0.397436 (  0.406605)
old generator  94.933067   3.216222  98.149289 (100.147481)
--------------------------------------- total: 98.546725sec
```
```
                    user     system      total        real
my generator    0.300297   0.009240   0.309537 (  0.311218)
old generator  90.417756   3.130071  93.547827 ( 94.711776)
```
#### data_large.txt
```
Rehearsal -------------------------------------------------
my generator   48.532419   2.312184  50.844603 ( 55.151736)
old generator  after 3 hours, i aborted execution :)
```
```
                     user     system      total        real
my generator    40.800404   1.050787  41.851191 ( 46.209564)
old generator   after 3 hours, i aborted execution :)

```