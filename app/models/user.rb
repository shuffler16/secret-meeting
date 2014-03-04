class User < ActiveRecord::Base
  has_secure_password

  def to_s
    "#{first_name} #{last_name}"
  end
end
