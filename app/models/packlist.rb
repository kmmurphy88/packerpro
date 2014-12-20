class Packlist < ActiveRecord::Base
  has_many :items
  attr_accessor :email
  after_create :calculate_articles

  def calculate_articles
    packlist = { }
    basic_items = [:wallet, :id, :cash, :house_keys, :phone, :phone_charger, :toiletries]
    basic_items.each do |item|
      packlist[item] = 1
    end

    clothing = [:shirts, :pants, :shoes, :pairs_of_socks, :underwear, :pajamas]
    clothing.each do |clothing|
      packlist[clothing] = 1 * self.how_long
    end

    cold_clothing = [:jackets, :coats, :sweaters, :thermals, :boots, :beanies]
      if self.weather.split(",").include? "Freezing"
        cold_clothing.each do |cold|
        packlist[cold] = 1 * self.how_long
        end
      end

    cool_clothing = [:jackets, :sweaters, :beanies]
      if self.weather.split(",").include? "Cool"
        cool_clothing.each do |cool|
          packlist[cool] = 1 * self.how_long
        end
      end

    warm_clothing = [:tshirts, :shorts, :tennis_shoes, :ankle_socks, :hats, :sunglasses]
      if self.weather.split(",").include? "Warm"
        warm_clothing.each do |warm|
        packlist[warm] = 1 * self.how_long
        end
      end

    hot_clothing = [:tshirts, :shorts, :tank_tops, :sandals, :hats, :sunglasses]
      if self.weather.split(",").include? "Blazing"
        hot_clothing.each do |hot|
        packlist[hot] = 1 * self.how_long
        end
      end

    packlist.each do |key, value|
      self.items.create(article: key, quantity: value)
    end

  end
end
