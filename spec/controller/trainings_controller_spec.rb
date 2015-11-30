require 'rails_helper'

RSpec.describe TrainingsController, type: :controller do
	describe '#index' do
		context 'requesting private record' do
			it 'authenticate' do
				private_climber_id = FactoryGirl.create(:climber, :private)		
				get :index, climber_id: private_climber_id
				expect(response).to redirect_to(new_climber_session_path)
			end
		end

		context 'requesting public record' do
			it 'does not authenticate' do
				public_climber_id = FactoryGirl.create(:climber, :public)		
				get :index, climber_id: public_climber_id
				expect(response).to render_template(:index) 
			end
		end


		context 'is records owner' do
			it 'assgine @is_owner with true'
			it 'render index template'
		end

		context 'is not records owner' do 
			it 'assgine @is_owner with false'
			it 'render index template'
		end
	end
end