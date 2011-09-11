ActiveAdmin.register Ticket do
  index do 
    column "Bill Number", :id
    column "Table" do |ticket|
      ticket.r_table.name 
    end
    column :date, :created_at
    column :discount
    column :total
    column :status
  end

  csv do
    column :id
    column("Table") do |ticket|
      ticket.r_table.name 
    end
    column :created_at
    column :discount
    column :total
    column :status
  end
end
