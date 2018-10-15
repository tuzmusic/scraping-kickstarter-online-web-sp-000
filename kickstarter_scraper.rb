require "nokogiri"
require "pry"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css('li.project.grid_4').each { |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      image_link: project.css('div.project-thumbnail a img').attribute('src').value,
      description: project.css('p.bbcard_blurb').text,
      location: project.css('ul.project-meta span.location-name').first.text,
      percent_funded: project.css('ul.project-stats li').first.css('strong').text.chomp('%').to_i,
    }
  }
  projects
  # for each project:
  # title: project.css('h2.bbcard_name strong a').text
  # image link: project.css('div.project-thumbnail a img').attribute('src').value
  # description: project.css('p.bbcard_blurb').text
  # location: project.css('ul.project-meta span.location-name').first.text
  # percent funded: project.css('ul.project-stats li').first.css('strong').text.chomp('%').to_i

end

create_project_hash
