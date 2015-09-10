class Protocol < ActiveRecord::Base

  belongs_to :user
  has_many :terms, :dependent => :destroy
  has_many :references
  accepts_nested_attributes_for :terms, :allow_destroy => true
  validates_presence_of :title, :background, :research_question, :strategy, :terms, :from, :to, :quality

  def clean_bases (protocol_id)

    # Clean all databases before doing other search

    Ieee.delete_all "protocol_id = #{protocol_id}"
    Scidir.delete_all "protocol_id = #{protocol_id}"
    Scopu.delete_all "protocol_id = #{protocol_id}"
    Acm.delete_all "protocol_id = #{protocol_id}"

    Reference.delete_all "protocol_id = #{protocol_id}"

  end

end
