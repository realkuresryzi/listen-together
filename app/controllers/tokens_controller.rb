class TokensController < ApplicationController
  before_action :set_token, only: %i[ show edit update destroy ]

  # GET /tokens or /tokens.json
  def index
    @tokens = Token.all
    @token = Token.new
  end

  # GET /tokens/1 or /tokens/1.json
  def show
  end

  # GET /tokens/new
  def new
    @token = Token.new
  end

  # GET /tokens/1/edit
  def edit
  end

  # POST /tokens or /tokens.json
  def create
    @token = Token.new(
      code: generate_random_code,
      used: false,
      user_id: Current.user.id,
      email: Current.user.email
    )

    respond_to do |format|
      if @token.save
        format.html { redirect_to tokens_path, notice: "Token was successfully created." }
        format.json { render :show, status: :created, location: @token }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tokens/1 or /tokens/1.json
  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to token_url(@token), notice: "Token was successfully updated." }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tokens/1 or /tokens/1.json
  def destroy
    @token.destroy!

    respond_to do |format|
      format.html { redirect_to tokens_url, notice: "Token was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:token).permit(:code)
    end

    def generate_random_code
      # Generate a random 6-character code
      SecureRandom.hex(3)
    end
end
