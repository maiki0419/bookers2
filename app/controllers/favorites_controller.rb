class FavoritesController < ApplicationController
before_action :book_params
  def create
    favorite = current_user.favorites.new(book_id: params[:book_id])
    favorite.save
    @book = Book.find(params[:book_id])
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: params[:book_id])
    favorite.destroy
  end

  private

  def book_params
    @book = Book.find(params[:book_id])
    @books = Book.all
  end

end
