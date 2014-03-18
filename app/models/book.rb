class Book < ActiveRecord::Base
	belongs_to :user
	after_commit :send_book_notification, on: :create
	after_commit :send_new_owner, on: :update

	def send_book_notification
	  Notifier.send_book_notification(self).deliver
	end

	def send_old_owner(user)
		Notifier.send_old_owner(user).deliver
	end

	def send_new_owner
		Notifier.send_new_owner(self).deliver
	end
end
