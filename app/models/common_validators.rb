class EmailUniquenessValidator < ActiveModel::Validator
  def validate record
    matching_emails = record.class.send :find_by_email, record.email
    unless matching_emails.empty?
      record.errors[:base] << "The email #{record.email} already exists"
    end
  end
end
