require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:user) { User.create(
    email: "test@example.com",
    password: "password",
    password_confirmation: "password"
  )}

  describe 'GET #index' do
    it 'returns a list of notes and http success' do
      note = user.notes.create(
        title: 'Test title',
        definition: 'Test definition',
      )
      get notes_path
      expect(response).to have_http_status(200)
      expect(note).to be_valid
    end
  end

  describe 'POST #create' do
    it 'creates a new note with http success' do
      post notes_path, params: {
        note: {
          title: 'Test title',
          definition: 'Test definition',
          user_id: user.id
        }
      }
      note = Note.where(title: 'Test title').first
      expect(response).to have_http_status(200)
      expect(note).to be_valid
    end

    it 'creates an invalid note' do
      post notes_path, params: {
        note: {
          title: nil,
          definition: nil,
          user_id: nil
        }
      }
      note = Note.where(title: nil).first
      expect(response).to have_http_status(422)
      expect(note).to eq(nil)
    end
  end

  describe 'PATCH #update' do
    it 'updates a note with http success' do
      post notes_path, params: {
        note: {
          title: 'Test title 1',
          definition: 'Test definition 1',
          user_id: user.id
        }
      }
      note = Note.where(title: 'Test title 1').first
      patch note_path(note), params: {
        note: {
          title: 'Test title for patch',
          definition: 'Test definition for patch',
          user_id: user.id
        }
      }
      note = Note.where(title: 'Test title for patch').first
      expect(note.title).to eq('Test title for patch')
      expect(note.definition).to eq('Test definition for patch')
      expect(response).to have_http_status(200)
    end

    it 'returns an http error for being invalid' do
      post notes_path, params: {
        note: {
          title: 'Test title for patch',
          definition: 'Test definition for patch',
          user_id: user.id
        }
      }

      note = Note.where(title: 'Test title for patch').first
      expect(note).not_to be_nil

      patch note_path(note.id), params: {
        note: {
          title: nil,
          definition: nil,
          user_id: user.id
        }
      }
      note = Note.where(title: nil).first
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a note' do
      note = Note.create(
        title: 'Test title for delete',
        definition: 'Test definition for delete',
        user_id: user.id
      )
      delete note_path(note)
      note = Note.where(title: 'Test title for delete').first
      expect(note).to eq(nil)
    end
  end
end
