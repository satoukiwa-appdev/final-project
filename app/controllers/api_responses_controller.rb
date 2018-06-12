class ApiResponsesController < ApplicationController
  def index
    @api_responses = ApiResponse.all

    render("api_response_templates/index.html.erb")
  end

  def show
    @api_response = ApiResponse.find(params.fetch("id_to_display"))

    render("api_response_templates/show.html.erb")
  end

  def new_form
    render("api_response_templates/new_form.html.erb")
  end

  def create_row
    @api_response = ApiResponse.new

    @api_response.payload = params.fetch("payload")

    if @api_response.valid?
      @api_response.save

      redirect_to("/api_responses", :notice => "Api response created successfully.")
    else
      render("api_response_templates/new_form.html.erb")
    end
  end

  def edit_form
    @api_response = ApiResponse.find(params.fetch("prefill_with_id"))

    render("api_response_templates/edit_form.html.erb")
  end

  def update_row
    @api_response = ApiResponse.find(params.fetch("id_to_modify"))

    @api_response.payload = params.fetch("payload")

    if @api_response.valid?
      @api_response.save

      redirect_to("/api_responses/#{@api_response.id}", :notice => "Api response updated successfully.")
    else
      render("api_response_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @api_response = ApiResponse.find(params.fetch("id_to_remove"))

    @api_response.destroy

    redirect_to("/api_responses", :notice => "Api response deleted successfully.")
  end
end
