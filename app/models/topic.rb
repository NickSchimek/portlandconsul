class Topic < ActiveRecord::Base
  acts_as_paranoid column: :hidden_at
  include ActsAsParanoidAliases

  belongs_to :community
  belongs_to :author, -> { with_hidden }, class_name: 'User', foreign_key: 'author_id'

  has_many :comments, as: :commentable

  after_create :associate_comment

  private

  def associate_comment
    Comment.create(commentable: self, user: self.author, body: self.description_as_comment)
  end
end
