class Included < ActiveRecord::Base
  belongs_to :protocol

  def self.to_csv(options = {})
    attributes = %w{title author pubtitle name_database}

    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |reference|
        csv << reference.attributes.values_at(*attributes)
      end
    end
  end

end
