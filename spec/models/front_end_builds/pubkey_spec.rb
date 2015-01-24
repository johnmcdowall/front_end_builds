require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Pubkey, :type => :model do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pubkey) }
  end
end
