class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string     :name,                null: false  # 商品名
      t.text       :description,         null: false  # 商品説明
      t.integer    :category_id,         null: false  # カテゴリー（ActiveHashを使用）
      t.integer    :condition_id,        null: false  # 商品の状態（ActiveHashを使用）
      t.integer    :shipping_charge_id,  null: false  # 配送料の負担（ActiveHashを使用）
      t.integer    :prefecture_id,       null: false  # 発送元地域（ActiveHashを使用）
      t.integer    :shipping_day_id,     null: false  # 発送までの日数（ActiveHashを使用）
      t.integer    :price,               null: false  # 価格
      t.references :user,                null: false, foreign_key: true # ユーザーとの紐付け

      t.timestamps
    end
  end
end
