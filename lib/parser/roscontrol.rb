require 'nokogiri'
require 'open-uri'
require ::File.expand_path('../../../config/environment', __FILE__)
I18n.locale = :ru


class RoscontrolParser

  def init
    site_url = "http://roscontrol.com/category/produkti/"
    page = Nokogiri::HTML(open(site_url))
    parse_categories(page, false)
  end

  def parse_categories(page, parent_category_id)
    categories = page.css ".b_companies_sections-content .item"
    categories.each do |cat|
      category_photo = cat.css("img").first['src']
      category_name = cat.css("h4").text.gsub(/\n/, "").gsub(/\s{2,}/) {}
      category_url = cat.css("h4 a").first['href']
      category_path = I18n.transliterate(category_name)
      category_path = category_path.gsub(/\s/, '-')

      category = category_save(category_name, category_photo, category_path, parent_category_id)

      if parent_category_id
        parse_product(category_url, category)
      else
        children_categories(category_url, category)
      end
    end
  end

  def children_categories(url, parent_category)
    site_url = "http://roscontrol.com"
    page = Nokogiri::HTML(open(site_url + url))
    parse_categories(page, parent_category.id)
  end

  def category_save(category_name, category_photo, category_path, parent)
    category = Category.find_by_name(category_name)
    if category.blank?
      category = Category.create(name: category_name, path: category_path, parent_id: parent)
      category.photos.create(remote_photo_url: category_photo, name: category_name)
    else
      category.update(name: category_name, path: category_path)
    end
    return category
  end


  def parse_product(url, category)
    site_url = "http://roscontrol.com"
    products = Nokogiri::HTML(open(site_url + url)).css(".b_section_tested .item")
    products.each do |product|
      product_url = product.css(".name .h3 a")
      if product_url.length > 0
        product_url = product_url.first['href']
        parse_product_page(product_url, category)
      end
    end
  end

  def parse_product_page(product_url, category)
    site_url = "http://roscontrol.com"
    page = Nokogiri::HTML(open(site_url + product_url)).css(".content_right")
    product_name = page.css(".page_tests-title h1").text
    product_rate = page.css(".testlab_product_page_rating .row_1 div").text.gsub(/\n/, "").gsub(/\s{2,}/) {}
    product_image = page.css(".top_product_area_inner .l_item_main_photos li a").first['href']
    product_property = page.css(".top_product_area_inner .right_side .features .content ul")
    product_test = page.css(".product_test .teaser div:last-child").text
    puts product_name
    puts product_rate
    puts product_image
    puts product_property
    puts product_test
  end

end

@catalog = RoscontrolParser.new
@catalog.init