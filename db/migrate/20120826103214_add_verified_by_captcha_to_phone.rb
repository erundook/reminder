class AddVerifiedByCaptchaToPhone < ActiveRecord::Migration
  def change
    add_column :phones, :verified, :boolean, defualt: false
  end
end
