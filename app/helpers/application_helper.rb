module ApplicationHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields_and", :f => builder)
    end

    link_to(name, "#", "data-association" => "#{association}" , "data-content" => "#{fields}", :class => "link_to_add_fields" )
  end

end
