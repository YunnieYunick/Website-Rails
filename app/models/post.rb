class Post < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tag, through: :taggings

  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true

  translates :title, :body

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :most_recent, -> { order(published_at: :desc).limit(3) }
  scope :published, -> { where(published: true) }

  def published(time)
    update(published: true, published_at: time )
  end

  def unpublished
    update(published: false, published_at: nil)
  end
  
  def display_day_published
    if published_at.present?
      "Published #{published_at.strftime('%-b %-d, %Y')}"
    else
      "Not yet"
    end
  end

  before_validation { image.clear if @delete_image }

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end
  
  def self.tag_counts
    Tag.select("tags.*,count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tag.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tag = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

end
