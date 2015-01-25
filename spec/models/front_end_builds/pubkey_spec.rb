require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Pubkey, :type => :model do
    let(:pubkey) { FactoryGirl.create(:front_end_builds_pubkey) }

    let(:rsa_private_key) do

    end

    let(:rsa_public_key) do

    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pubkey) }

    describe '#fingerprint' do
      it 'should give the finger print of the pubkey' do
        pending

      end

      it 'should be unknown if it cannot figure out the pubkey' do
        pending

      end
    end

    describe '#ssh_pubkey?' do
      it 'should be true for a ssh-rsa pubkey' do
        pending

      end

      it 'should be true even if the key has no comment' do
        pending

      end

      it 'should be false if the type of unknown' do
        pending

      end

      it 'should be false if the key has no base64 encoded part' do
        pending

      end
    end

    describe '#fix_ssh_pubkey' do
      it 'should fix an ssh pubkey' do
        pending

      end

      it 'should not fix an open ssl rsa pkey' do
        pending

      end
    end

    describe '#verify' do
      it 'should verify the signature is valid for a build' do
        pending

      end

      it 'should not verify a bad signature for a build' do
        pending

      end

      it 'should not be able to use a signature for multiple builds' do
        pending

      end
    end

    describe '#serialize' do
      subject { pubkey.serialize }
      its([:id]) { should eq(pubkey.id) }
      its([:name]) { should eq(pubkey.name) }
      its([:fingerprint]) { should eq(pubkey.fingerprint) }
    end
  end
end
