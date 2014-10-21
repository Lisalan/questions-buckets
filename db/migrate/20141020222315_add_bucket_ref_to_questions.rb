class AddBucketRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :bucket, index: true
  end
end
