# == Schema Information
#
# Table name: buckets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bucket < ActiveRecord::Base
  has_many :questions

  def self.search_bucket(query)
    unless query.nil?
      buckets = where(name: query)
    else    
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |bucket|
        csv << bucket.attributes.values_at(*column_names)
      end
    end
    
  end
end
