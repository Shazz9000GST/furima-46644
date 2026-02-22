FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }

    # 全角名前（漢字・ひらがな・カタカナのみ）
    last_name do
      name = Faker::Name.last_name(locale: :ja) rescue nil
      name = "山田" if name.blank? || name !~ /\A[ぁ-んァ-ン一-龥]+\z/
      name
    end

    first_name do
      name = Faker::Name.first_name(locale: :ja) rescue nil
      name = "太郎" if name.blank? || name !~ /\A[ぁ-んァ-ン一-龥]+\z/
      name
    end

    # 全角カタカナのみ
    last_name_kana do
      kana = Faker::Name.last_name(locale: :ja) rescue nil
      kana = "ヤマダ" if kana.blank? || kana !~ /\A[ァ-ヶー－]+\z/
      kana
    end

    first_name_kana do
      kana = Faker::Name.first_name(locale: :ja) rescue nil
      kana = "タロウ" if kana.blank? || kana !~ /\A[ァ-ヶー－]+\z/
      kana
    end

    birth_date { Faker::Date.birthday }

    sequence(:email) { |n| Faker::Internet.unique.email(name: "user#{n}") }

    password { "abc12345" }
    password_confirmation { password }
  end
end