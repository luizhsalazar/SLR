class Included < ActiveRecord::Base
  belongs_to :protocol

  def self.to_csv(options = {})
    attributes = %w{title author pubtitle name_database}
    header = %w{Título Autores Periódico/Conferência Database}

    CSV.generate(options) do |csv|
      csv << header
      all.each do |reference|
        csv << reference.attributes.values_at(*attributes)
      end
    end
  end

end
