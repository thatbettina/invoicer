Invoicer::Application.routes.draw do

  # Invoices
  get "/invoices/print/:id" => "invoices#print", as: "print_invoice"
  post "/invoices/clone" => "invoices#create", as: "clone_invoice"
  # Jobs
  get "/jobs/:invoice_id/new" => "jobs#new", as: "new_invoice_job"
  post "/jobs/clone" => "jobs#create", as: "clone_job"

  resources :companies
  resources :invoices
  resources :jobs

  # Root
  root "application#home"

end
