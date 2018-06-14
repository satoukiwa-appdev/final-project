class CtaLocsController < ApplicationController
  def index
    @cta_locs = CtaLoc.all.reverse_order

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
  
  def download_csv
    require 'csv'
    @cta_loc = CtaLoc.all

    respond_to do |format|
      format.html
      format.csv do
          send_data @cta_loc.to_csv
      end
    end
  end
  
  def sender
    SampleMailer.send_when_update.deliver
    redirect_to("/index", :notice => "Email Sent")
  end
  
  def sender_clear
    SampleMailer.send_when_update.deliver
    CtaLoc.destroy_all
    redirect_to("/index.html", :notice => "Email Sent")
  end
  
  def viewer
    @cta_locs = CtaLoc.all
    @stops = StopDatum.all
    @coords = Coord_Lib.get_coord(1)
    
    
    # extract first data (for testing)
    
    @rn = @coords.keys
    @plot_d = @coords.dig(@rn[0])
    
    
    
    
    # temp_tmst = @coords.dig(@rn[0], "tmst")
    # temp_loc = @coords.dig(@rn[0], "abs_loc")
      
    #   @plot_d = Array.new
    # for i in 0..(temp_tmst.size-1) do
      
    #   time_dat = temp_tmst[i].to_time
    #   time_dat = time_dat.strftime("%H:%M:%S")
    #   @plot_d.push([time_dat, temp_loc[i]]) 
    # end
    
    
    # raise
    
    
    
    
    render("cta_loc_templates/viewer.html.erb")
    
  end
  
  
end
