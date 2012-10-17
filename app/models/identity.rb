module OmniAuth
  module Identity
    module Models
      # can not be named CouchPotato since there is a class with that name
      module CouchPotatoModule

        def self.included(base)

          base.class_eval do

            include ::OmniAuth::Identity::Model
            include ::OmniAuth::Identity::SecurePassword

            has_secure_password

            def self.auth_key=(key)
              super
              validates_uniqueness_of key, :case_sensitive => false
            end

            def self.locate(search_hash)
              where(search_hash).first
            end
          end
        end
      end
    end
  end
end

# the above can be removed once it has made it into omniauth-identity proper

class Identity
  include CouchPotato::Persistence
  include OmniAuth::Identity::Models::CouchPotatoModule
  include CouchHelpers

  property :email
  property :password_digest

  def self.where search_hash
    CouchPotato.database.view Identity.by_email(:key => search_hash)
  end

  view :by_email, :key => :email
end