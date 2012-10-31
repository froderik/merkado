class EmailUniquenessValidator < ActiveModel::Validator
  def validate record
    matching_email_record = record.class.send :find_by_email, record.email
    if matching_email_record
      record.errors[:base] << "The email #{record.email} already exists"
    end
  end
end
