class SearchForm 
    include ActiveModel::Model
  
    attr_accessor :userid
    validates :userid,
        numericality: { message: 'は正の整数を入力してください。', greater_than: 0  },
        presence: { message: 'は１文字以上入力してください。' }
    def validate
        return false if invalid?
        true
    end
end