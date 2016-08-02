class Group < ActiveRecord::Base
  validates :title, presence: true

  has_many :posts
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  delegate :name, to: :owner, prefix: true

  has_many :group_users
  has_many :members, through: :group_users, source: :user


  def editable_by?(abc)
    abc == owner
  end

end
