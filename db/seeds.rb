User.create!(
	email: "jiro@jiro.com",
	name: "jiro",
	password: "password",
	password_confirmation: "password"
	)

BookCategory.create!(
	category: "小説"
)

BookCategory.create!(
	category: "漫画"
)

BookCategory.create!(
	category: "ビジネス書"
)

MovieCategory.create!(
	category: "映画"
)

MovieCategory.create!(
	category: "アニメ"
)

MovieCategory.create!(
	category: "ドラマ"
)
