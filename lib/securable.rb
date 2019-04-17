# frozen_string_literal: true

require 'base64'
require 'rbnacl'

# Base Class for Encryption
module Securable
  # Generate key for Rake tasks (typically not called at runtime)
  def generate_key
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64 key
  end

  # Call setup once to pass in config variable with DB_KEY attribute
  def setup(base_key)
    @base_key = base_key
  end

  def key
    @key ||= Base64.strict_decode64(@base_key)
  end

  # Encrypt with no checks
  def base_encrypt(plaintext, new_key = nil)
    key_to_use = key
    if new_key
      new_key = Base64.strict_decode64(new_key)
      key_to_use = new_key
    end
    simple_box = RbNaCl::SimpleBox.from_secret_key(key_to_use)
    simple_box.encrypt(plaintext)
  end

  # Decrypt with no checks
  def base_decrypt(ciphertext, new_key = nil)
    key_to_use = key
    if new_key
      new_key = Base64.strict_decode64(new_key)
      key_to_use = new_key
    end
    
    simple_box = RbNaCl::SimpleBox.from_secret_key(key_to_use)
    simple_box.decrypt(ciphertext)
  end

  def base_hash(content)
    RbNaCl::HMAC::SHA256.auth(key, content)
  end
end
