class User < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true

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
end
