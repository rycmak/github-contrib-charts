class AddGithubUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_username, :string, null: false, default: ""
    add_index :users, :github_username, unique: true
  end
end
