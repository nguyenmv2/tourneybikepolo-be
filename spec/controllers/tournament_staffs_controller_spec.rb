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

RSpec.describe TournamentStaffsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # TournamentStaff. As you add validations to TournamentStaff, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TournamentStaffsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all tournament_staffs as @tournament_staffs" do
      tournament_staff = TournamentStaff.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:tournament_staffs)).to eq([tournament_staff])
    end
  end

  describe "GET #show" do
    it "assigns the requested tournament_staff as @tournament_staff" do
      tournament_staff = TournamentStaff.create! valid_attributes
      get :show, params: {id: tournament_staff.to_param}, session: valid_session
      expect(assigns(:tournament_staff)).to eq(tournament_staff)
    end
  end

  describe "GET #new" do
    it "assigns a new tournament_staff as @tournament_staff" do
      get :new, params: {}, session: valid_session
      expect(assigns(:tournament_staff)).to be_a_new(TournamentStaff)
    end
  end

  describe "GET #edit" do
    it "assigns the requested tournament_staff as @tournament_staff" do
      tournament_staff = TournamentStaff.create! valid_attributes
      get :edit, params: {id: tournament_staff.to_param}, session: valid_session
      expect(assigns(:tournament_staff)).to eq(tournament_staff)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TournamentStaff" do
        expect {
          post :create, params: {tournament_staff: valid_attributes}, session: valid_session
        }.to change(TournamentStaff, :count).by(1)
      end

      it "assigns a newly created tournament_staff as @tournament_staff" do
        post :create, params: {tournament_staff: valid_attributes}, session: valid_session
        expect(assigns(:tournament_staff)).to be_a(TournamentStaff)
        expect(assigns(:tournament_staff)).to be_persisted
      end

      it "redirects to the created tournament_staff" do
        post :create, params: {tournament_staff: valid_attributes}, session: valid_session
        expect(response).to redirect_to(TournamentStaff.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved tournament_staff as @tournament_staff" do
        post :create, params: {tournament_staff: invalid_attributes}, session: valid_session
        expect(assigns(:tournament_staff)).to be_a_new(TournamentStaff)
      end

      it "re-renders the 'new' template" do
        post :create, params: {tournament_staff: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested tournament_staff" do
        tournament_staff = TournamentStaff.create! valid_attributes
        put :update, params: {id: tournament_staff.to_param, tournament_staff: new_attributes}, session: valid_session
        tournament_staff.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested tournament_staff as @tournament_staff" do
        tournament_staff = TournamentStaff.create! valid_attributes
        put :update, params: {id: tournament_staff.to_param, tournament_staff: valid_attributes}, session: valid_session
        expect(assigns(:tournament_staff)).to eq(tournament_staff)
      end

      it "redirects to the tournament_staff" do
        tournament_staff = TournamentStaff.create! valid_attributes
        put :update, params: {id: tournament_staff.to_param, tournament_staff: valid_attributes}, session: valid_session
        expect(response).to redirect_to(tournament_staff)
      end
    end

    context "with invalid params" do
      it "assigns the tournament_staff as @tournament_staff" do
        tournament_staff = TournamentStaff.create! valid_attributes
        put :update, params: {id: tournament_staff.to_param, tournament_staff: invalid_attributes}, session: valid_session
        expect(assigns(:tournament_staff)).to eq(tournament_staff)
      end

      it "re-renders the 'edit' template" do
        tournament_staff = TournamentStaff.create! valid_attributes
        put :update, params: {id: tournament_staff.to_param, tournament_staff: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tournament_staff" do
      tournament_staff = TournamentStaff.create! valid_attributes
      expect {
        delete :destroy, params: {id: tournament_staff.to_param}, session: valid_session
      }.to change(TournamentStaff, :count).by(-1)
    end

    it "redirects to the tournament_staffs list" do
      tournament_staff = TournamentStaff.create! valid_attributes
      delete :destroy, params: {id: tournament_staff.to_param}, session: valid_session
      expect(response).to redirect_to(tournament_staffs_url)
    end
  end

end
