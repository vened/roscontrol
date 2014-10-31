require 'nokogiri'
require 'open-uri'
require ::File.expand_path('../../../config/environment', __FILE__)


# составление списка категорий каталога
class Catalog

  def set_products
    @categories = [
        # Плитка
        {name: "Плитка", parent_name: nil, href: "http://santemax.ru/plitka/", photo: "http://www.santemax.ru/assets/templates/img/tile.jpg", parse: false},
        {name: "Настенная плитка", parent_name: "Плитка", href: "http://santemax.ru/plitka/nastennaya-plitka/", parse: true},
        {name: "Напольная плитка", parent_name: "Плитка", href: "http://santemax.ru/plitka/napolnaya-plitka/", parse: true},
        {name: "Бордюры", parent_name: "Плитка", href: "http://santemax.ru/plitka/borduri", parse: true},
        {name: "Ступени", parent_name: "Плитка", href: "http://santemax.ru/plitka/stupeni", parse: true},
        # Мозаика
        {name: "Мозаика", parent_name: nil, href: "http://santemax.ru/mozaika/", photo: "http://www.santemax.ru/assets/templates/img/mosaic.jpg", parse: false},
        {name: "Стразы", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/strazyi/", parse: true},
        {name: "Керамика", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/keramika.html", parse: true},
        {name: "Натуральный камень", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/naturalnyij-kamen.html", parse: true},
        {name: "Металл", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/metall.html", parse: true},
        {name: "Зеркальная", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/zerkalnaya.html", parse: true},
        # Пано
        {name: "Панно", parent_name: nil, href: "http://santemax.ru/panno/", photo: "http://www.santemax.ru/assets/templates/img/panel.jpg", parse: false},
        {name: "Круглое панно", parent_name: "Панно", href: "http://santemax.ru/panno/krugloe-panno/", parse: true},
        {name: "Квадратное панно", parent_name: "Панно", href: "http://santemax.ru/panno/kvadratnoe-panno/", parse: true},
        {name: "Простые панно", parent_name: "Панно", href: "http://santemax.ru/panno/prostyie-panno/", parse: true},
        {name: "Сложные панно", parent_name: "Панно", href: "http://santemax.ru/panno/slozhnyie-panno/", parse: true},
        {name: "Декоры", parent_name: "Панно", href: "http://santemax.ru/panno/dekoryi/", parse: true},
        {name: "Фоны", parent_name: "Панно", href: "http://santemax.ru/panno/fonyi/", parse: true},
        # Мебель
        {name: "Мебель", parent_name: nil, href: "http://santemax.ru/mebel/", photo: "http://www.santemax.ru/assets/templates/img/furniture.jpg", parse: false},
        {name: "Мягкая мебель", parent_name: "Мебель", href: "http://santemax.ru/mebel/myagkaya-mebel", parse: true},
        {name: "Спальня", parent_name: "Мебель", href: "http://santemax.ru/mebel/spalnya", parse: true},
        {name: "Гостиная", parent_name: "Мебель", href: "http://santemax.ru/mebel/gostinaya", parse: true},
        {name: "Декор", parent_name: "Мебель", href: "http://santemax.ru/mebel/dekor", parse: true},
        {name: "Аксессуары", parent_name: "Мебель", href: "http://santemax.ru/mebel/aksessuaryi", parse: true},
        # свет
        {name: "Свет", parent_name: nil, href: "http://santemax.ru/svet/", photo: "http://www.santemax.ru/assets/templates/img/light.jpg", parse: false}
    ]


    @site_url = "http://www.santemax.ru/"
    @site_u = "http://www.santemax.ru"

    pagination = (1..10).to_a

    @categories.each do |category|
      p "category new - #{category[:name]}"
      if category[:parse] == true
        @category = Category.find_by_name(category[:name])
        pagination.each do |page|
          p "pagination new - #{page}"
          if page == 1
            cat = Nokogiri::HTML(open("#{category[:href]}"))
          else
            cat = Nokogiri::HTML(open("#{category[:href]}?page=#{page}"))
          end
          cat.css('.content_div .ms2_product > .tov > .span2').each do |product|
            link = product.css('a').first['href']
            if link != ""
              product_page = Nokogiri::HTML(open(@site_url + link)).css "main"
              parse_product(product_page, @category)
              p "--------------------------------------------------------------------------------------"
            end
          end
        end
      end
    end

  end

  def parse_product(product_page, category)
    product_name = product_page.search('h1').children.text
    p "parse product #{product_name}"
    product = Product.create(name: product_name, price: 0)
    category.products << product
    parse_product_images(product_page, product)
    parse_product_properties(product_page, product)
  end

  def parse_product_images(product_page, product)
    product_page.css(".thumbnails li").each do |li|
      photo = @site_u + li.css('a').first['href']
      p "parse_product_images #{photo}"
      photo_name = @site_u + li.css('img').first['title']
      @photo = Photo.create(remote_photo_url: photo, name: photo_name)
      @photo.products << product
    end
  end

  def parse_product_properties(product_page, product)
    product_page.css(".form-horizontal .control-group").each do |property|

      #property name
      property_name = property.css(".control-label").children.text
      property_name = property_name.gsub(/\:/, "")

      #property value
      if property.css(".controls select").blank?
        property_value = property.css(".controls .checkbox").children.text
      else
        property_value = property.css(".controls select option").first['value']
      end
      property_value = property_value.gsub(/\t+/, '').gsub(/\n+/, '').gsub(" руб.", "").gsub(" кг.", "").gsub("см", "")


      if property_name == "Артикул"
        product.update(:article => property_value)
      end


      if property_name == "Цена"
        property_value = property_value.gsub(/\s/, '').to_i
        product.update(:price => property_value)
      end


      if property_name == "Вес"
        set_property(property_name, property_value, product)
      end

      if property_name == "Размеры"
        set_property(property_name, property_value, product)
      end

      if property_name == "Производитель"
        set_property(property_name, property_value, product)
      end

      if property_name == "Страна"
        set_property(property_name, property_value, product)
      end

      if property_name == "Материал"
        set_property(property_name, property_value, product)
      end


    end
  end

  def set_property(property_name, property_value, product)

    @property = Property.find_by_name(property_name)
    if @property.blank?
      @property = Property.create(name: property_name)
      product.properties << @property
    else
      product.properties << @property
    end

    if property_value != ""
      @value = @property.values.find_by_value(property_value)
      if @value.blank?
        @value = @property.values.create(value: property_value)
        product.values << @value
      else
        product.values << @value
      end
      p "property - #{property_name}"
      p "value - #{property_value}"
    end

  end

end

# @catalog = Catalog.new
# @catalog.set_products