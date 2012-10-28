def last_email
  ActionMailer::Base.deliveries.last
end

def email_queue
  ActionMailer::Base.deliveries
end

def reset_email
  ActionMailer::Base.deliveries = []
end
