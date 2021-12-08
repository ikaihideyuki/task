# coding: utf-8

class UserBanksController < ApplicationController
 
  def index
    @form = SearchForm.new
  end

  def bank_params
    params.require(:user_banks).permit(:userid)
  end

  def bank

    # 入力値をチェック
    word = SearchForm.new(bank_params)
    if word.validate == false
      @err = word.errors.full_messages
      render "user_banks/index"
      return
    end

    bank_api = UserBank.new

    # 契約者情報を取得
    dir = "/users/#{params[:user_banks][:userid]}"
    respons = bank_api.connection(dir)

    if respons.nil?
      @err = ["存在しないid番号です。"]
      render "user_banks/index"
      return
    end

    @id = respons[:attributes][:id]
    @name = respons[:attributes][:name]

    # 契約口座情報を取得
    dir = "/users/#{params[:user_banks][:userid]}/accounts"
    respos = bank_api.connection(dir)

    # 口座情報一覧を配列に再生成
    list = []
    respos.each{|value|
      list.push(value[:attributes])
    }
    @bank_list = list  

  end

  def balance
    # 契約者残高を取得（今回は使用しない）
    dir = "/accounts/#{params[:userid]}"
    connection(dir)
  end
end
