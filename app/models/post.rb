# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  description :string
#  photo       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
end
