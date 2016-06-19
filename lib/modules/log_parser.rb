require 'pry'
module LogParser

  def self.log_files(filepath)
    Dir.glob(filepath)
  end

  def self.output_log(file)
    `cat #{file}`
  end

  def self.execute(filepath)
    glob = "#{filepath.chomp('/')}/**/*"
    Dir.glob(glob) do |file|
      unless File.directory?(file)
        puts "START: #{file} >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
        puts `cat #{file}`
        puts "END: #{file} >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n\n"
      end
    end
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
