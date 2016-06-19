require 'spec_helper'
require_relative '../lib/modules/log_parser'

RSpec.describe LogParser do
  describe 'Automation' do
    it 'finds all .log files within a directory, recursively' do
      files = LogParser.log_files('/Users/jason/Documents/Projects/apple-takehome/3-endor-automation/spec/fixtures/log/**/*')
      expect(files.length).to eq 22
    end

    it 'outputs the contents of every log file, using one shell liner' do
    end

    it 'outputs lines containing timestamps of form "YYYY-MM-DD HH:MM:SS"' do
    end
  end
end
