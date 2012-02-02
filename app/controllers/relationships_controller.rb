class RelationshipsController < ApplicationController
  before_filter :authenticate

  respond_to :html, :js #можно внести в действие

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user #тоже самое respond_to do |format|
                       #           format.html { redirect_to @user }
                       #           format.js
                       #           end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
