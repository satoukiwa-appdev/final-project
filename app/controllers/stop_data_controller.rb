class StopDataController < ApplicationController
  def index
    @stop_data = StopDatum.all

    render("stop_datum_templates/index.html.erb")
  end

  def show
    @stop_datum = StopDatum.find(params.fetch("id_to_display"))

    render("stop_datum_templates/show.html.erb")
  end

  # def new_form
  #   render("stop_datum_templates/new_form.html.erb")
  # end
  
  def new
    render("stop_datum_templates/new.html.erb")
  end
  
  def create
    registered_count = import_stops
    redirect_to stop_data_path, notice: "#{registered_count} items registered"
  end
  
  

  def create_row
    @stop_datum = StopDatum.new

    @stop_datum.station_name = params.fetch("station_name")
    @stop_datum.stop_name = params.fetch("stop_name")
    @stop_datum.long = params.fetch("long")
    @stop_datum.lat = params.fetch("lat")
    @stop_datum.stop_id = params.fetch("stop_id")
    @stop_datum.map_id = params.fetch("map_id")
    @stop_datum.direction_idt = params.fetch("direction_idt")
    @stop_datum.abs_km = params.fetch("abs_km")
    @stop_datum.trdr = params.fetch("trdr")

    if @stop_datum.valid?
      @stop_datum.save

      redirect_to("/stop_data", :notice => "Stop datum created successfully.")
    else
      render("stop_datum_templates/new_form.html.erb")
    end
  end

  def edit_form
    @stop_datum = StopDatum.find(params.fetch("prefill_with_id"))

    render("stop_datum_templates/edit_form.html.erb")
  end

  def update_row
    @stop_datum = StopDatum.find(params.fetch("id_to_modify"))

    @stop_datum.station_name = params.fetch("station_name")
    @stop_datum.stop_name = params.fetch("stop_name")
    @stop_datum.long = params.fetch("long")
    @stop_datum.lat = params.fetch("lat")
    @stop_datum.stop_id = params.fetch("stop_id")
    @stop_datum.map_id = params.fetch("map_id")
    @stop_datum.direction_idt = params.fetch("direction_idt")
    @stop_datum.abs_km = params.fetch("abs_km")
    @stop_datum.trdr = params.fetch("trdr")

    if @stop_datum.valid?
      @stop_datum.save

      redirect_to("/stop_data/#{@stop_datum.id}", :notice => "Stop datum updated successfully.")
    else
      render("stop_datum_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @stop_datum = StopDatum.find(params.fetch("id_to_remove"))

    @stop_datum.destroy

    redirect_to("/stop_data", :notice => "Stop datum deleted successfully.")
  end
  
    private

  def import_stops
      # 登録処理前のレコード数
      current_stop_count = ::StopDatum.count
      stops = []
      # windowsで作られたファイルに対応するので、encoding: "SJIS"を付けている
      CSV.foreach(params[:stp_file].path, headers: true, encoding: "SJIS") do |row|
        stops << ::StopDatum.new(
            { station_name: row["STATION_NAME"],
                stop_name: row["STOP_NAME"],
                long: row["lon"],
                lat: row["lat"],
                stop_id: row["STOP_ID"],
                map_id: row["MAP_ID"],
                direction_idt: row["DIRECTION_ID"],
                abs_km: row["abs_km"],
                trdr: row["trDr"]
            })
      end
      # importメソッドでバルクインサートできる
      ::StopDatum.import(stops)
      # 何レコード登録できたかを返す
      ::StopDatum.count - current_stop_count
  end
  
  
end
