class Link < ApplicationRecord
  #### associations ####
  has_many :reviews
  has_many :user_shares
  has_many :link_tag_joins
  has_many :tags, through: :link_tag_joins
  has_many :user_shares

  #### validations ####
  validates :url, presence: true
  validate :valid_url?

  private
  def valid_url?
    uri = URI.parse(url)
    if !(uri.is_a?(URI::HTTP) && !uri.host.nil?)
      errors.add(:url, "invalid URL")
    end
    rescue URI::InvalidURIError
      false
  end
end

# done associations
# done validations
