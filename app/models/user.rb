class User < ApplicationRecord
  # Deviseモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :nickname, presence: true

  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, 
    message: 'には全角（漢字・ひらがな・カタカナ）を使用してください' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, 
    message: 'には全角（漢字・ひらがな・カタカナ）を使用してください' }

  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, 
    message: 'には全角（カタカナ）を使用してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, 
    message: 'には全角（カタカナ）を使用してください' }

  validates :birth_date, presence: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, 
    message: 'には半角英数字を混ぜて設定してください' }
end
