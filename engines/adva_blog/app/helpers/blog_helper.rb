module BlogHelper
  def blog_content_path(content, options = {})
    blog_article_path content.section, content.full_permalink.merge(options)
  end
  
  def articles_title(*args)
    options = args.extract_options!
    category, tags, month = *args
    month = archive_month(month) if month && !month.is_a?(Time)

    title = []
    title << t(:'adva.blog.titles.date', :date => l(month, :format => '%B %Y')) if month
    title << t(:'adva.blog.titles.about', :category => category.title) if category
    title << t(:'adva.blog.titles.tags', :tags => tags.to_sentence) if tags
    
    unless title.empty?
      title = t(:'adva.blog.titles.articles', :articles => title.join(', ')) 
      options[:format] ? options[:format] % title : title
    end
  end

  def archive_month(params = {})
    Time.local(params[:year], params[:month]) if params[:year]
  end
end