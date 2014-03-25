class MetronomeSettingsController < ApplicationController

  before_filter :set_vars

  def edit_sole
    @metronome_setting.save # only want user to have option to update, so first save
    gon.is_use_entire = @metronome_setting.is_use_entire
    render action: 'edit'
  end

  def update
    respond_to do |format|
      if @metronome_setting.update_attributes_from_display(params[:metronome_setting])
        format.html { redirect_to metronome_user_piece_path(@user, @piece), notice: 'Metronome Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metronome_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private ####################################################################

  def set_vars
    @user = User.find(params[:user_id])
    @piece = @user.pieces.find(params[:piece_id])
    @metronome_setting = @piece.metronome_setting
  end
end
