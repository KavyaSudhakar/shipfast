require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:customer_user) { create(:user, role: :customer) }
  let(:delivery_partner_user) { create(:user, role: :delivery_partner) }

  describe "GET #customers" do
    it "assigns @customers" do
      get :customers
      expect(assigns(:customers)).to eq(User.where(role: :customer))
    end
  end

  describe "GET #delivery_partners" do
    it "assigns @delivery_partners" do
      get :delivery_partners
      expect(assigns(:delivery_partners)).to eq(User.where(role: :delivery_partner))
    end
  end

  describe "GET #onboard_form" do
    it "assigns @user" do
      get :onboard_form
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #onboard" do
    context "when admin user is logged in" do
      before { sign_in admin_user }

      context "with valid parameters" do
        it "creates a new user" do
          expect {
            post :onboard, params: { user: attributes_for(:user, role: :customer) }
          }.to change(User, :count).by(1)
        end

        it "redirects to customers path after onboarding" do
          post :onboard, params: { user: attributes_for(:user, role: :customer) }
          expect(response).to redirect_to(customers_path)
        end
      end
    end
  end

  describe "DELETE #offboard" do
        context "when admin user is logged in" do
            before { sign_in admin_user }

            context "with valid user" do
            let(:user) { create(:user) }

            it "deactivates the user" do
                delete :offboard, params: { id: user.id }
                expect(user.reload.deactivated).to be true
            end

            it "sets flash[:success] message" do
                delete :offboard, params: { id: user.id }
                expect(flash[:success]).to eq("User offboarded successfully.")
            end
            end

            context "with invalid user" do
                it "redirects back" do
                    delete :offboard, params: { id: -1 }
                    expect(response).to redirect_to(root_path)
                end

                it "sets flash[:error] message" do
                    delete :offboard, params: { id: -1 }
                    expect(flash[:error]).to eq("User not found.")
                end
            end
        end
    end
end
