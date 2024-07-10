class Note < ApplicationRecord
  belongs_to :user
  validates :title, :definition, presence: true
end
