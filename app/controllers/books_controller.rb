class BooksController < ApplicationController
  before_action :authenticate_user!


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      redirect_to books_path, flash: { count: @book.errors.count, messages: @book.errors.full_messages }
    end
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @users = User.all
    @user = User.find(current_user.id)
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def edit
     @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      redirect_to book_path(@book), flash: {
        count: @book.errors.count,
        messages: @book.errors.full_messages,
        input_title: book_params[:title],
        input_body: book_params[:body],
      }
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end