class Article < ActiveRecord::Base
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true
end
