# frozen_string_literal: true

require_relative 'lib/file_utils'
require_relative 'lib/secure_file'
require "highline/import"
begin
  raise StandardError.new('Error: required at least one file path as argument') if ARGV.size == 0

  password = ask 'Encryption Password: '
  print "\n"

  salt_name = ask 'Salt Name: '
  salt = SecureFile.new_salt
  FileUtils.write_content(salt, "salt_#{salt_name}.txt")

  # stretches and hashes the password
  key = SecureFile.hash_password32(salt, password)

  SecureFile.setup(key)

  # encrypt each file and save it
  ARGV.each do |file_path|

    puts "Encrypting #{file_path}"

    original_base64 = FileUtils::file_to_base64(file_path)
    encrypted_base64 = SecureFile.encrypt(original_base64)

    FileUtils.write_content(encrypted_base64, "#{file_path}_encrypted")
  end

  puts "Encryption Finished!"

rescue StandardError => error
  puts error.message
end