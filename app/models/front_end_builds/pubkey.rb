require 'front_end_builds/utils/ssh_pubkey_convert'
require 'base64'
require 'openssl'

module FrontEndBuilds
  class Pubkey < ActiveRecord::Base
    validates :name, presence: true
    validates :pubkey, presence: true

    def fingerprint
      content = pubkey.split(/\s/)[1]

      if content
        Digest::MD5.hexdigest(Base64.decode64(content))
          .scan(/.{1,2}/)
          .join(":")
      else
        'Unknown'
      end
    end

    def ssh_pubkey?
      (type, b64, _) = pubkey.split(/\s/)
      %w{ssh-rsa ssh-dss}.include?(type) && b64.present?
    end

    # Public: In order to verify a signature we need the key to be an OpenSSL
    # RSA PKey and not a string that you would find in an ssh pubkey key. Most
    # people are going to be adding ssh public keys to their build system, this
    # method will covert them to OpenSSL RSA if needed.
    def fix_ssh_pubkey!
      if ssh_pubkey?
        key = FrontEndBuilds::Utils::SSHPubKeyConvert
          .convert(pubkey)

        self.pubkey = Base64.encode64(key)
        save
      end
    end

    def verify(signature, build)

    end

    def serialize
      {
        id: id,
        name: name,
        fingerprint: fingerprint
      }
    end
  end
end
