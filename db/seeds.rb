User.create!([
	{
	email: "test@test.com",
	name: "test",
	password: "password",
	password_confirmation: "password"
	},
	{
	email: "test2@test2.com",
	name: "test2",
	password: "password",
	password_confirmation: "password"
	}
	])

BookCategory.create!([
	{ category: "小説" },
	{ category: "漫画" },
	{ category: "雑誌" },
	{ category: "ビジネス・自己啓発" },
	{ category: "参考書・技術書" }
	])

MovieCategory.create!([
	{ category: "映画" },
	{ category: "アニメ" },
	{ category: "ドラマ" }
	])

BookGenre.create!([
	{ genre: "ファンタジー" },
	{ genre: "SF" },
	{ genre: "文学" },
	{ genre: "エンタメ" },
	{ genre: "ミステリー" }
	])

MovieGenre.create!([
	{ genre: "アニメ" },
	{ genre: "恋愛" },
	{ genre: "ホラー" },
	{ genre: "スポーツ" },
	{ genre: "SF" }
	])
