class Cesar
  
  def self.generate(report_path, options)
    raise_arg_error_if_nil_or_empty report_path
    arguments = "-n #{wrap_with_double_quotes(report_path)} "
    arguments << string_options(options)
    system "java -jar \"#{File.expand_path("../../utils/jasperc.jar", __FILE__)}\" #{arguments}"
  end

  def self.pdf_export(report_path, options)
    options[:export_to] = :pdf
    generate report_path, options
  end

  def self.excel_export(report_path, options)
    options[:export_to] = :excel
    generate report_path, options
  end

  def self.print(report_path, options)
    options[:print] = true
    generate report_path, options
  end
end

module Kernel

  DEFAULT_DATASOURCE        = :sql
  VALID_DATASOURCE_OPTIONS  = [:sql, :xml, :csv]
  DEFAULT_EXPORT_TO_OPTION  = " pdf "
  VALID_EXPORT_TO_OPTIONS   = [:excel, :pdf]

  private 

  def string_options(options)
    return_string =  export_to(options[:export_to])
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
      raise ArgumentError, "You must provide the export_path"
    end
  end

  def datasource_path(datasource_path)
    return_string = " -d "
    if datasource_path 
      return_string << wrap_with_double_quotes(datasource_path)
    else  
      raise ArgumentError, "Yout must provide de datasource_path"
    end
  end

  def datasource(datasource)
    return DEFAULT_DATASOURCE.to_s if datasource.nil?
    if !VALID_DATASOURCE_OPTIONS.include? datasource
      raise ArgumentError, "Datasource option #{datasource} is invalid. Only #{VALID_DATASOURCE_OPTIONS} are available"
    end
    datasource.to_s
  end

  def wrap_with_double_quotes(string)
    ' "' + string + '" '
  end

  def export_to(export_to)
    raise_arg_error_on_invalids_export_to_options(export_to) 
    if export_to.nil? 
      export_to.to_s
    else 
      DEFAULT_EXPORT_TO_OPTION
    end
  end

  def raise_arg_error_if_nil_or_empty(report_path)
    raise ArgumentError, "I need the report_path" if report_path.nil? || report_path.empty?
  end

  def raise_arg_error_on_invalids_export_to_options(export_to)
    if !VALID_EXPORT_TO_OPTIONS.include?(export_to)
      raise ArgumentError, "export_to option #{export_to} is invalid. Only #{VALID_EXPORT_TO_OPTIONS} is available" 
    end
  end
end