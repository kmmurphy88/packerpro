class Packlist < ActiveRecord::Base
  has_many :items
  attr_accessor :email
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  after_create :calculate_articles

  def calculate_articles
    packlist = { }
    basic_items = ["Wallet", "ID", "Cash", "House Keys", "Phone", "Phone Charger", "Toiletries"]
    basic_items.each do |item|
      packlist[item] = 1
    end

    clothing = ["Shirts", "Pants", "Shoes", "Pairs of Socks", "Underwear", "Pajamas"]
    clothing.each do |clothing|
      packlist[clothing] = 1 * self.how_long
    end

    cold_clothing = ["Jackets", "Coats", "Sweaters", "Thermals", "Boots", "Beanies"]
      if self.weather.split(",").include? "Freezing"
        cold_clothing.each do |cold|
        packlist[cold] = 1 * self.how_long
        end
      end

    cool_clothing = ["Jackets", "Sweaters", "Beanies"]
      if self.weather.split(",").include? "Cool"
        cool_clothing.each do |cool|
          packlist[cool] = 1 * self.how_long
        end
      end

    warm_clothing = ["T-shirts", "Shorts", "Tennis Shoes", "Ankle Socks", "Hats", "Sunglasses"]
      if self.weather.split(",").include? "Warm"
        warm_clothing.each do |warm|
        packlist[warm] = 1 * self.how_long
        end
      end

    hot_clothing = ["T-shirts", "Shorts", "Tank Tops", "Sandals"]
      if self.weather.split(",").include? "Blazing"
        hot_clothing.each do |hot|
        packlist[hot] = 1 * self.how_long
        end
      end

      outdoor = ["Sunscreen", "Sunglasses", "Hats"]
      indoor = ["Lounge Clothes"]
      if self.activities == "Outdoor Activities"
        outdoor.each do |outdoor|
          packlist[outdoor] = 1 * self.how_long
        end
      elsif self.activities == "Indoor Activities"
        indoor.each do |indoor|
          packlist[indoor] = 1 * self.how_long
        end
      end

    packlist.each do |key, value|
      self.items.create(article: key, quantity: value)
    end

  end
end
