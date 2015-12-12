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
			before do
				private_climber_id = FactoryGirl.create(:climber, :private)
				sign_in private_climber_id		
				get :index, climber_id: private_climber_id
			end

			it 'assgine @is_owner with true' do
				assigns(:is_owner).should be true
			end
			it 'render index template' do
				expect(response).to render_template(:index) 
			end
		end

		context 'is not records owner of a public record' do 
			before do
				sign_in_climber_id = FactoryGirl.create(:climber, :private)		
				other_public_climber_id = FactoryGirl.create(:climber, :public)	

				sign_in sign_in_climber_id	
				get :index, climber_id: other_public_climber_id
			end

			it 'assgine @is_owner with false' do
				assigns(:is_owner).should be false
			end

			it 'render index template' do
				expect(response).to render_template(:index) 
			end
		end

		context 'is not records owner of a private record' do 
			before do
				sign_in_climber_id = FactoryGirl.create(:climber, :private)		
				other_private_climber_id = FactoryGirl.create(:climber, :private)	

				sign_in sign_in_climber_id	
				get :index, climber_id: other_private_climber_id
			end

			it 'assgine @is_owner with false' do
				assigns(:is_owner).should be false
			end
			
			it 'redirect back to root page' do
				expect(response).to redirect_to(:root)
			end
		end
	end
end