# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  role       :string(255)
#  bucket_id  :integer
#
# Indexes
#
#  index_questions_on_bucket_id  (bucket_id)
#

class Question < ActiveRecord::Base
  has_one :bucket
  

  # validates_uniqueness_of :content
  validates :content, presence: true, uniqueness: true

  before_create :add_default_role
  
  def self.for_id(id)
    where(id: id)
    
  end

  def self.unmatched
    where(role: 'unmatched')
  end



  def self.nonmatched
    where(role: 'nonmatched')
  end
  
  def add_default_role
    self.role = "unmatched" if self.role.blank?
  end

  


end
