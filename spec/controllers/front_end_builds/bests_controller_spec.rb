require 'rails_helper'

module FrontEndBuilds
  RSpec.describe BestsController, :type => :controller do
    let(:app) { FactoryGirl.create :front_end_builds_app, name: 'dummy' }

     describe "show" do
       let!(:latest) do
         FactoryGirl.create :front_end_builds_build,
           app: app,
           sha: 'sha1',
           job: 'number1',
           branch: 'master',
           html: 'the newest build',
           fetched: true,
           active: true,
           created_at: 1.day.ago
       end

       let!(:older) do
         FactoryGirl.create :front_end_builds_build,
           app: app,
           sha: 'sha2',
           job: 'number2',
           branch: 'master',
           html: 'an old build',
           fetched: true,
           active: true,
           created_at: 2.weeks.ago
       end

       it "should find the latest build" do
         get :show, app_name: app.name, branch: 'master'

         expect(response).to be_success
         expect(response.body).to match(latest.html)
       end

       it "should find the build by job" do
         get :show, app_name: app.name, job: 'number2'

         expect(response).to be_success
         expect(response.body).to match(older.html)
       end


       context "meta tags" do
         before(:each) do
           get :show, app_name: app.name, branch: 'master'
           expect(response).to be_success
         end

         subject { response.body }
         it { should match(/csrf-token/) }
         it { should match(/front-end-build-version/) }
         it { should match(/front-end-build-params/) }
         it { should match(/front-end-build-url/) }
       end

       it "should be 404 when nothing is found" do
         get :show, app_name: 'does-not-exist', branch: 'master'
         expect(response).to_not be_success
         expect(response.status).to eq(404)
       end

       it "should be able to get the version of the best build" do
         get :show, app_name: app.name, branch: 'master', format: :json
         expect(json['version']).to eq(latest.id)
       end
     end

  end
end
