# frozen_string_literal: true

require 'base64'

class FileUtils

  def self.file_to_base64(file_path)
    file = File.open(file_path, 'rb') { |file| file.read }
    Base64.strict_encode64(file)
  end

  def self.base64_to_file(content, file_path)
    binary = Base64.strict_decode64(content)
    File.open(file_path, 'wb') { |file| file.write(binary) }
  end

  def self.write_content(content, file_path)
    File.open(file_path, 'w') { |file| file.write(content) }
  end

  def self.read_content(file_path)
    file = File.open(file_path, 'r') { |file| file.read }
  end
end