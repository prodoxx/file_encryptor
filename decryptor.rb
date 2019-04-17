# frozen_string_literal: true

require_relative 'lib/file_utils'
require_relative 'lib/secure_file'
require "highline/import"

begin
  raise StandardError.new('Error: required at least one file path as argument') if ARGV.size == 0

  password = ask 'Encryption Password: '
  print "\n"

  salt_file_path = ask "Salt File: "
  salt = FileUtils.read_content(salt_file_path)

  # stretches and hashes the password
  key = SecureFile.hash_password32(salt, password)

  SecureFile.setup(key)

  # decrypt each file and save it
  ARGV.each do |file_path|

    puts "Decrypting #{file_path}"

    encrypted_base64 = FileUtils.read_content(file_path)
    decrypted_base64 = SecureFile.decrypt(encrypted_base64)

    file_name = File.basename(file_path)
    file_name.slice! '_encrypted'

    dir_name = File.dirname(file_path)  

    FileUtils.base64_to_file(decrypted_base64, "#{dir_name}/decrypted_#{file_name}")
  end

  puts 'Decryption Finished!'

rescue StandardError => error
  puts error.message
  puts error.inspect
  puts error.backtrace
end
