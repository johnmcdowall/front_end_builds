require 'open-uri'

module FrontEndBuilds
  class Build < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :branch,
                      :sha,
                      :endpoint
    end

    belongs_to :app, class_name: "FrontEndBuilds::App"
    belongs_to :pubkey, class_name: "FrontEndBuilds::Pubkey"

    validates :app, presence: true
    validates :sha, presence: true
    validates :branch, presence: true
    validates :endpoint, presence: true

    scope :recent, -> { limit(10).order('created_at desc') }

    def self.find_best(params = {})
      scope = self

      query = {
        fetched: true,
        active: true
      }

      if params[:app]
        query[:app_id] = params[:app].id
      end

      if params[:app_name]
        scope = scope
          .joins(:app)
          .where(
            front_end_builds_apps: { name: params[:app_name] }
          )
      end

      # If job or sha is passed in we won't require the
      # best build to be active. This allows us to smoke
      # test non active builds
      if params[:sha]
        query[:sha] = params[:sha]
        query.delete(:active)

      elsif params[:job]
        query[:job] = params[:job]
        query.delete(:active)

      elsif params[:branch]
        query[:branch] = params[:branch]

      end

      scope
        .where(query)
        .limit(1)
        .order('created_at desc')
        .first
    end

    def live?
      self == app.find_best_build
    end

    def fetch!
      return if fetched?

      html = URI.parse(endpoint).read

      self.html = html
      self.fetched = true
      save
    end

    def activate!
      self.active = true
      save
    end

    def automatic_activiation?
      !app.require_manual_activation?
    end

    def with_head_tag(tag)
      html.clone.insert(head_pos, tag)
    end

    def serialize
      {
        id: id,
        app_id: app_id,
        sha: sha,
        branch: branch,
        active: active
      }
    end

    private

    def head_pos
      head_open = html.index("<head")
      if head_open
        html.index(">", head_open) + 1
      else
        0
      end
    end
  end
end
