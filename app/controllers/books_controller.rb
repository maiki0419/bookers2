class BooksController < ApplicationController
  before_action :correct_user,only: [:edit, :update]
  impressionist :actions=> [:show]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
    @user = @book.user
     @currentuserentry = Entry.where(user_id: current_user.id)
    @userentry = Entry.where(user_id: @user.id)
    impressionist(@book, nil, unique: [:session_hash.to_s])

    if @user.id != current_user.id

      @currentuserentry.each do |cu|
        @userentry.each do |u|

          if cu.room_id == u.room_id
            @isroom = true
            @roomid = cu.room_id
          end

        end
      end

      unless @isroom
        @room = Room.new
        @entry = Entry.new
      end

    end
  end

  def index
    @books = Book.created_1week.sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @book =Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

end
