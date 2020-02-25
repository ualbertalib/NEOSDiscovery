class CreateCirculationRules < ActiveRecord::Migration[5.2]
  def change
    create_table :circulation_rules do |t|
      t.string :short_code
      t.string :name

      t.timestamps null: false
    end

    # CirculationRule
    seed_file = Rails.root.join('db', 'migrate/202002', "#{CirculationRule.name.underscore}.yml")
    config = YAML.load_file(seed_file)
    config.each { |k, v| CirculationRule.where(short_code: k, name: v).first_or_create }
  end
end
