class SongsController < ApplicationController
  skip_before_action :authenticate
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
    @songs = Song.order(upvotes: :desc)
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)
    @song.upvotes = 0
    t = Token.find_by(code: session[:current_token])
    @song.dj = t.email

    respond_to do |format|
      if @song.save
        format.html { redirect_to songs_path, notice: "Song was successfully added..." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy!

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upvote
    @song = Song.find(params[:id])
    @song.increment!(:upvotes)

    Upvote.create(song_id: @song.id, token_code: session[:current_token])

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def downvote
    @song = Song.find(params[:id])
    @song.decrement!(:upvotes)

    Upvote.find_by(song_id: @song.id, token_code: session[:current_token]).destroy

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def played
    @song = Song.find(params[:id])
    @song.update(played: true)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :artist, :upvotes, :played)
    end
end
