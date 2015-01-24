module FrontEndBuilds
  class Pubkey < ActiveRecord::Base
    validates :name, presence: true
    validates :pubkey, presence: true
  end
end
