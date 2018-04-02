class Comment < ApplicationRecord
	belongs_to :blog, optional: true
	belongs_to :user
	has_many :comments, dependent: :destroy
end