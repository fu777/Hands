# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

accessories = Category.create(name: "アクセサリー")
fashion = Category.create(name: "ファッション")
bag = Category.create(name: "バッグ/小物")
household_goods = Category.create(name: "生活雑貨")
stationary = Category.create(name: "文房具")
knit = Category.create(name: "ニット/編み物")
art = Category.create(name: "アート")
candle = Category.create(name: "アロマ/キャンドル")
material = Category.create(name: "素材/道具")
others = Category.create(name: "その他")

accessories_1 = accessories.children.create(name: "ピアス/イヤリング")
accessories_2 = accessories.children.create(name: "ネックレス")
accessories_3 = accessories.children.create(name: "ヘアアクセサリー")
accessories_4 = accessories.children.create(name: "その他")

fashion_1 = fashion.children.create(name: "シャツ")
fashion_2 = fashion.children.create(name: "スカート")
fashion_3 = fashion.children.create(name: "帽子")
fashion_4 = fashion.children.create(name: "その他")

bag_1 = bag.children.create(name: "バッグ")
bag_2 = bag.children.create(name: "ポーチ")
bag_3 = bag.children.create(name: "キーケース")
bag_4 = bag.children.create(name: "その他")

household_goods_1 = household_goods.children.create(name: "ランプ")
household_goods_2 = household_goods.children.create(name: "花瓶")
household_goods_3 = household_goods.children.create(name: "その他")

stationary_1 = stationary.children.create(name: "スタンプ")
stationary_2 = stationary.children.create(name: "マスキングテープ")
stationary_3 = stationary.children.create(name: "ブックカバー")
stationary_4 = stationary.children.create(name: "その他")

knit_1 = knit.children.create(name: "帽子/マフラー")
knit_2 = knit.children.create(name: "ぬいぐるみ")
knit_3 = knit.children.create(name: "その他")

art_1 = art.children.create(name: "絵画/イラスト")
art_2 = art.children.create(name: "その他")

candle_1 = candle.children.create(name: "アロマ")
candle_2 = candle.children.create(name: "キャンドル")

material_1 = material.children.create(name: "生地")
material_2 = material.children.create(name: "ボタン")
material_3 = material.children.create(name: "リボン/テープ")
material_4 = material.children.create(name: "道具")
material_5 = material.children.create(name: "その他")

Admin.create!(
  email: 'zz@zz',
  password: 'zzzzzz',
)
