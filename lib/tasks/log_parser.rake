require 'pry'
require 'benchmark'
require_relative '../modules/log_parser'

task default: %w[parse_logs]
task :parse_logs_with_benchmark, [:directory, :with_timestamps] do |t, args|
  Benchmark.bm do |b|
    b.report('Complete Logfile: ') { LogParser.execute(args[:directory]) unless args[:with_timestamps] }
    b.report('Only Timestamped lines: ') { LogParser.execute_with_timestamps(args[:directory]) if args[:with_timestamps] }
  end
end

task :parse_logs, [:directory, :with_timestamps] do |t, args|
  LogParser.execute(args[:directory]) unless args[:with_timestamps]
  LogParser.execute_with_timestamps(args[:directory]) if args[:with_timestamps]
end

task :normalize_name, [:directory] do |t, args|
end
