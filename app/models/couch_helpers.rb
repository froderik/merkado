module CouchHelpers
  def save
    CouchPotato.database.save_document self
  end
end
