require 'rails_helper'
require 'date'

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
				expect(assigns(:is_owner)).to be true
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
				expect(assigns(:is_owner)).to be false
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
				expect(assigns(:is_owner)).to be false
			end
			
			it 'redirect back to root page' do
				expect(response).to redirect_to(:root)
			end
		end
	end

	describe '#create' do
		it 'create new traning records if climber logged in' do
			climber_id = FactoryGirl.create(:climber, :public)
			sign_in climber_id
			post :create, training: { date: Date.today.to_s }
			expect(response.location).to match('finishes/new\?training_id\=[0-9]+')
		end
		it 'redirect to log in page if climber have not log in' do
			climber_id = FactoryGirl.create(:climber, :public)
			post :create, training: { date: Date.today.to_s }
			expect(response).to redirect_to(new_climber_session_path)
		end
	end

	describe 'delete' do
		it 'delete the training record if the climber own it' do
			climber_id = FactoryGirl.create(:climber, :public)
			training = FactoryGirl.create(:training, climber_id: climber_id.id)
			sign_in climber_id
			@request.env['HTTP_REFERER'] = 'http://redirect_back'
			delete :destroy, id: training.id
			expect(response).to redirect_to('http://redirect_back')
		end

		it 'redirect to sign_in page if climber have not' do 
			climber_id = FactoryGirl.create(:climber, :public)
			training = FactoryGirl.create(:training, climber_id: climber_id.id)
			@request.env['HTTP_REFERER'] = 'http://redirect_back'
			delete :destroy, id: training.id
			expect(response).to redirect_to(new_climber_session_path)
		end

		it 'do something else if the climber does not own the training record' do
			climber_id = FactoryGirl.create(:climber, :public)
			sign_in climber_id
			other_climber_id = FactoryGirl.create(:climber, :public)
			training = FactoryGirl.create(:training, climber_id: other_climber_id.id)

			delete :destroy, id: training.id
			expect(response).to redirect_to(:root)
		end
	end



	describe '#update' do
		it 'check authentication' do
			patch :update, id: 'dummy id'
			expect(response).to redirect_to(new_climber_session_path)
		end

		context 'climer owns the record' do
			let(:climber) { FactoryGirl.create(:climber, :public) }
			let(:training) { FactoryGirl.create(:training, climber_id: climber.id) }

			before do
				sign_in climber
				patch :update, id: training.id, training: { date: (Date.today - 1).to_s }
			end

			it 'redirect to finishes index' do
				expect(response).to redirect_to finishes_path(training_id: training.id)
			end

			it 'update record' do
				expect(Training.find(training.id).date.to_s).to eq (Date.today - 1).to_s
			end
		end

		context 'climber does not own the record' do
			before do
				sign_in_climber_id = FactoryGirl.create(:climber, :public)		
				other_public_climber_id = FactoryGirl.create(:climber, :public)	
				sign_in sign_in_climber_id	

				training = FactoryGirl.create(:training, climber_id: other_public_climber_id.id)
				patch :update, id: training.id, training: { date: (Date.today - 1).to_s }
			end

			it 'redirect back to root' do
				expect(response).to redirect_to(:root)
			end
		end
	end
end