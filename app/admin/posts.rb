ActiveAdmin.register Post do
  permit_params :title, :description, :user_id

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :user
    actions
  end

  filter :title
  filter :user

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :user
    end
    f.actions
  end
end
