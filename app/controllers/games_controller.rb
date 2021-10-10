class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  # Calling set_select for the enum of typecomp
  before_action :set_select

  # GET /games or /games.json
  def index
    @games = Game.all
    @game = Game.new
    @box = Box.new
    @rule = Rule.new
    @component = Component.new
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Selec for the enum of typescomp in the form
    def set_select
      @typecomps = Component.typecomps.keys.to_a
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:title, :description, :rule_id, :component_id, :box_id, rules_attributes: [:id, :name, :content, :document, :_destroy], components_attributes: [:id, :name, :typecomp, images: [], :_destroy], boxes_attributes: [:id, :content, :image, :_destroy])
    end
end
