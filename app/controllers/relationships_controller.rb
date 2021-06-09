class RelationshipsController < ApplicationController

  # フォロー機能の作成・保存
  def create
   following = current_user.follow(params[:user_id])
   if following.save
    @user = User.find(params[:user_id])
     redirect_to user_path(@user), notice: "You succeeded in following."
   else
     redirect_back(fallback_location: root_path)
   end
  end

  # フォロー機能の解除
  def destroy
   following = current_user.unfollow(params[:user_id])
   if following.destroy
     @user = User.find(params[:user_id])
     redirect_to user_path(@user), notice: 'You have successfully unfollowed.'
   else
     redirect_back(fallback_location: root_path)
   end
  end

end
