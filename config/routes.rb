Rails.application.routes.draw do

  

  
  # Routes for the Api response resource:

  # CREATE
  get("/api_responses/new", { :controller => "api_responses", :action => "new_form" })
  post("/create_api_response", { :controller => "api_responses", :action => "create_row" })

  # READ
  get("/api_responses", { :controller => "api_responses", :action => "index" })
  get("/api_responses/:id_to_display", { :controller => "api_responses", :action => "show" })

  # UPDATE
  get("/api_responses/:prefill_with_id/edit", { :controller => "api_responses", :action => "edit_form" })
  post("/update_api_response/:id_to_modify", { :controller => "api_responses", :action => "update_row" })

  # DELETE
  get("/delete_api_response/:id_to_remove", { :controller => "api_responses", :action => "destroy_row" })

  #------------------------------

  # Routes for the Stop datum resource:
  # CREATE
  get("/stop_data/new", { :controller => "stop_data", :action => "new" })
  post("/create_stop_datum", { :controller => "stop_data", :action => "create" })
  post("/create_stop_datum", { :controller => "stop_data", :action => "create_row" })

  # READ
  get("/stop_data", { :controller => "stop_data", :action => "index" })
  get("/stop_data/download", { :controller => "stop_data", :action => "download_csv" })
  get("/stop_data/:id_to_display", { :controller => "stop_data", :action => "show" })

  # UPDATE
  get("/stop_data/:prefill_with_id/edit", { :controller => "stop_data", :action => "edit_form" })
  post("/update_stop_datum/:id_to_modify", { :controller => "stop_data", :action => "update_row" })

  # DELETE
  get("/delete_stop_datum/:id_to_remove", { :controller => "stop_data", :action => "destroy_row" })

  #------------------------------

  # Routes for the Cta loc resource:

  # CREATE
  get("/cta_locs/new", { :controller => "cta_locs", :action => "new_form" })
  post("/create_cta_loc", { :controller => "cta_locs", :action => "create_row" })

  # READ
  get("/cta_locs", { :controller => "cta_locs", :action => "index" })
  get("/cta_locs/download", { :controller => "cta_locs", :action => "download_csv"})
  get("/cta_locs/view", { :controller => "cta_locs", :action => "viewer" })
  get("/cta_locs/send", { :controller => "cta_locs", :action => "sender" })
  get("/cta_locs/:id_to_display", { :controller => "cta_locs", :action => "show" })


  # UPDATE
  get("/cta_locs/:prefill_with_id/edit", { :controller => "cta_locs", :action => "edit_form" })
  post("/update_cta_loc/:id_to_modify", { :controller => "cta_locs", :action => "update_row" })

  # DELETE
  get("/delete_cta_loc/:id_to_remove", { :controller => "cta_locs", :action => "destroy_row" })

  #------------------------------

  get("/", { :controller => "task", :action => "index" })
  get("/index", { :controller => "task", :action => "index" })


  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
