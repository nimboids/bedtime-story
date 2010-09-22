xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "Byte Night Bedtime Story"
    xml.description "Collaboratively-written bedtime story for Byte Night 2010"
    xml.link root_url

    @story_contributions.each do |contribution|
      xml.item do
        xml.title contribution.text
        xml.description ""
        xml.pubDate contribution.created_at.rfc822
        xml.tag! "dc:creator", contribution.name
      end
    end
  end
end
