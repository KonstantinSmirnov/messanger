class Message < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :topic, presence: true
  validates :text, presence: true

end
