require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Pubkey, :type => :model do
    let(:pubkey) { FactoryGirl.create(:front_end_builds_pubkey) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pubkey) }

    describe '#serialize' do
      subject { pubkey.serialize }
      its([:id]) { should eq(pubkey.id) }
      its([:name]) { should eq(pubkey.name) }
      its([:fingerprint]) { should eq(pubkey.fingerprint) }
    end
  end
end
