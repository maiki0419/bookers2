class Group < ApplicationRecord
  has_one_attached :image_id
  has_many :group_users, dependent: :destroy

  validates :name,presence: true,uniqueness: true
  validates :introduction, length: {maximum: 140}



  def get_image_id(size)
    unless image_id.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image_id.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image_id.variant(resize: size).processed
  end
end


