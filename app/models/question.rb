class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, length: { minimum: 3, maximum: 150 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
end
