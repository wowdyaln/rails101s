class Post < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :group, counter_cache: :posts_count
  belongs_to :author, class_name: "User", foreign_key: :user_id

  delegate :title, to: :group, prefix: true
  delegate :name, to: :author, prefix: true

  scope :recent, -> { order("updated_at DESC") }

  def editable_by?(abc)
    abc == author
  end

end
