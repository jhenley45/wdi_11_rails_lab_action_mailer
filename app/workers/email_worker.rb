class EmailWorker
  @queue = :default

  def self.send_old_email(user)
  	email_to = user.email
  	subject = 'Someone stole your book!'
  	body = 'You idiot, someone stole your book.'
  	Pony.mail(to: email_to, subject: subject, body: body, from: 'oldmcdonald@hadafarm.com')
  end

  def self.send_new_email(user)
  	email_to_new = user.email
  	subject_new = 'You stole a book!'
  	body_new = "Great job, you stole \"#{user.books.last.title}\""
  	Pony.mail(to: email_to_new, subject: subject_new, body: body_new, from: 'sumbody@aol.com')
  end

  def self.perform(old_user_id, new_user_id)
  	old_user = User.find(old_user_id)
  	new_user = User.find(new_user_id)
    send_old_email(old_user)
    send_new_email(new_user)
  end


end
