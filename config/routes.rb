Shadal::Application.routes.draw do
  root :to => 'admin/campuses#index'
  devise_for :admins
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :restaurants do
      resources :flyers
    end
    resources :restaurant_suggestions do
      resources :flyers
    end
  end

  ##### Application Controller #####
  #
  # Create campus with json
  post 'campus' => 'application#campus'

  # Return Committers with json
  get 'committers' => 'application#committers'

  # Return Popup Message with json
  get 'popup' => 'application#popup'
  #
  ##### Application Controller #####


  ##### Campus Controller #####
  #
  # Return campus
  get 'campus/:campus_id' => 'campuses#show'

  # Returns campuses meta data
  get 'campuses' => 'campuses#campuses'

  # Return restaurants in campus
  get 'campus/:campus_id/restaurants' => 'campuses#restaurants'

  # Returns restaurants' meta data in campus
  get 'campus/:campus_id/category/:category_id/restaurants' => 'campuses#restaurants_in_category'

  # Return Recommended Restaurants in campus
  get 'campus/:campus_id/recommended_restaurants' => 'campuses#recommended_restaurants'

  # New Campuses Reservation
  post 'campus_reservation' => 'campus_reservations#create'
  #
  ##### Campuses Controller #####


  ##### Restaurants Controller #####
  #
  # Returns restaurant
  get 'restaurant/:restaurant_id' => 'restaurants#show'

  # User Preference Good/Bad
  post 'restaurant/:restaurant_id/preference' => 'restaurants#preference'

  # New Restaurant Correction
  post 'restaurant/:restaurant_id/restaurant_correction' => 'restaurant_corrections#create'

  # New Restaurant Suggestion
  post 'restaurant_suggestion' => 'restaurant_suggestions#create'
  #
  ##### Restaurants Controller #####
  
  ##### CallLogs Controller #####
  #
  # New CallLog
  # 
  post 'call_logs' => 'call_logs#create'
  #
  ##### CallLogs Controller #####
  
  ##### Users Controller #####
  #
  # New User Request
  # 
  post 'user_request' => 'user_requests#create'
  #
  ##### Users Controller #####

  ##### Devices Controller #####
  #
  # Device
  post 'device' => 'devices#update'
  #
  ##### Devices Controller #####

  ##### Application Controller #####
  #
  # App Minimum Version
  get 'minimum_app_version' => 'application#minimum_app_version'
  #
  ##### Application Controller #####

  ##### Active admin #####
  #
  # Update Position for active admin
  get 'update_position'  => 'admin/menus#update_position'

  # Remove All Menus
  get 'remove_all_menus' => 'admin/menus#remove_all_menus'
  #
  ##### Active admin #####

  # DEPRECATED 'API for sync data on mobile app'
  get 'campuses_all' => 'campuses#campuses_all'
  match 'checkForUpdate' => 'restaurants#checkForUpdate', via: [:get, :post]
  match 'checkForResInCategory' => 'restaurants#checkForResInCategory', via: [:get, :post]
  match  'allRestaurants' => 'restaurants#allRestaurants', via: [:get, :post]
  post 'new_call' => 'call_logs#create_new'
  get 'updateDevice' => 'devices#update_device_deprecated'
  get 'appMinimumVersion' => 'application#minimum_app_version'
end
