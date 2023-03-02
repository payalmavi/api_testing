class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :post_id, :user_id, :updated_at, :created_at

  def created_at
    object.created_at.strftime("%Y-%m-%d ")
  end

  def updated_at
    object.created_at.strftime("%Y-%m-%d ")
  end
end
