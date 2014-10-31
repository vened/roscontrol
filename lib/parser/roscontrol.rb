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
    p url
    site_url = "http://roscontrol.com"
    products = Nokogiri::HTML(open(site_url + url)).css(".b_section_tested")
    pagination = products.css(".b_pagination .row_1 .item:last-child")
    products = products.css(".item")
    products.each do |product|
      product_url = product.css(".name .h3 a")
      if product_url.length > 0
        product_url = product_url.first['href']
        parse_product_page(product_url, category)
      end
    end
    if pagination.length == 1
      paginate_url = pagination.first['href']
      if paginate_url != nil
        paginate_product(paginate_url, category)
      end
    end
  end

  def paginate_product(paginate_url, category)
    parse_product(paginate_url, category)
  end
  
  def parse_product_page(product_url, category)
    site_url = "http://roscontrol.com"
    page = Nokogiri::HTML(open(site_url + product_url)).css(".content_right")
    product_name = page.css(".page_tests-title h1").text
    product_rate = page.css(".testlab_product_page_rating .row_1 div").text.gsub(/\n/, "").gsub(/\s{2,}/) {}
    product_image = page.css(".top_product_area_inner .l_item_main_photos li a").first['href']
    product_property = page.css(".top_product_area_inner .right_side .features .content ul").to_html
    product_test = page.css(".product_test .teaser div:last-child").text
    
    product = Product.create(
        price: 0,
        name: product_name,
        rate: product_rate,
        property: product_property,
        test: product_test
    )
    if product_image.length == 1
      photo = Photo.create(remote_photo_url: product_image, name: product_name)
      photo.products << product
    end
    product.categories << category

    p "save!"
    p product_name
    p "--------------------------"
  end

end

@catalog = RoscontrolParser.new
@catalog.init