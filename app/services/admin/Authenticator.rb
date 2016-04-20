class Staff::Authenticator
  def initialize(admin)
    @admin = admin
  end

  def authenticate(raw_password)
    @admin &&
        @admin.hashed_password &&
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end