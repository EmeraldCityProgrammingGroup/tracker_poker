class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :pivotal_users
  has_and_belongs_to_many :rooms 
  has_many :story_votes 
  
  def self.authenticate(username, password)
    user = User.find_for_authentication(:email => username)
    user.valid_password?(password) ? user : nil
  end
  
end
