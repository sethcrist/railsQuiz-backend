class NotesController < ApplicationController
  def index
    notes = Note.all
    render json: notes
  end

  def create
    note = Note.create(note_params)
    if note.valid?
      render json: note
    else
      render json: note.errors, status: 422
    end
  end

  def update
    note = Note.find(params[:id])
    note.update(note_params)
    if note.valid?
      render json: note
    else
      render json: note.errors, status: 422
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
  end

  private
  def note_params
    params.require(:note).permit(:title, :definition, :user_id)
  end

end
