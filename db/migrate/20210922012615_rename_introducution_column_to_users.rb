class RenameIntroducutionColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :introducution, :introduction
  end
end
