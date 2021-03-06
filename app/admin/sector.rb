ActiveAdmin.register Sector do
  permit_params :name, :industry_id
  index do
    column :name
    column :updated_at
    column :industry
    column :emenus do |sector|
      links = sector.emenus.collect do |emenu|
        link_to emenu.name, admin_emenu_path(emenu)
      end
      links.join(', ').html_safe
    end
    default_actions
  end

  controller do
    def scoped_collection
      Sector.includes(:emenus)
    end
  end

  show do |sector|
    attributes_table do
      row :id
      row :industry
      row :name
      row :updated_at
      row :created_at
    end
    panel "Emenus" do
      table_for sector.emenus do
        column "emenu name" do |emenu|
          link_to emenu.name, admin_emenu_path(emenu)
        end
      end
    end
    active_admin_comments
  end


end
