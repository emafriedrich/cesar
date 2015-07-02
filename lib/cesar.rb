class Cesar
  
  def self.generate(report_path, options = {})
    raise ArgumentError, "I need the report_path" if report_path.nil? || report_path.empty?
    
    arguments = "-n #{wrap_with_double_quotes(report_path)} "
    arguments << string_options(options)
    p arguments
    system "java -jar ../utils/Reportes.jar #{arguments}"
  end

end

module Kernel

  DEFAULT_DATASOURCE        = :sql
  VALID_DATASOURCE_OPTIONS  = [:sql, :xml, :csv]
  DEFAULT_DATASOURCE_PATH   = " properties.properties "
  DEFAULT_EXPORT_PATH       = " pdf.pdf "
  DEFAULT_EXPORT_TO_OPTION  = " pdf "

  private 

  def string_options(options)
    return_string =  options[:export_to] ? options[:export_to].to_s : DEFAULT_EXPORT_TO_OPTION
    return_string << export_path(options[:export_path])
    return_string << datasource_path(options[:datasource_path])
    return_string << datasource(options[:datasource])
    
    if options[:print]
      return_string << " pred "
    end

    if options[:child_node]
      return_string << " -m #{options[:child_node]} "    
    end
    return_string
  end

  def export_path(export_path)
    return_string = ' -e '
    if export_path
      return_string << wrap_with_double_quotes(export_path)
    else
      return_string << DEFAULT_EXPORT_PATH
    end
  end

  def datasource_path(datasource_path)
    return_string = " -d "
    if datasource_path 
      return_string << wrap_with_double_quotes(datasource_path)
    else  
      return_string << DEFAULT_DATASOURCE_PATH
    end
  end

  def datasource(datasource)
    return DEFAULT_DATASOURCE.to_s if datasource.nil?
    if !VALID_DATASOURCE_OPTIONS.include? datasource
      raise ArgumentError, "Datasource option #{datasource} is invalid. Use"
    end
    datasource.to_s
  end

  def wrap_with_double_quotes(string)
    ' "' + string + '" '
  end
end