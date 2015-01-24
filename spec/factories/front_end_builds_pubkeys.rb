FactoryGirl.define do
  factory :front_end_builds_pubkey, :class => 'FrontEndBuilds::Pubkey' do
    name 'ryan'
    sequence(:pubkey) { |i| "ssh-rsa Pubkey#{i} test@ted.com" }
  end

end
