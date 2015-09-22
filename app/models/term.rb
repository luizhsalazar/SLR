class Term < ActiveRecord::Base

  belongs_to :protocol
  validates_presence_of :termo, :sinonimo, :traducao, :sinonimo2, :sinonimo3, :traducao2, :traducao3

end
