class Fixclumntype < ActiveRecord::Migration
  def change
    rename_column :questions, :type, :role
  end
end
