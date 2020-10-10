class FolderSerializer < ActiveModel::Serializer
  attributes :id, :folder_name
  has_one :user
  has_many :workouts
end
