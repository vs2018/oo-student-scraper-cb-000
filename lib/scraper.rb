require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    result = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        hash = {}
        hash[:name] = student.css("div.card-text-container h4.student-name").text
        hash[:location] = student.css("div.card-text-container p.student-location").text
        hash[:profile_url] = student.attribute("href").value
        result << hash
      end
    end
    
    result
    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    doc.css()
    
    binding.pry
  end

end

Scraper.new.class.scrape_profile_page("./fixtures/student-site/students/adam-fraser.html")