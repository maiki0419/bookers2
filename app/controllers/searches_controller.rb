class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

  def categorysearch
    @word = params[:word]
    @category_book_id = Category.where(name: @word)
  
  end
end
