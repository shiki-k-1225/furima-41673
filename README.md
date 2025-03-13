# README

## Tables

### Users

| Column     | Type    | Options                   |
|------------|---------|---------------------------|
| id         | integer | null: false, primary key  |
| name       | string  | null: false               |
| email      | string  | null: false, unique: true |
| password   | string  | null: false               |
| created_at | datetime| null: false               |

#### Association
- has_many :items
- has_many :purchases

---

### Items

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| id           | integer    | null: false, primary key       |
| name         | string     | null: false                    |
| price        | integer    | null: false                    |
| description  | text       |                                |
| user_id      | references | null: false, foreign_key: true |
| created_at   | datetime   | null: false                    |

#### Association
- belongs_to :user
- has_one :purchase

---

### Purchases

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| id         | integer    | null: false, primary key       |
| user_id    | references | null: false, foreign_key: true |
| item_id    | references | null: false, foreign_key: true |
| created_at | datetime   | null: false                    |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

---

### ShippingAddresses

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| id           | integer    | null: false, primary key       |
| purchase_id  | references | null: false, foreign_key: true |
| address      | string     | null: false                    |
| phone_number | string     | null: false                    |
| created_at   | datetime   | null: false                    |

#### Association
- belongs_to :purchase
