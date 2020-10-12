class FolderSerializer < ActiveModel::Serializer
  attributes :id, :folder_name, :workouts
  # has_one :user
  has_many :workouts
end
