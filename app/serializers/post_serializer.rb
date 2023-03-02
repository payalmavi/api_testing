class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id, :created_at, :comments
  def created_at
    object.created_at.strftime("%Y-%m-%d ")
  end

  def comments
    object.comments.each do|comment| 
      {
        id: comment.id,
        comment: comment.comment,
        user_id: comment.user_id,
        post_id: comment.post_id
      }
    end
  end
end
