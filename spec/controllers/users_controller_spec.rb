require 'rails_helper'

describe UsersController do
  user = User.first
  parameters = {
    params: {
      id: user.id
    }
  }
  describe "GET #show" do
      context "non logged-in users" do
      it "redirects to log in page when a non-logged users try to access a member's page" do
        get :show, parameters
        expect(response).to redirect_to signin_path
      end
    end

    context "logged users" do
      it "renders the selected user's page if a logged user tries to access it" do
        log_in(User.last)
        get :show, parameters
        expect(response).to render_template("show")
      end
    end

  end

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "assigns @user as a new instance of User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    context "non-logged user" do
      it "redirects to sign in path" do
        get :edit, parameters
        expect(response).to redirect_to signin_path
      end
    end

    context "logged user editing his/her own profile" do
      it "renders edit template" do
        log_in(user)
        get :edit, parameters
        expect(response).to render_template(:edit)
      end
    end

    context "logged user trying to edit another user's profile" do

      it "redirects to the current_user's profile" do
        log_in(User.last)
        get :edit, parameters
        expect(response).to redirect_to user_path(User.last)
      end
    end

    it "shows a flash message" do
      log_in(User.last)
      get :edit, parameters
      expect(flash[:danger]).to match("You are not authorized to do that.")
    end

  end

  describe "POST #create" do
    
    context "valid user signup" do
      it "saves the new user to the database" do
        # skip
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "redirects to the new user's page" do
        # skip
        post :create, params: { user: FactoryBot.attributes_for(:user)}
        expect(response).to redirect_to user_path(assigns[:user])
      end
      
      it "shows a flash[:success]" do
        # skip
        post :create, params: { user: FactoryBot.attributes_for(:user)}

        expect(flash[:success]).to match("Welcome to Members-Only #{assigns[:user].name}!")
      end
      
      it "automatically logs in the user" do
        # skip
        post :create, params: { user: FactoryBot.attributes_for(:user)}
        
        expect(current_user).to eq(assigns[:user])
      end
    end

    context "invalid user signup" do

      it "doesn't save to the database" do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:invalid_user)}
        }.to_not change(User, :count)
      end
      
      it "re-renders new template" do
        post :create, params: { user: FactoryBot.attributes_for(:invalid_user)}
        expect(response).to render_template("new")
      end

      it "shows errors" do
        post :create, params: { user: FactoryBot.attributes_for(:invalid_user)}

        expect(assigns[:user].errors.full_messages[0]).to include("can't be blank")
      end

    end

  end

  describe "PATCH #update" do
    
    context "valid attributes" do
      before :each do
        user = User.last
        
        log_in(user)
        
        put :update, params: { id:user.id, user: FactoryBot.attributes_for(:user, name:"Wilson Chandler")}

        user.reload
      end

      it "saves changes to the database" do
        expect(user.name).to eq("Wilson Chandler")
      end
      
      it "redirects back to the user's profile" do
        expect(response).to redirect_to(user_path(user))
      end


      it "shows a success flash" do
        expect(flash[:success]).to match("Profile updated!")
      end

    end

    context "invalid attributes" do
      before :each do
        @user = User.last
        
        log_in(@user)
        
        put :update, params: { id:@user.id, user: FactoryBot.attributes_for(:user, name:nil)}

      end


      it "re-renders the edit template" do
        expect(response).to render_template("edit")
      end

      it "shows errors" do

        expect(assigns[:user].errors.full_messages[0]).to include("can't be blank")
      end
    end

    context "unauthorized user update" do
      before :each do
        @owner = User.first
        @intruder = User.last
        log_in(@intruder)
        put :update, params: { id:@owner.id, user: FactoryBot.attributes_for(:user)}
        end

        it "redirects to intruder's own profile" do
          expect(response).to redirect_to(user_path(@intruder))
        end

        it "shows a flash[:danger] message" do
          expect(flash[:danger]).to match("You are not authorized to do that.")
        end 

      end

    end

  describe "DELETE #destroy" do
    
    before :each do
      @user = User.last
      
      log_in(@user)
    end

    context "found user" do
      it "removes user from database" do
        expect {
          delete :destroy, params: {id: @user.id}
        }.to change(User, :count).by(-1)
      end

      it "redirects to root_path" do
        delete :destroy, params: {id: @user.id}
        expect(response).to redirect_to root_path
      end
    end

  end

end