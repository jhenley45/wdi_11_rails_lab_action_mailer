class User < ActiveRecord::Base
	has_many :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :say_hi

  def say_hi
  	Notifier.send_welcome_message(self).deliver
  end
end
