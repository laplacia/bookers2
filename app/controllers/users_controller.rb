class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
      @book.user_id = current_user.id
      @book = Book.new(book_params)
   if @book.save
   flash[:success] = "successfully"
      redirect_to @book
    else
   flash[:danger] = @book.errors.full_messages
      @books = Book.all
      render 'index'
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user
    @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
    flash[:danger] = @user.errors.full_messages
    redirect_back(fallback_location: root_url)
    end
  else
    @book = Book.find(params[:id])
    @book.update(book_params)
    flash[:success] = "successfully"
    redirect_to books_path
  end
  end





  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
