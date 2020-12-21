class AddGithubUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_username, :string, null: false, default: ""
  end
end
