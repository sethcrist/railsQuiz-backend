require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )}

  it 'is valid with valid attributes' do
    note = user.notes.create(
      title: 'Test',
      definition: 'This is a test note.'
    )
    expect(note).to be_valid
  end

  it 'is not valid without a title' do
    note = user.notes.create(
    definition: 'This is a test note.'
    )
    expect(note).not_to be_valid
    expect(note.errors[:title].first).to eq("can't be blank")
  end

  it 'is not valid without a definition' do
    note = user.notes.create(
    title: 'Test',
    )
    expect(note).not_to be_valid
    expect(note.errors[:definition].first).to eq("can't be blank")
  end
end