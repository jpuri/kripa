class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :contact_person
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end