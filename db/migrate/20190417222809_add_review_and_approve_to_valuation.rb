class AddReviewAndApproveToValuation < ActiveRecord::Migration[5.0]
  def change
    add_column :valuations, :review, :boolean
    add_column :valuations, :approve, :boolean
  end
end
