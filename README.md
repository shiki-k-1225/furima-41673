# README

## Tables

### Users

| Column             | Type    | Options                   |
|--------------------|---------|---------------------------|
| name               | string  | null: false              |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false              |
| last_name          | string  | null: false              |
| first_name         | string  | null: false              |
| last_name_kana     | string  | null: false              |
| first_name_kana    | string  | null: false              |
| birth_date         | date    | null: false              |

#### Association
- has_many :items
- has_many :purchases

---

### Items

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                   |
| description      | text       | null: false                   |
| category_id      | integer    | null: false                   |
| item_status_id   | integer    | null: false                   |
| shipping_cost_id | integer    | null: false                   |
| prefecture_id    | integer    | null: false                   |
| shipping_date_id | integer    | null: false                   |
| price            | integer    | null: false                   |

#### Association
- belongs_to :user
- has_one :purchase

---

### Purchases

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_info

---

### ShippingInfos

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| postal_code     | string     | null: false                   |
| prefecture_id   | integer    | null: false                   |
| city            | string     | null: false                   |
| house_number    | string     | null: false                   |
| building        | string                                  |
| phone_number    | string     | null: false                   |
| purchase        | references | null: false, foreign_key: true |

#### Association
- belongs_to :purchase
