require 'pry'
require 'benchmark'
require_relative '../modules/log_parser'

task default: %w[parse_logs]
task :parse_logs, [:directory, :with_timestamps] do |t, args|
  time = Benchmark.realtime do |b|
    LogParser.execute_with_timestamps(args[:directory]) if args[:with_timestamps]
    LogParser.execute(args[:directory]) unless args[:with_timestamps]
  end
  puts "\n\n>>>>>>>>>>> Benchmark: #{time*1000} milliseconds"
end

task :normalize_name, [:directory] do |t, args|
end
