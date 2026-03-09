FactoryBot.define do
  factory :purchase_form do
    postal_code   { '123-4567' }
    prefecture_id { 1 }
    city          { Faker::Address.city }
    addresses     { Faker::Address.street_address }
    building      { Faker::Address.secondary_address }
    phone_number  { '09012345678' }
    user_id       { nil }
    item_id       { nil }
    token         { 'tok_abcdefghijk00000000000000000' }

    initialize_with do
      new(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        addresses: addresses,
        building: building,
        phone_number: phone_number,
        user_id: user_id,
        item_id: item_id,
        token: token
      )
    end
  end
end
