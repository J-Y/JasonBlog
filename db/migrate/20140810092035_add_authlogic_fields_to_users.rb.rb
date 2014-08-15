class AddAuthlogicFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove    :password
      t.remove    :last_logined_at
      t.string    :crypted_password,    :null => false , :default => ''               # optional, see below
      t.string    :password_salt,       :null => false , :default => ''               # optional, but highly recommended
      t.string    :persistence_token,   :null => false , :default => ''               # required
      t.string    :single_access_token, :null => false , :default => ''              # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false , :default => ''              # optional, see Authlogic::Session::Perishability
      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip
    end
  end
end
