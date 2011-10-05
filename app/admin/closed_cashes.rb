ActiveAdmin.register ClosedCash do
  index do 
    column :from, :created_at
    column :to, :updated_at
    column :cash
    column :debt
    column :free
    column :total
  end
  
end
