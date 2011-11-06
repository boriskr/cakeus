class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :roles, :type => Array,  default: ["newbie"]
  attr_accessible :provider, :uid, :name, :email

  embeds_many :connects

  def able?(role)
    User.able?(self,role)
  end

  def enable(role)
    User.enable(self,role)
  end

  def self.able?(user,role)
    #puts (@roles)
    if user.roles.include?(role)
      true
    else
      false
    end
  end

  def self.enable(user,role)
    User.where(email: user.email).each do
      |user|
      if (!user.roles.include?(role))
        user.roles << role
        user.save
      end
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['user_info']
        user.name = auth['user_info']['name'] if auth['user_info']['name'] # Twitter, Google, Yahoo, GitHub
        user.email = auth['user_info']['email'] if auth['user_info']['email'] # Google, Yahoo, GitHub
      end
      if auth['extra'] && auth['extra']['user_hash']
        user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
        user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook
      end
    end
  end

end

class Connect
  include Mongoid::Document

  field :provider, :type => String
  field :uid, :type => String
  embedded_in :user
end