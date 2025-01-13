class Admin::AgeRangesController < Admin::AdminBaseController
  def update
    age_ranges_params.each do |age_range_params|
      age_range = AgeRange.find(age_range_params[:id])
      age_range.update(age_range_params.permit(:min, :max))
    end

    @age_ranges = AgeRange.order(:min)

    respond_to do |format|
      format.html { redirect_to admin_settings_path, notice: "Age ranges updated successfully." }
      format.turbo_stream { flash.now[:notice] = "Age ranges updated successfully." }
    end
  end

  private

  def age_ranges_params
    params.require(:age_ranges)
  end
end