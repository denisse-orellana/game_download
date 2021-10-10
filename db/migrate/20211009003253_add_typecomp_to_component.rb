class AddTypecompToComponent < ActiveRecord::Migration[5.2]
  def change
    add_column :components, :typecomp, :integer
  end
end
