require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it "is valid with factory" do
      expect(user).to be_valid
    end

    it "nickname is required" do
      user.nickname = nil
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to be_present
    end

    it "email is required" do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "email must be unique" do
      create(:user, email: "test@example.com")
      dup = build(:user, email: "test@example.com")

      expect(dup).not_to be_valid
      expect(dup.errors[:email]).to be_present
    end

    it "email must include @" do
      user.email = "invalid-email"
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "password is required" do
      user.password = nil
      user.password_confirmation = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it "password must be at least 6 characters" do
      user.password = "a1b2c" # 5 chars
      user.password_confirmation = "a1b2c"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it "password must be alphanumeric mix (letters + numbers)" do
      user.password = "aaaaaa"
      user.password_confirmation = "aaaaaa"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present

      user.password = "123456"
      user.password_confirmation = "123456"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it "password must match password_confirmation" do
      user.password_confirmation = "different123"
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to be_present
    end

    it "last_name and first_name are required" do
      user.last_name = nil
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to be_present

      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to be_present
    end

    it "names must be full-width (kanji/hiragana/katakana only)" do
      user.last_name = "Yamada"
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to be_present

      # 要件どおりだと本来これは invalid にしたい（全角のみ）
      user = build(:user, first_name: "太郎abc")
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to be_present
    end

    it "last_name_kana and first_name_kana are required" do
      user.last_name_kana = nil
      expect(user).not_to be_valid
      expect(user.errors[:last_name_kana]).to be_present

      user = build(:user, first_name_kana: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name_kana]).to be_present
    end

    it "kana names must be full-width katakana" do
      user.first_name_kana = "やまだ"
      expect(user).not_to be_valid
      expect(user.errors[:first_name_kana]).to be_present

      user = build(:user, last_name_kana: "ﾔﾏﾀﾞ") # 半角カナ
      expect(user).not_to be_valid
      expect(user.errors[:last_name_kana]).to be_present
    end

    it "birth_date is required" do
      user.birth_date = nil
      expect(user).not_to be_valid
      expect(user.errors[:birth_date]).to be_present
    end
  end
end