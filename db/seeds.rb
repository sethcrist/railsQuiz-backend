user1 = User.where(email: "test1@test.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@test.com").first_or_create(password: "password", password_confirmation: "password")

notes = [
  {
    title: "Note 1",
    definition: "definition 1",
  },
  {
    title: "Note 2",
    definition: "definition 2",
  },
  {
    title: "Note 3",
    definition: "definition 3",
  }
]

notes_two = [
  {
    title: "New Note 1",
    definition: "New Definition 1",
  },
  {
    title: "New Note 2",
    definition: "New Definition 2",
  }
]

notes.each do |note|
  user1.notes.create(note)
end

notes_two.each do |note|
  user2.notes.create(note)
end