class MeasuresController < ApplicationController
  before_filter :set_vars

  def index
    @measures = @piece.measures.all

    respond_to do |format|
      format.html
      format.json { render json: @measures }
    end
  end

  def destroy
    measure = @piece.measures.find(params[:id])
    measure.destroy

    respond_to do |format|
      format.html { redirect_to user_piece_measures_path(@user, @piece)}
      format.json { head :no_content }
    end
  end

  def add
    @measure = @piece.measures.new
    @measure.save

    respond_to do |format|
      format.html { redirect_to user_piece_measures_path(@user, @piece) }
      format.json { render json: @measure }
    end
  end

  private

  def set_vars
    @user = User.find(params[:user_id])
    @piece = @user.pieces.find(params[:piece_id])
  end
end
