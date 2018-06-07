ActiveAdmin.register StopDatum do
  permit_params :station_name, :stop_name, :long, :lat, :stop_id, :map_id, :direction_idt, :abs_km, :trdr

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
