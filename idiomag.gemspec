# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{idiomag}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Rudenberg"]
  s.date = %q{2008-12-19}
  s.description = %q{wrapper for the idiomag api}
  s.email = %q{jon335@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["lib/idiomag/articles.rb", "lib/idiomag/artist.rb", "lib/idiomag/base.rb", "lib/idiomag/helpers.rb", "lib/idiomag/parser.rb", "lib/idiomag/recommendation.rb", "lib/idiomag/rest.rb", "lib/idiomag/tag.rb", "lib/idiomag/user.rb", "lib/idiomag.rb", "History", "LICENSE", "Rakefile", "README.rdoc", "VERSION.yml", "spec/articles_spec.rb", "spec/artist_spec.rb", "spec/base_spec.rb", "spec/fixtures", "spec/fixtures/articles_featured.json", "spec/fixtures/articles_latest.json", "spec/fixtures/artist_articles.json", "spec/fixtures/artist_info.json", "spec/fixtures/artist_photos.json", "spec/fixtures/artist_playlist.json", "spec/fixtures/artist_tags.json", "spec/fixtures/artist_videos.json", "spec/fixtures/recommendation_articles.json", "spec/fixtures/recommendation_artists.json", "spec/fixtures/tag_articles.json", "spec/fixtures/tag_artists.json", "spec/fixtures/tag_list.txt", "spec/fixtures/tag_photos.json", "spec/fixtures/tag_playlist.json", "spec/fixtures/tag_videos.json", "spec/fixtures/user_articles.json", "spec/fixtures/user_info.json", "spec/fixtures/user_lovedarticles.json", "spec/fixtures/user_photos.json", "spec/fixtures/user_playlist.json", "spec/fixtures/user_videos.json", "spec/recommendation_spec.rb", "spec/rest_spec.rb", "spec/spec_helper.rb", "spec/tag_spec.rb", "spec/user_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://idiomag.rubyforge.org}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "idiomag", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{idiomag}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{wrapper for the idiomag api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.2.2"])
    else
      s.add_dependency(%q<httparty>, [">= 0.2.2"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.2.2"])
  end
end
