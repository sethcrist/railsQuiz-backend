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
      description: 'This is a test note.'
    )
    expect(note).to be_valid
  end
end