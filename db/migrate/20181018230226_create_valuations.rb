class CreateValuations < ActiveRecord::Migration[5.0]
  def change
    create_table :valuations do |t|
      t.references :job_title, foreign_key: true
      t.references :position_type, foreign_key: true
      t.references :knowledge
      t.references :skill
      t.references :definition_supervision
      t.references :risk_decision
      t.references :sustainability
      t.references :area_impact
      t.references :influence
      t.integer :score
      t.references :degree, foreign_key: true

      t.timestamps
    end
    add_foreign_key :valuations, :criteria, column: :knowledge_id
    add_foreign_key :valuations, :criteria, column: :skill_id
    add_foreign_key :valuations, :criteria, column: :definition_supervision_id
    add_foreign_key :valuations, :criteria, column: :risk_decision_id
    add_foreign_key :valuations, :criteria, column: :sustainability_id
    add_foreign_key :valuations, :criteria, column: :area_impact_id
    add_foreign_key :valuations, :criteria, column: :influence_id
  end
end
