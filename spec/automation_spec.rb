require 'spec_helper'
require_relative '../lib/modules/log_parser'

RSpec.describe LogParser do
  before :each do
    begin
      FileUtils.mkdir_p("#{Dir.tmpdir}/var/logs/foo/bar")
      prod_log = Tempfile.new([File.join('var', 'logs', 'foo', 'production'), '.log'])
      test_log = Tempfile.new([File.join('var', 'logs', 'foo', 'bar', 'test'), '.log'])
      prod_log.write('you’re our only hope')
      test_log.write('these are not the logs you are looking for')
    ensure
      [prod_log, test_log].each(&:close)
    end
  end

  describe 'Automation' do
    it 'finds all .log files and prints their contents within a directory, recursively' do
      expect { LogParser.execute(File.join(Dir.tmpdir, 'var', 'logs')) }.to output("these are not the logs you are looking for\nyou’re our only hope\n").to_stdout
    end

    it 'prints lines with timestamps in the form: `YYYY-MM-DD HH:MM:SS`' do
      File.open(File.join(Dir.tmpdir, 'var', 'logs', 'star_date.log'), 'w') do |f|
        f << '2016-06-16 12:11:51 The force will be with you.'
      end
      expect { LogParser.execute_with_timestamps(File.join(Dir.tmpdir, 'var', 'logs')) }.to output("2016-06-16 12:11:51 The force will be with you.\n").to_stdout
    end
  end

  after :each do
    FileUtils.rm_rf("#{Dir.tmpdir}/var")
  end
end
