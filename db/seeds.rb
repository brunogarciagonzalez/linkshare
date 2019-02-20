# Tag(id: integer, title: string)
TAG_search_engines = Tag.create(title: "Search Engines")
TAG_social_media = Tag.create(title:"Social Media")
TAG_finance = Tag.create(title: "Finance")
TAG_shopping = Tag.create(title: "Shopping")
TAG_software = Tag.create(title: "Software")
TAG_programming = Tag.create(title: "Programming")
TAG_video_games = Tag.create(title: "Video Games")
TAG_news = Tag.create(title: "News")
TAG_music = Tag.create(title: "Music")
TAG_sports = Tag.create(title: "Sports")
TAG_travel = Tag.create(title: "Travel")
TAG_autos = Tag.create(title: "Autos")
TAG_motorcycles = Tag.create(title: "Motorcycles")
TAG_outdoors = Tag.create(title: "Outdoors")
TAG_health_and_fitness = Tag.create(title: "Health & Fitness")
TAG_environment = Tag.create(title: "Environment")
TAG_college_and_university = Tag.create(title: "College & University")
TAG_ed = Tag.create(title: "Education: K - 12")
TAG_photography = Tag.create(title: "Photography")
TAG_history = Tag.create(title: "History")
TAG_lit = Tag.create(title: "Literature")
TAG_animals = Tag.create(title: "Animals")

# User(id: integer, username: string, password_digest: string, email: string)
User.create(username: "BGthaOG", password: "1&Password", email: "user1@gmail.com")
User.create(username: "MontanaMan007", password: "1&Password", email: "user2@gmail.com")
User.create(username: "thatuser245", password: "1&Password", email: "user3@gmail.com")
User.create(username: "Germanjii", password: "1&Password", email: "user4@gmail.com")
User.create(username: "ramonahill52", password: "1&Password", email: "user5@gmail.com")

# (:tags, :link_url, :review_information, :user_id)
# :review_information => {:content, :rating},

websites = ["google.com", "youtube.com", "facebook.com", "baidu.com", "wikipedia.org", "qq.com", "tmall.com", "yahoo.com", "taobao.com", "amazon.com", "twitter.com", "sohu.com", "jd.com", "live.com", "vk.com", "instagram.com", "weibo.com", "sina.com.cn", "yandex.ru", "360.cn" "reddit.com", "blogspot.com", "netflix.com", "linkedin.com", "twitch.tv", "yahoo.co.jp", "mail.ru", "google.co.in", "aliexpress.com", "t.co", "microsoftonline.com", "microsoft.com", "csdn.net", "alipay.com", "ebay.com", "naver.com", "google.com.hk", "bing.com", "tribunnews.com", "imdb.com", "github.com", "amazon.co.jp", "bilibili.com", "stackoverflow.com"]


def addUserSharesFor(url)
    rand(5..10).times do
        rev_info = {
            rating: rand(1..10),
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit nulla in tristique imperdiet. Mauris sodales venenatis massa, et fermentum orci efficitur at. Proin eu lobortis orci, id fringilla arcu. Cras eget magna risus. Cras pretium lacus laoreet sapien rutrum, eget lacinia erat posuere. In hac habitasse platea dictumst. Aliquam non fringilla sapien, cursus placerat quam. Praesent fermentum magna eu eros convallis venenatis eget ac diam. Duis iaculis fermentum quam, in porttitor ligula porta et. Pellentesque suscipit nibh eget nisi euismod, in tincidunt neque aliquam. Aenean vel efficitur odio. Vivamus sagittis libero a magna egestas iaculis."
        }

        UserShare.construct(tags: Tag.random_group_of_x(rand(1..3)), link_url: url, review_information: rev_info, user_id: rand(1..User.all.length))

    end
end

websites.each do |ws|
    addUserSharesFor(ws)
end

puts ">> seeding complete! ... <<"