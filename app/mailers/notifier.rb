class Notifier < ActionMailer::Base
  def greeting_notification(form_input)
  	# define @greeting to use in associated template
    @greeting = form_input
    mail(to: "anna.tsykalova@gmail.com",
      from: form_input.visitor_email,
      subject: "New message from #{form_input.visitor_email}")
  end

  def send_welcome_message(user)
  	@user = user
  	mail(to: user.email,
  		from: 'welcome@ourapp.com',
  		subject: 'Welcome to our app!')
  end

  def send_book_notification(book)
    @book = book
    mail(to: @book.user.email,
      from: 'books@ourapp.com',
      subject: 'You created a new book')
  end

  def send_new_owner(book)
    @book = book
    mail(to: @book.user.email,
      from: 'books@ourapp.com',
      subject: 'You have stolen a book')
  end
    def send_old_owner(user)
    @user = user
    mail(to: @user.email,
      from: 'books@ourapp.com',
      subject: 'Your book has been stolen')
  end

end
