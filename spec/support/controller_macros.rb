module ControllerMacros
  def login_public_climber
    @request.env["devise.mapping"] = Devise.mappings[:climber]
    public_climber = FactoryGirl.create(:climber, :public)
    sign_in public_climber
  end

  def login_private_climber
    @request.env["devise.mapping"] = Devise.mappings[:climber]
    private_member = FactoryGirl.create(:climber, :private)
    sign_in private_member
  end
end