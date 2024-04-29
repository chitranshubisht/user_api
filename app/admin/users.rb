ActiveAdmin.register User do
  permit_params :name, :email

  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  filter :name
  filter :email

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
    end
    f.actions
  end

  controller do
    def create
      user = User.new(permitted_params[:user])

      if user.save(validate: false)
        redirect_to admin_user_path(user), notice: 'User was successfully created.'
      else
        render :new
      end
    end
  end
end
