require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_form = PurchaseForm.new(
      postal_code: '123-4567',
      prefecture_id: 1,
      city: '横浜市',
      addresses: '青山1-1-1',
      building: '柳ビル103',
      phone_number: '09012345678',
      user_id: @user.id,
      item_id: @item.id,
      token: 'tok_abcdefghijk00000000000000000'
    )
    sleep 0.1
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@purchase_form).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @purchase_form.building = ''
        expect(@purchase_form).to be_valid
      end

      it 'postal_codeが3桁ハイフン4桁なら購入できる' do
        @purchase_form.postal_code = '123-4567'
        expect(@purchase_form).to be_valid
      end

      it 'prefecture_idが0以外なら購入できる' do
        @purchase_form.prefecture_id = 1
        expect(@purchase_form).to be_valid
      end

      it 'cityが存在すれば購入できる' do
        @purchase_form.city = '渋谷区'
        expect(@purchase_form).to be_valid
      end

      it 'addressesが存在すれば購入できる' do
        @purchase_form.addresses = '神南1-1-1'
        expect(@purchase_form).to be_valid
      end

      it 'phone_numberが10桁でも購入できる' do
        @purchase_form.phone_number = '0312345678'
        expect(@purchase_form).to be_valid
      end

      it 'phone_numberが11桁でも購入できる' do
        @purchase_form.phone_number = '09012345678'
        expect(@purchase_form).to be_valid
      end

      it 'tokenが存在すれば購入できる' do
        @purchase_form.token = 'tok_abcdefghijk00000000000000000'
        expect(@purchase_form).to be_valid
      end

      it 'user_idが存在すれば購入できる' do
        @purchase_form.user_id = @user.id
        expect(@purchase_form).to be_valid
      end

      it 'item_idが存在すれば購入できる' do
        @purchase_form.item_id = @item.id
        expect(@purchase_form).to be_valid
      end
    end

    context '購入できない場合' do
      it 'tokenが空だと購入できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンがないと購入できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefecture_idが0だと購入できない' do
        @purchase_form.prefecture_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空だと購入できない' do
        @purchase_form.addresses = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと購入できない' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is too short')
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is too long')
      end

      it 'phone_numberにハイフンが含まれていると購入できない' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberに英字が含まれていると購入できない' do
        @purchase_form.phone_number = '0901234abcd'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'user_idが空だと購入できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと購入できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end