class Message < ApplicationRecord

  attr_accessor :recipient_email

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :sender, presence: true
  validates :recipient_email, presence: true
  validates :topic, presence: true
  validates :text, presence: true

  validate :check_if_emails_exist
  before_save :validate_recipient

  # Will paginate
  self.per_page = 10

  def check_if_emails_exist
    emails = recipient_email.split(',')
    emails.each do |email|
      if !User.exists?(email: email.strip)
        errors.add(:recipient_email, "User with email #{email} does not exist \n")
      end
    end

    return false if errors.any?
  end

  def validate_recipient
    errors.add(:recipient, "can't be blank") if recipient.nil?
  end

  def read!
    update_attribute(:is_read?, true)
  end
end
