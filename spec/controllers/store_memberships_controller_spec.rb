# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe StoreMembershipsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # StoreMembership. As you add validations to StoreMembership, be sure to
  # adjust the attributes here as well.
  let!(:user) { create(:user) }
  let!(:store) { create(:store) }
  let(:valid_attributes) {
    attributes_for(:store_membership, user_id: user.id, store_id: store.id, role: :regular)
  }

  let(:invalid_attributes) {
    {
      role: :role
    }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoreMembershipsController. Be sure to keep this updated too.

  describe 'GET #index' do
    it 'returns a success response' do
      StoreMembership.create! valid_attributes
      membership = create(:store_membership, store: store, role: :admin)
      request.headers.merge! membership.user.create_new_auth_token
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      store_membership = StoreMembership.create! valid_attributes
      membership = create(:store_membership, store: store, role: :admin)
      request.headers.merge! membership.user.create_new_auth_token
      get :show, params: {id: store_membership.to_param}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new StoreMembership' do
        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        expect {
          post :create, params: {store_membership: valid_attributes}
        }.to change(StoreMembership, :count).by(1)
      end

      it 'renders a JSON response with the new store_membership' do
        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        post :create, params: {store_membership: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new store_membership' do
        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        post :create, params: {store_membership: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {role: :admin}
      }

      it 'updates the requested store_membership' do
        store_membership = StoreMembership.create! valid_attributes
        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        put :update, params: {id: store_membership.to_param, store_membership: new_attributes}
        store_membership.reload
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['role']).to eq(new_attributes[:role].to_s)
      end

      it 'renders a JSON response with the store_membership' do
        store_membership = StoreMembership.create! valid_attributes

        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        put :update, params: {id: store_membership.to_param, store_membership: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the store_membership' do
        store_membership = StoreMembership.create! valid_attributes

        membership = create(:store_membership, store: store, role: :admin)
        request.headers.merge! membership.user.create_new_auth_token
        put :update, params: {id: store_membership.to_param, store_membership: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested store_membership' do
      store_membership = StoreMembership.create! valid_attributes
      membership = create(:store_membership, store: store, role: :admin)
      request.headers.merge! membership.user.create_new_auth_token
      expect {
        delete :destroy, params: {id: store_membership.to_param}
      }.to change(StoreMembership, :count).by(-1)
    end
  end
end
