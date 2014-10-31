class Feedback < ActiveRecord::Base
  # has_and_belongs_to_many :pages

  validates :name, presence: true, length: {minimum: 3}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}

end
