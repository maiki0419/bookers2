class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments
  has_many :favorited_users ,through: :favorites, source: :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  is_impressionable


  #bookrecord7bscope :created_today, -> {where(created_at: Time.zone.now.all_day)}
  #bookrecord7bscope :created_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  #bookrecord7bscope :created_thisweek, -> {where(created_at: Date.today.prev_week(:saturday) .. Date.today-(Date.today.wday-5))}
  #bookrecord7bscope :created_lastweek, -> {where(created_at: Date.today-(Date.today.wday-6)-14 .. Date.today-(Date.today.wday-5)-7)}


  #bookrecord8bscope :created_today, -> {where(created_at: Time.zone.now.all_day)}
  #bookrecord8bscope :created_1day, -> {where(created_at: 1.day.ago.all_day)}
  #bookrecord8bscope :created_2day, -> {where(created_at: 2.day.ago.all_day)}
  #bookrecord8bscope :created_3day, -> {where(created_at: 3.day.ago.all_day)}
  #bookrecord8bscope :created_4day, -> {where(created_at: 4.day.ago.all_day)}
  #bookrecord8bscope :created_5day, -> {where(created_at: 5.day.ago.all_day)}
  #bookrecord8bscope :created_6day, -> {where(created_at: 6.day.ago.all_day)}

  scope :created_1week, -> {where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)}




  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "parfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backword_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

end