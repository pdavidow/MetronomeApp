class LogEntriesController < ApplicationController
  before_filter :set_vars

  def index
    respond_to do |format|
      format.html #
      format.json { render json: @log_entries }
    end
  end

  def new
    @log_entry = @log_entries.new

    respond_to do |format|
      format.html
      format.json { render json: @log_entry }
    end
  end

  def create
    @log_entry = @log_entries.new(params[:log_entry])

    respond_to do |format|
      if @log_entry.save
        format.html { redirect_to user_piece_log_entries_path(@user, @piece), notice: 'Log-Entry was successfully created.' }
        format.json { render json: @log_entry, status: :created, location: user_piece_log_entries_path(@user, @piece) }
      else
        format.html { render action: "new" }
        format.json { render json: @log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_settings
    output_settings_to_params()
    self.create
  end

  def show
    @log_entry = @log_entries.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @log_entry }
    end
  end

  def destroy
    @log_entry = @log_entries.find(params[:id])
    @log_entry.destroy

    respond_to do |format|
      format.html { redirect_to user_piece_log_entries_path(@user,@piece)}
      format.json { head :no_content }
    end
  end

  def destroy_all
    @log_entries.destroy_all

    respond_to do |format|
      format.html { redirect_to user_piece_log_entries_path(@user,@piece)}
      format.json { head :no_content }
    end
  end

  private

  def set_vars
    @user = User.find(params[:user_id])
    @piece = @user.pieces.find(params[:piece_id])
    @log_entries = @piece.log.entries
  end

  def output_settings_to_params
    params[:log_entry][:contents] += "\n\n" + @piece.metronome_setting.log_output
  end
end
