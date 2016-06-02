class Story < ActiveRecord::Base
  acts_as_votable
	belongs_to :category
	belongs_to :user
	has_many :comments

	def self.scariest
		order(cached_votes_score: :desc).limit(5)
	end

	def self.random
		limit(5).order("RANDOM()")
	end

	def self.search(search)
  where("body LIKE ?", "%#{search}%")
  end

end