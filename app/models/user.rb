class User < ActiveRecord::Base
  # User can have many Adventures, can belong to many Adventures
  has_and_belongs_to_many :adventures
  # adds roles to Users
  rolify
  # adds User avatar
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>", small: "50x50#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  # added devise (login/logout functionality)
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  # requires that Users add a username
  validates :username, presence: true
  # requires that usernames must be unique
  validates :username, uniqueness: true
  # assigns a role automatically after creating User
  after_create :assign_role
  # User has many Posts, Posts belong_to a User, ensures post will be destroyed along with the user
  has_many :posts, dependent: :destroy
  # User can be a follower and can be followed
  acts_as_follower
  acts_as_followable
  # No spaces in username allowed
  validates :username, format: { without: /\s/, message: "must contain no spaces." }

  # assigns role(:user) when User is created
  def assign_role
    add_role(:user)
  end

   def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.uid + "@twitter.com"
       user.password = Devise.friendly_token[0,20]
     end
   end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user| user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if email.include? ("twitter")
       update_attributes(params, *options)
    else
      super
    end
  end

  # Creating a method for blog posts feed
  # def feed
  #   followees = current_user.followees(User)
  #   followees_posts = followees.map{|followee| followee.posts}
  #   self_posts = Post.where( user_id: current_user.id )
  #   @feed = followees_posts << self_posts
  #   #@feed.sort_by &:created_at
  #   # default_scope -> { order(created_at: :desc) }
  # end
end
