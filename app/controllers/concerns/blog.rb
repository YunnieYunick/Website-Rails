module Blog
  def published_items
    @published_post = Post.with_translations(I18n.locale).order('published_at DESC').published
    @recent_posts = Post.with_translations(I18n.locale).most_recent.published
    @category_ids = @published_post.map{ |p| p.category_id }
    @categories = Category.where(id: @category_ids).order(['field(id, ?)' ,@category_ids])
    @tags = Tag.includes(:post).where("posts.published = ?" , true).distinct.references(:post)
    @archive_posts = @published_post.group_by do |p|
      p.published_at.strftime('%Y-%m')
    end
  end
end