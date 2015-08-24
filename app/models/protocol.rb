class Protocol < ActiveRecord::Base

  belongs_to :user
  has_many :terms, :dependent => :destroy
  has_many :references
  accepts_nested_attributes_for :terms, :allow_destroy => true
  validates_presence_of :title, :background, :research_question, :strategy, :terms, :from, :to, :quality

end
