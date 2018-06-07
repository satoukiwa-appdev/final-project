Rails.application.routes.draw do

  
  # Routes for the Stop datum resource:
  # CREATE
  get("/stop_data/new", { :controller => "stop_data", :action => "new" })
  post("/create_stop_datum", { :controller => "stop_data", :action => "create" })
  
  # get("/stop_data/new", { :controller => "stop_data", :action => "new_form" })
  # post("/create_stop_datum", { :controller => "stop_data", :action => "create_row" })

  # READ
  get("/stop_data", { :controller => "stop_data", :action => "index" })
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
  get("/cta_locs/:id_to_display", { :controller => "cta_locs", :action => "show" })

  # UPDATE
  get("/cta_locs/:prefill_with_id/edit", { :controller => "cta_locs", :action => "edit_form" })
  post("/update_cta_loc/:id_to_modify", { :controller => "cta_locs", :action => "update_row" })

  # DELETE
  get("/delete_cta_loc/:id_to_remove", { :controller => "cta_locs", :action => "destroy_row" })

  #------------------------------

    get("/", { :controller => "task", :action => "index" })

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
