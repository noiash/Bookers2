class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @users = User.all
      @book = Book.new
      @user = current_user
      render :index
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
    redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:title, :body, :profile_image, :name, :introduction)
  end

end
