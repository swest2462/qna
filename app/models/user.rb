class User < ActiveRecord::Base
  has_many :answer
  has_many :question
end
