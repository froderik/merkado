module Couch

  module InstanceMethods
    def save
      CouchPotato.database.save_document self
    end

    def destroy
      CouchPotato.database.destroy_document self
    end
  end

  # so you can do Couch.find_by_id id
  def self.find_by_id id
    CouchPotato.database.load id
  end

  def self.find_mapped_by_id id
    id_doc_tuples = find_by_id( id ).map { |doc| [doc.id, doc]}
    Hash[id_doc_tuples]
  end
end
