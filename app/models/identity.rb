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
  include Couch::InstanceMethods

  property :email
  property :password_digest

  def self.where search_hash
    Identity::find_by_email search_hash
  end

  def Identity::find_by_email email
    CouchPotato.database.view Identity.by_email(:key => email)
  end

  view :by_email, :key => :email
end