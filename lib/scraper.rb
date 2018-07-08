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
    
    result = {}
    
    doc.css("div.social-icon-container").each_with_index do |card, index|
      card.css("a").each_with_index do |student, index|
        if student.attribute("href").value.include?("twitter") 
        result[:twitter] = student.attribute("href").value 
        end
        if index == 1 
        result[:linkedin] = student.attribute("href").value 
        end
        if index == 2 
        result[:github] = student.attribute("href").value 
        end
        if index == 3
        result[:blog] = student.attribute("href").value
        end
        
      end
    end
    
    doc.css("div.vitals-text-container").each_with_index do |card, index|
      card.css("div.profile-quote").each_with_index do |student, index|
        result[:profile_quote] = student.text
      end
    end
    
    doc.css("div.description-holder").each_with_index do |card, index|
      card.css("p").each_with_index do |student, index|
        result[:bio] = student.text
      end
    end
    
    binding.pry
    result
  
  end

end

Scraper.new.class.scrape_profile_page("./fixtures/student-site/students/david-kim.html")