require 'spec_helper'
require_relative '../lib/modules/log_parser'

RSpec.describe LogParser do

  before :each do
    FileUtils.mkdir_p("#{Dir.tmpdir}/var/logs/foo/bar")
    File.open(File.join(Dir.tmpdir, 'var', 'logs', 'foo', 'production.log'), 'w') { |f| f << 'you’re our only hope' }
    File.open(File.join(Dir.tmpdir, 'var', 'logs', 'foo', 'bar', 'test.log'), 'w') { |f| f << 'these are not the logs you are looking for' }
  end

  describe 'Automation' do
    it 'finds all .log files and prints their contents within a directory, recursively' do
      expect{ LogParser.execute(File.join(Dir.tmpdir, 'var','logs')) }.to output("these are not the logs you are looking for\nyou’re our only hope\n").to_stdout
    end

    it 'prints lines with timestamps in the form: `YYYY-MM-DD HH:MM:SS`' do
      File.open(File.join(Dir.tmpdir, 'var', 'logs', 'star_date.log'), 'w') { |f| f << '2016-06-16 12:11:51 The force will be with you.' }
      expect{ LogParser.execute_with_timestamps(File.join(Dir.tmpdir, 'var', 'logs')) }.to output("2016-06-16 12:11:51 The force will be with you.\n").to_stdout
    end
  end

  after :each do
    FileUtils.rm_rf("#{Dir.tmpdir}/var")
  end
end
