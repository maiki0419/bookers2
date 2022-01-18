class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comment.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    @book_comments = @book.book_comments

  end

  def destroy
    BookComment.find_by(id: params[:id]).destroy
    @book = Book.find(params[:book_id])
    @book_comments = @book.book_comments

  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
