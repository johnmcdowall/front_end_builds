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

    def serialize
      {
        id: id,
        name: name,
        fingerprint: fingerprint
      }
    end
  end
end
