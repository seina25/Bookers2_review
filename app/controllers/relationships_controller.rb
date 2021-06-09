class RelationshipsController < ApplicationController

  # フォロー機能の作成・保存
  def create
   following = current_user.follow(params[:user_id])
   if following.save
    @user = User.find(params[:user_id])
     redirect_back(fallback_location: root_path)
     flash[:notice] = 'You succeeded in following.'
   else
     redirect_back(fallback_location: root_path)
   end
  end

  # フォロー機能の解除
  def destroy
   following = current_user.unfollow(params[:user_id])
   if following.destroy
     @user = User.find(params[:user_id])
     redirect_back(fallback_location: root_path)
     flash[:notice] = 'You have successfully unfollowed.'
   else
     redirect_back(fallback_location: root_path)
   end
  end

  def followings
   user = User.find(params[:user_id])
   @followings = user.followings
  end

  def followers
   user = User.find(params[:user_id])
   @followers = user.followers
  end

end
