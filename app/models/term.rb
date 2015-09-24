class Term < ActiveRecord::Base

  belongs_to :protocol
  validates_presence_of :termo

end
