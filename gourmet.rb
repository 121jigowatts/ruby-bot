require 'http'
require 'json'

class Gourumet
  Shop = Struct.new(:name, :address, :url)
  def initialize

  end

  def search(keyword)
    # Powered by ホットペッパー Webサービス
    base_url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1"
    recomend = 4
    count = 3

    response = HTTP.get(base_url, params: {
      key: ENV['RECRUIT_API_TOKEN'],
      keyword: keyword,
      order: recomend,
      count: count,
      format: 'json'
      })

    data = JSON.parse(response.body, object_class: OpenStruct)

    shop_list = []
    data.results.shop.each do |a_shop|
      shop_list << Shop.new(a_shop.name, a_shop.address, a_shop.urls.pc)
    end

    shop_list
  end

end


