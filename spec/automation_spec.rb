require 'pry'
require 'spec_helper'
require_relative '../lib/modules/log_parser'

RSpec.describe LogParser do

  before :each do
    FileUtils.mkdir_p("#{Dir.tmpdir}/foo/bar")
    File.open(File.join(Dir.tmpdir, 'foo','production.log'), 'w') { |f| f << 'you’re our only hope' }
    File.open(File.join(Dir.tmpdir, 'foo', 'bar', 'test.log'), 'w') { |f| f << 'these are not the logs you are looking for' }
  end

  describe 'Automation' do
    it 'finds all .log files within a directory, recursively' do
      expect{ LogParser.execute(File.join(Dir.tmpdir, 'foo')) }.to output("these are not the logs you are looking for\nyou’re our only hope\n").to_stdout
    end
  end

  after :each do
    FileUtils.rm_rf("#{Dir.tmpdir}/foo")
  end
end
