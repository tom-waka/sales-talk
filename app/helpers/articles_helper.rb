module ArticlesHelper
  require "uri"
 
  def text_url_to_link text
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    text
  end

  def selected_sort
    if params[:q].nil?
      params[:q] = {sorts: 'created_at desc'}
    else
      params[:q][:sorts]
    end
  end
end
