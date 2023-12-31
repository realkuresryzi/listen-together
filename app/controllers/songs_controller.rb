class SongsController < ApplicationController
  skip_before_action :authenticate
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
    @songs = Song.order(upvotes: :desc)
  end

  # GET /songs/1 or /songs/1.json
  def show
    if params[:id] == "remove_all"
      remove_all
      return
    end
    @song = Song.find(params[:id])
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


    if Song.where('lower(title) = ? AND lower(artist) = ? AND dj = ?', @song.title.downcase, @song.artist.downcase, t.email).exists?
      redirect_to new_song_path, alert: "Song already played or is in the queue..."
      return
    end

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

  def remove_all
    current_user_email = session[:current_user_email]
    songs_to_be_deleted = Song.where(dj: current_user_email, played: true)
    songs_to_be_deleted.delete_all

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'All played songs were successfully removed.' }
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
      if params[:id] == "remove_all"
        remove_all
        return
      end
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :artist, :upvotes, :played)
    end
end
