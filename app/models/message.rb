class Message < ApplicationRecord

  attr_accessor :recipient_email

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :sender, presence: true
  validates :recipient_email, presence: true
  validates :recipient, presence: true
  validates :topic, presence: true
  validates :text, presence: true

end
