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

30.times do |n|
	Book.create!(
		user_id: "1",
		category_id: "1",
		title: "タイトル#{n+1}",
		author: "作者#{n+1}",
		subject: "件名#{n+1}",
		body: "本文#{n+1}"
		)
end


30.times do |n|
	Movie.create!(
		user_id: "2",
		category_id: "6",
		title: "タイトル#{n+1}",
		author: "作者#{n+1}",
		subject: "件名#{n+1}",
		body: "本文#{n+1}"
		)
end