class User < ActiveRecord::Base
  has_many :trainings
end