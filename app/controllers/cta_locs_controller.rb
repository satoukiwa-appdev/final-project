class CtaLocsController < ApplicationController
  def index
    @cta_locs = CtaLoc.all

    render("cta_loc_templates/index.html.erb")
  end

  def show
    @cta_loc = CtaLoc.find(params.fetch("id_to_display"))

    render("cta_loc_templates/show.html.erb")
  end

  def new_form
    render("cta_loc_templates/new_form.html.erb")
  end

  def create_row
    @cta_loc = CtaLoc.new

    @cta_loc.rn = params.fetch("rn")
    @cta_loc.tmst = params.fetch("tmst")
    @cta_loc.destst = params.fetch("destst")
    @cta_loc.destnm = params.fetch("destnm")
    @cta_loc.trdr = params.fetch("trdr")
    @cta_loc.nextstaid = params.fetch("nextstaid")
    @cta_loc.nextstpid = params.fetch("nextstpid")
    @cta_loc.nextstanm = params.fetch("nextstanm")
    @cta_loc.prdt = params.fetch("prdt")
    @cta_loc.arrt = params.fetch("arrt")
    @cta_loc.isapp = params.fetch("isapp")
    @cta_loc.isdly = params.fetch("isdly")
    @cta_loc.flags = params.fetch("flags")
    @cta_loc.lat = params.fetch("lat")
    @cta_loc.lon = params.fetch("lon")
    @cta_loc.heading = params.fetch("heading")

    if @cta_loc.valid?
      @cta_loc.save

      redirect_to("/cta_locs", :notice => "Cta loc created successfully.")
    else
      render("cta_loc_templates/new_form.html.erb")
    end
  end

  def edit_form
    @cta_loc = CtaLoc.find(params.fetch("prefill_with_id"))

    render("cta_loc_templates/edit_form.html.erb")
  end

  def update_row
    @cta_loc = CtaLoc.find(params.fetch("id_to_modify"))

    @cta_loc.rn = params.fetch("rn")
    @cta_loc.tmst = params.fetch("tmst")
    @cta_loc.destst = params.fetch("destst")
    @cta_loc.destnm = params.fetch("destnm")
    @cta_loc.trdr = params.fetch("trdr")
    @cta_loc.nextstaid = params.fetch("nextstaid")
    @cta_loc.nextstpid = params.fetch("nextstpid")
    @cta_loc.nextstanm = params.fetch("nextstanm")
    @cta_loc.prdt = params.fetch("prdt")
    @cta_loc.arrt = params.fetch("arrt")
    @cta_loc.isapp = params.fetch("isapp")
    @cta_loc.isdly = params.fetch("isdly")
    @cta_loc.flags = params.fetch("flags")
    @cta_loc.lat = params.fetch("lat")
    @cta_loc.lon = params.fetch("lon")
    @cta_loc.heading = params.fetch("heading")

    if @cta_loc.valid?
      @cta_loc.save

      redirect_to("/cta_locs/#{@cta_loc.id}", :notice => "Cta loc updated successfully.")
    else
      render("cta_loc_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @cta_loc = CtaLoc.find(params.fetch("id_to_remove"))

    @cta_loc.destroy

    redirect_to("/cta_locs", :notice => "Cta loc deleted successfully.")
  end
end
