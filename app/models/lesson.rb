class Lesson < ActiveRecord::Base
	has_many :users

	mount_uploader :video, VideoUploader
end
