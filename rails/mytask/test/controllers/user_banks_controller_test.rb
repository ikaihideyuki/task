require "test_helper"

class UserBanksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_banks_index_url
    assert_response :success
  end

  test "should get bank" do
    get user_banks_bank_url
    assert_response :success
  end

  test "should get balance" do
    get user_banks_balance_url
    assert_response :success
  end
end
