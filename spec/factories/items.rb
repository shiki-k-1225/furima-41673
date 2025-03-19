FactoryBot.define do
  factory :item do
    name { "サンプル商品" } 
    description { "これはテスト用の商品です。" }
    category_id { 1 }
    condition_id { 1 }
    shipping_charge_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    price { 500 }
    
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
