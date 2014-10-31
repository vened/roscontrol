# rake db:drop db:create db:migrate db:seed
# require 'parser/parser'
I18n.locale = :ru


@manager = Manager.create(name: "admin", email: "maxstbn@gmail.com", password: "nfnkfrf", password_confirmation: "nfnkfrf")


# Page.create(
#     name: "О компании",
#     path: "o-kompanii",
#     body: '<p>Компания " Santemax ", основанная в России в 2004 году, занимает одно из ведущих мест на российском рынке отделочных материалов, 
#                                                                                                                                    мебели и предметов интерьера. Мы предлагаем только высококачественную и эксклюзивную продукцию (керамическую плитку, керамогранит, мозаику, декоративное панно, мебель и интерьерное освещение), необходимую для ремонта и отделки любых помещений.</p>
# <p>В основе нашей работы лежит индивидуальный подход к каждому клиенту. Вы по достоинству оцените профессионализм и мобильность наших сотрудников. Квалифицированный персонал подберет для Вас удобную схему сотрудничества. Все это позволяет рассматривать компанию " Santemax " как надежного стратегического партнера в сфере поставок керамогранита и других материалов.</p>
# <p>Компания " Santemax " расширяет дилерскую сеть, используя гибкую ценовую политику, обеспечивая достойный сервис. Мы представляем Вам широкий ассортимент эксклюзивных изделий из керамики. Керамогранит, керамическую плитку, мозаику, декоры, панно в наличии со склада в Москве.</p>
# <p>Компания " Santemax " осуществляет прямые поставки керамогранита из Китая, Португалии, Испании, Италии и Польши. Особые условия дилерам, строителям и дизайнерам. Складские запасы керамогранита постоянно пополняются.</p>
# <p>Ассортимент наших салонов составляет продукция крупнейших производителей, ориентированных на уникальный дизайн и качество.<br> " Santemax " уделяет особое внимание проектировке и оформлению своих выставочных залов, чтобы как можно шире раскрыть возможности современной индустрии керамической плитки.</p>
# <p>Наглядность предлагаемых коллекций достигается за счет большого размера демонстрационной панели - до 15 кв. м. Специально подобранное освещение наиболее естественно передает цвет и фактуру плитки. Мы стремимся создать максимально комфортную атмосферу для наших клиентов.</p>
# <p>Компания " Santemax " продает отделочные материалы оптом и в розницу. Наличие широкого ассортимента товаров позволяет нашим клиентам экономить свое время. Компания также осуществляет доставку грузов автотранспортом и железнодорожными вагонами, по Москве и всем городам России.</p>
# <p>Компания " Santemax " успешно сотрудничает с ведущими зарубежными производителями. Имея хорошо налаженную сеть продаж, компания заинтересована в дальнейшем расширении спектра предлагаемых товаров, что позволит укрепить сотрудничество между нашими клиентами и партнерами.</p>
# '
# )
# 
# Page.create(
#     name: "Дизайнерам и архитекторам",
#     path: "dizajneram-i-arxitektoram",
#     body: "Дизайнерам и архитекторам",
#     feedback: 0,
#     menu: 0
# )
# 
# Page.create(
#     name: "Главная",
#     path: "root",
#     body: "",
#     feedback: 0
# )
# 
# Page.create(
#     name: "Доставка грузов из Китая",
#     path: "dostavka-gruzov-iz-kitaya",
#     body: "Доставка грузов из Китая",
#     feedback: 0,
#     menu: 0
# )
# 
# Page.create(
#     name: "Сеть салонов",
#     path: "set-salonov",
#     body: "Сеть салонов.",
#     feedback: 0
# )
# 
# Page.create(
#     name: "РАСПРОДАЖА",
#     path: "rasprodazha",
#     body: "",
#     feedback: 0
# )
# 
# Page.create(
#     name: "Услуги",
#     path: "uslugi",
#     body: "",
#     feedback: 0
# )
# 
# @slider = Gallery.create(:name => "Слайдер в шапке", :slider => true)
# @slider_photo = Photo.create(photo: File.open(Rails.root.to_s + "/public/santemax/top.jpg"), name: "Богатый выбор для вашего интерьера")
# @slider.photos << @slider_photo
# 
# 
# 
# @catalog = [
#     # Плитка
#     {name: "Плитка", parent_name: nil, href: "http://santemax.ru/plitka/", photo: "http://www.santemax.ru/assets/templates/img/tile.jpg"},
#     {name: "Настенная плитка", parent_name: "Плитка", href: "http://santemax.ru/plitka/nastennaya-plitka/"},
#     {name: "Напольная плитка", parent_name: "Плитка", href: "http://santemax.ru/plitka/napolnaya-plitka/"},
#     {name: "Бордюры", parent_name: "Плитка", href: "http://santemax.ru/plitka/borduri"},
#     {name: "Ступени", parent_name: "Плитка", href: "http://santemax.ru/plitka/stupeni"},
#     # Мозаика
#     {name: "Мозаика", parent_name: nil, href: "http://santemax.ru/mozaika/", photo: "http://www.santemax.ru/assets/templates/img/mosaic.jpg"},
#     {name: "Стразы", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/strazyi/"},
#     {name: "Керамика", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/keramika/"},
#     {name: "Натуральный камень", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/naturalnyij-kamen/"},
#     {name: "Металл", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/metall/"},
#     {name: "Зеркальная", parent_name: "Мозаика", href: "http://santemax.ru/mozaika/zerkalnaya/"},
#     # Пано
#     {name: "Панно", parent_name: nil, href: "http://santemax.ru/panno/", photo: "http://www.santemax.ru/assets/templates/img/panel.jpg", parse: false},
#     {name: "Круглое панно", parent_name: "Панно", href: "http://santemax.ru/panno/krugloe-panno/", parse: true},
#     {name: "Квадратное панно", parent_name: "Панно", href: "http://santemax.ru/panno/kvadratnoe-panno/", parse: true},
#     {name: "Простые панно", parent_name: "Панно", href: "http://santemax.ru/panno/prostyie-panno/", parse: true},
#     {name: "Сложные панно", parent_name: "Панно", href: "http://santemax.ru/panno/slozhnyie-panno/", parse: true},
#     {name: "Декоры", parent_name: "Панно", href: "http://santemax.ru/panno/dekoryi/", parse: true},
#     {name: "Фоны", parent_name: "Панно", href: "http://santemax.ru/panno/fonyi/", parse: true},
#     # Мебель
#     {name: "Мебель", parent_name: nil, href: "http://santemax.ru/mebel/", photo: "http://www.santemax.ru/assets/templates/img/furniture.jpg"},
#     {name: "Мягкая мебель", parent_name: "Мебель", href: "http://santemax.ru/mebel/myagkaya-mebel"},
#     {name: "Спальня", parent_name: "Мебель", href: "http://santemax.ru/mebel/spalnya"},
#     {name: "Гостиная", parent_name: "Мебель", href: "http://santemax.ru/mebel/gostinaya"},
#     {name: "Декор", parent_name: "Мебель", href: "http://santemax.ru/mebel/dekor"},
#     {name: "Аксессуары", parent_name: "Мебель", href: "http://santemax.ru/mebel/aksessuaryi"},
#     # свет
#     {name: "Свет", parent_name: nil, href: "http://santemax.ru/svet/", photo: "http://www.santemax.ru/assets/templates/img/light.jpg", parse: true}
# ]
# 
# @catalog.each do |item|
#   path = I18n.transliterate(item[:name])
#   path = path.gsub(/\s/, '-')
#   parent = item[:parent_name]
#   if parent != nil
#     @parent = Category.find_by_name(parent)
#     @category = Category.create(name: item[:name], path: path.downcase, parent_id: @parent.id)
#   else
#     @category = Category.create(name: item[:name], path: path.downcase)
#   end
#   @photo = Photo.create(remote_photo_url: item[:photo])
#   @photo.categories << @category
# end