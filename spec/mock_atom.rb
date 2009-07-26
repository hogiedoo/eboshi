def mock_atom
  Atom::Feed.stub!(:load_feed).and_return do
    Atom::Feed.new do |f|
      f.title = "Example Feed"
      f.links << Atom::Link.new(:href => "http://example.org/")
      f.updated = Time.parse('2003-12-13T18:30:02Z')
      f.authors << Atom::Person.new(:name => 'John Doe')
      f.id = "urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6"
      f.entries << Atom::Entry.new do |e|
        e.title = "Atom-Powered Robots Run Amok"
        e.links << Atom::Link.new(:href => "http://example.org/2003/12/13/atom03")
        e.id = "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
        e.updated = Time.parse('2003-12-13T18:30:02Z')
        e.summary = "Some text."
      end
    end
  end
end
