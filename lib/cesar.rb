module Cesar

  VERSION = '0.0.0'

  DEFAULT_DATASOURCE        = :sql
  VALID_DATASOURCE_OPTIONS  = [:sql, :xml, :csv]
  DEFAULT_EXPORT_TO_OPTION  = " pdf "
  VALID_EXPORT_TO_OPTIONS   = [:excel, :pdf]
  
  def Cesar.generate(report_path, options)
    raise_arg_error_if_nil_or_empty report_path
    arguments = "-n #{wrap_with_double_quotes(report_path)} "
    arguments << string_options(options)
    system "java -jar \"#{File.expand_path("../../utils/jasperc.jar", __FILE__)}\" #{arguments}"
  end

  def Cesar.pdf_export(report_path, options)
    options[:export_to] = :pdf
    generate report_path, options
  end

  def Cesar.excel_export(report_path, options)
    options[:export_to] = :excel
    generate report_path, options
  end

  def Cesar.print(report_path, options)
    options[:print] = true
    generate report_path, options
  end

  private 

  def Cesar.string_options(options)
    return_string =  export_to(options[:export_to])
    return_string << export_path(options[:export_path])
    return_string << datasource_path(options[:datasource_path])
    return_string << datasource(options[:datasource])
    
    if options[:print]
      return_string << ' pred '
    end

    if options[:child_node]
      return_string << " -m #{options[:child_node]} "    
    end

    if options[:id]
      unless options[:datasource].eql? :sql raise ArgumentError, ':id is only for sql datasource'

    end
    return_string
  end

  def Cesar.export_path(export_path)
    return_string = ' -e '
    if export_path
      return_string << wrap_with_double_quotes(export_path)
    else
      raise ArgumentError, 'You must provide the export_path'
    end
  end

  def Cesar.datasource_path(datasource_path)
    return_string = ' -d '
    if datasource_path 
      return_string << wrap_with_double_quotes(datasource_path)
    else  
      raise ArgumentError, 'Yout must provide the datasource_path'
    end
  end

  def Cesar.datasource(datasource)
    return DEFAULT_DATASOURCE.to_s if datasource.nil?
    raise_arg_error_on_invalid_datasource_options datasource
    datasource.to_s
  end

  def Cesar.wrap_with_double_quotes(string)
    ' "' + string + '" '
  end

  def Cesar.export_to(export_to)
    return DEFAULT_EXPORT_TO_OPTION.to_s if export_to.nil?
    raise_arg_error_on_invalids_export_to_options export_to
    export_to.to_s
  end

  def Cesar.raise_arg_error_if_nil_or_empty(report_path)
    raise ArgumentError, 'I need the report_path' if report_path.nil? || report_path.empty?
  end

  def Cesar.raise_arg_error_on_invalids_export_to_options(export_to)
    if !VALID_EXPORT_TO_OPTIONS.include? export_to
      raise ArgumentError, "export_to option #{export_to} is invalid. Only #{VALID_EXPORT_TO_OPTIONS} is available" 
    end
  end

  def Cesar.raise_arg_error_on_invalid_datasource_options(datasource)
    if !VALID_DATASOURCE_OPTIONS.include? datasource
      raise ArgumentError, "Datasource option #{datasource} is invalid. Only #{VALID_DATASOURCE_OPTIONS} are available"
    end
  end
end