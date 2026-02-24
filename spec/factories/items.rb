FactoryBot.define do
  factory :item do
    association :user

    name              { Faker::Commerce.product_name }
    description       { Faker::Lorem.sentence(word_count: 20) }
    category_id       { 1 }
    condition_id      { 1 }
    shipping_fee_id   { 1 }
    prefecture_id     { 1 }
    delivery_time_id  { 1 }
    price             { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |item|
      next if item.image.attached?

      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
