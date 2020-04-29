require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'GET ost_script' do
    it 'should rescue after API call fail' do
      get :lost_script
      expect(response).to redirect_to(messages_path)
      expect(flash[:notice]).to match("We are sorry, but we can't proccess you request right now.")
    end
  end

end