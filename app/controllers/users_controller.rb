class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
   def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
 def edit
  @user = User.find(params[:id])
end

 def update
  @user = User.find(params[:id])
   if  @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path 
      flash[:success] = "プロフィールを更新しました"
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ログインされました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  before_action :correct_user, only: [:edit, :update]
  
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation,:area,:profile)
    end
    
    def correct_user
     @user = User.find(params[:id])
        redirect_to(root_path) unless @user == current_user 
   end
end