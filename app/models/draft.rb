class Draft < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  validate :any_present?

  # Will paginate
  self.per_page = 10

  def any_present?
    if recipient_email.blank? && topic.blank? && text.blank?
      errors.add :base, "At least one field should contain text"
    end
  end
end
