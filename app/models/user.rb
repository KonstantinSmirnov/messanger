class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_many :drafts

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes["crypted_password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["crypted_password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["crypted_password"] }
  validates :email, uniqueness: true, presence: true, if: -> { new_record? || changes["crypted_password"] }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :allow_blank => true
  validates :name, presence: true

end
