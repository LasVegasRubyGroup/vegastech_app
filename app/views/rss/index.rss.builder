xml.instruct!

xml.rss('version' => '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/', 'xmlns:atom' => 'http://www.w3.org/2005/Atom') do
  xml.channel do
    xml.title("#VegasTech Bulletin Board Reaching #{@count}")
    xml.description("#VegasTech Bulletin Board Reaching #{@count}")
    xml.link(root_url(host: 'news.lvrug.org'))

    @stories.each do |story|
      xml.item do
        xml.title(story.content)
        xml.description(story.content)
        xml.pubDate(story.created_at.to_s(:rfc822))
        xml.link(story_url(story))
        xml.guid(story_url(story))
      end
    end
  end
end
