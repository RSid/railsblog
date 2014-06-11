class Article < ActiveRecord::Base
  has_many :comments
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true
end
