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
    Springer.delete_all "protocol_id = #{protocol_id}"

    Included.delete_all "protocol_id = #{protocol_id}"

    Reference.delete_all "protocol_id = #{protocol_id}"

  end

  def generate_string(attributes)

    @termos = ''

    attributes.values.each_with_index do |term, index|

      sinonimo = term[:sinonimo] == "" ? '' : '" OR "' + term[:sinonimo]

      sinonimo2 = term[:sinonimo2] == "" ? '' : '" OR "' + term[:sinonimo2]

      traducao = term[:traducao] == "" ? '' : '" OR "' + term[:traducao]

      traducao2 = term[:traducao2] == "" ? '' : '" OR "' + term[:traducao2]

      traducao3 = term[:traducao3] == "" ? '' : '" OR "' + term[:traducao3]

      @termos += (index == attributes.size - 1) ?
          '("' + term[:termo] + traducao + sinonimo + sinonimo2 + traducao2 + traducao3 + '")' :
          '("' + term[:termo] + traducao + sinonimo + sinonimo2 + traducao2 + traducao3 + '")' + ' AND '
    end

    return @termos
  end

end
