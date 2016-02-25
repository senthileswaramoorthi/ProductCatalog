class Admi < ActiveRecord::Base

validates :username, presence: true

validates :username, uniqueness: true

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :email,:presence => {:message => "Enter your email address!" },:format => { :with => VALID_EMAIL_REGEX, :message => "Enter a valid Email address !"},:uniqueness => {:case_sensitive => false, :message => "Email already exists!"}


attr_accessor :password_confirmation

validates :password, :presence =>true, :length => { :minimum => 5, :maximum => 40 }, :confirmation =>true

validates_confirmation_of :password

end
