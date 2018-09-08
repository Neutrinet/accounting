class Admin::ImportsController < ApplicationController
  def new; end

  def create
    uploaded_io = params[:csv_file]
    File.open(Rails.root.join("tmp", "uploads", uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    render plain: "ok!"
  end
end
