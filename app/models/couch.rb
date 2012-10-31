module Couch

  module InstanceMethods
    def save
      CouchPotato.database.save_document self
    end

    def destroy
      CouchPotato.database.destroy_document self
    end
  end

  # so you can do User.find_by_id id
  def self.find_by_id id
    CouchPotato.database.load id
  end
end
