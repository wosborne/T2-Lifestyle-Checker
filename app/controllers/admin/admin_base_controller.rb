class Admin::AdminBaseController < ApplicationController
  include Authentication

  skip_before_action :authenticate_patient_session
end