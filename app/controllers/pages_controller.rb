class PagesController < ApplicationController
  def home
    @users = User.all
    @users_except_current = User.where.not(id: current_user.id).order("github_username")
  end
end
