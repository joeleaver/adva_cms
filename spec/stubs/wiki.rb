define Wiki do
  belongs_to :site

  has_many :wikipages,  [:find, :find_by_permalink, :find_or_initialize_by_permalink, :build, :create] => stub_wikipage, 
                         :paginate => stub_wikipages
                     
  has_many :categories, [:find, :build, :root] => stub_category, [:paginate, :roots] => stub_categories
        
  has_many :comments, :build => stub_comment
  has_many [:approved_comments, :unapproved_comments], stub_comments
  has_one  :comments_counter, stub_counter

  methods  :render_options => {},
           :template => 'template',
           :layout => 'layout',
           :content_filter => 'textile-filter',
           :accept_comments? => true,
           :valid? => true,
           :root_section? => true,
           :tag_counts => [],
           :has_attribute? => true

  instance :wiki,
           :id => 1,
           :type => 'Wiki', 
           :path => 'wiki',
           :title => 'wiki title'
  
  instance :wikis_wiki,
           :path => 'wikis/wiki'

end


