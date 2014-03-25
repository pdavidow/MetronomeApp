class PiecesController < ApplicationController
  include MetronomicExceptions

  before_filter :set_user

  def index
    @pieces = @user.pieces.all.sort{|a,b| a.to_s <=> b.to_s}
    gon.pieces_index = 'anything'
    respond_to do |format|
      format.html
      format.json { render json: @pieces }
    end
  end

  def show
    @piece = @user.pieces.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @piece }
    end
  end

  def new
    @piece = @user.pieces.new

    respond_to do |format|
      format.html
      format.json { render json: @piece }
    end
  end

  def edit
    @piece = @user.pieces.find(params[:id])
  end

  def create
    @piece = @user.pieces.new(params[:piece])

    respond_to do |format|
      if @piece.save
        format.html { redirect_to [@user, @piece], notice: 'Piece was successfully created.' }
        format.json { render json: @piece, status: :created, location: @piece }
      else
        format.html { render action: "new" }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @piece = @user.pieces.find(params[:id])

    respond_to do |format|
      if @piece.update_attributes(params[:piece])
        format.html { redirect_to [@user, @piece], notice: 'Piece was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    piece = @user.pieces.find(params[:id])
    piece.destroy

    respond_to do |format|
      format.html { redirect_to user_pieces_path(@user)}
      format.json { head :no_content }
    end
  end

  def metronome
    begin
      @piece = @user.pieces.find(params[:id])
      self.gon_audio_for_piece(@piece)
      gon.is_enable_metronome_start = true
    rescue MetronomeError => exception
      gon.is_enable_metronome_start = false
      logger.error(exception.message)
      flash[:alert] = 'ERROR: ' + exception.message_view
      respond_to do |format|
        format.html
        format.json { render json: @piece }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @piece }
      end
    end
  end

  def index_library
    set_library_vars()
  end

  def import_from_library
    piece = Piece.find(params[:id])
    @import = Library.import_piece_for_user(piece, @user)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_pieces_path(@user), notice: 'Library import was successful.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { set_library_vars(); render action: "index_library"}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private ####################################################################

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_library_vars
    @library_pieces = Library.archives
  end
end
