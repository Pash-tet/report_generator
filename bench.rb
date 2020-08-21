require 'benchmark'
require_relative 'report_generator'
require_relative 'Task'

file = 'data_bench.txt'
# file = 'data_large.txt'

Benchmark.bmbm do |x|
  x.report('my generator') { ReportGenerator.new(path: file).call }
  x.report('old generator') { OldGenerator.new.work(file) }
end

