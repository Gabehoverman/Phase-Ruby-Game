class QuestionAsset < ActiveRecord::Base
	belongs_to :question
	belongs_to :result

 	mount_uploader :image, ImageUploader
	# attr_accessible :title, :bytes, :image, :image_cache

	validates_presence_of :title, :image
end
