FactoryGirl.define do
  factory :front_end_builds_pubkey, :class => 'FrontEndBuilds::Pubkey' do
    name 'ryan'
    sequence(:pubkey) { |i| "ssh-rsa pubkey#{i}#{i}#{i} test@ted.com" }
  end
end
