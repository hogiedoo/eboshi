def mock_atom
  FileUtils.cp "#{Rails.root}/db/blog_feed.atom.fixture", "#{Rails.root}/db/blog_feed.atom"
end
