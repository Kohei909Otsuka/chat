class User < ApplicationRecord
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PASSWORD_FORMAT = /\A[a-zA-Z0-9_-]{9,}\Z/

  has_many :rooms, through: :user_rooms
  has_many :msgs
  has_many :unread_msgs

  validates :name, presence: true

  validates :email,
    presence: true,
    format: EMAIL_FORMAT,
    uniqueness: true

  # NOTE: 新規会員登録
  def self.register(name, email, password)
    errs = validate_password(password)
    if errs.length > 0
      return Result.new(errs, nil)
    end

    hashed_password = User.hash(password)
    user = User.new(
      name: name,
      email: email,
      hashed_password: hashed_password
    )

    if user.save
      return Result.new([], user)
    else
      return Result.new(user.errors.full_messages, user)
    end
  end

  private

  def self.hash(string)
    Digest::SHA256.hexdigest(string)
  end

  def self.validate_password(password)
    errs = []
    if password.nil? || password == ""
      errs << "パスワードは必須です"
      return errs
    end

    has_char = !password.index(/[a-zA-z]/).nil?
    has_num = !password.index(/[0-9]/).nil?
    has_sym = !password.index(/[_-]/).nil?

    if !PASSWORD_FORMAT.match?(password) || !has_char || !has_num || !has_sym
      errs << "パスワードは9文字以上で、英字、数字、記号(_-)をそれぞれ１つ以上含む必要があります"
    end

    return errs
  end
end
