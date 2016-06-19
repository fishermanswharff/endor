require 'find'

module LogParser

  def self.execute(filepath)
    Dir.glob("#{filepath.chomp('/')}/**/*") { |file| puts `cat #{file}` unless File.directory?(file) }
  end

  def self.execute_with_timestamps(filepath)
    glob = "#{filepath.chomp('/')}/**/*"
    Dir.glob(glob) do |file|
      unless File.directory?(file)
        File.open(file) do |f|
          content = f.read
          content.each_line do |l|
            puts l if l.match(/([\d]{4}\-[\d]{2}\-[\d]{2}[\s]{1}[\d]{2}\:[\d]{2}\:[\d]{2}.*)/)
          end
          f.close
        end
      end
    end
  end

  class Utility
    def self.normalize_names(filepath)
      Dir.glob(filepath) { |file|
        next if %w(. .. .DS_Store).include?(file)
        unless File.extname(file) == '.log' || File.directory?(file)
          elements = file.split(/(\.log)/)
          File.rename(file, "#{elements[0]}-#{elements[-1].gsub('.', '')}#{elements[1]}")
        end
      }
    end
  end
end
