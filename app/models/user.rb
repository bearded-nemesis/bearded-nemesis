class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :admin, :name

  before_validation :whitelisted

  has_many :ratings
  has_and_belongs_to_many :songs

  has_many :rock_parties
  has_many :playlists

  has_many :friendships
  has_many :friends, :through => :friendships, :uniq => true
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def is_admin?
    admin
  end

  def display_name
    return email if name.nil? or name.empty?
    "#{name} (#{email})"
  end

  private

  def whitelisted
    unless Admin::Whitelist.where(:email => email).any?
      errors.add :email, "is not on our invitation list"
    end
  end
end
