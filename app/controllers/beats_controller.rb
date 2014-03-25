class BeatsController < ApplicationController
  before_filter :set_vars

  def index
    @beats = @measure.beats.all

    respond_to do |format|
      format.html
      format.json { render json: @beats }
    end
  end

  def new
    @beat = @measure.beats.new

    respond_to do |format|
      format.html
      format.json { render json: @beat }
    end
  end

  def edit
    @beat = @measure.beats.find(params[:id])
  end

  def create
    @beat = @measure.beats.new(params[:beat])

    respond_to do |format|
      if @beat.save
        format.html { redirect_to user_piece_measure_beats_path(@user, @piece, @measure), notice: 'Beat was successfully created.' }
        format.json { render json: @beat, status: :created, location: @beat }
      else
        format.html { render action: "new" }
        format.json { render json: @beat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @beat = @measure.beats.find(params[:id])

    respond_to do |format|
      if @beat.update_attributes(params[:beat])
        format.html { redirect_to user_piece_measure_beats_path(@user, @piece, @measure), notice: 'Beat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    beat = @measure.beats.find(params[:id])
    beat.destroy

    respond_to do |format|
      format.html { redirect_to user_piece_measure_beats_path(@user, @piece, @measure)}
      format.json { head :no_content }
    end
  end

  private

  def set_vars
    @user = User.find(params[:user_id])
    @piece = @user.pieces.find(params[:piece_id])
    @measure = @piece.measures.find(params[:measure_id])
  end
end
