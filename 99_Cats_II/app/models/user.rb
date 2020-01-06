class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    attr_reader :password

    after_initialize :ensure_session_token

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64(16)
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        self.password_digest
    end

    def is_password?(password)
        pass_check = BCrypt::Password.new(self.password_digest)
        pass_check.is_password?(password)
    end

    def self.find_by_credentials(username, password)
       user = User.find_by(username: username)
       return nil if user.nil?
        if user.is_password?(password)
            return user
        end
    end

    private
        def ensure_session_token
            self.session_token ||= SecureRandom::urlsafe_base64(16)
        end
end
