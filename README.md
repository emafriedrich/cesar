# cesar

JasperReport for ruby MRI enviroments 

# Instalation

gem install cesar

# Use

*cesar* provide four methods for generate or print reports through JasperReport

Cesar.generate
Cesar.pdf_export
Cesar.excel_export
Cesar.print

With the next options

:export_to => :pdf || :excel 
:datasource => :xml || :csv || :sql
:datasource_path => String # with path of datasource (csv, xml, or properties file)
:export_path => String # with path for export the report (Rails.root + "/tmp/pdf.pdf" for example)
:print => true # for print the report on default printer 

pdf_export, excel_export and print methods are short way for pdf export, excel export and print reports, respectly

# Examples

Generate pdf report 

Cesar.pdf_export  'report_path',
                  datasource: :sql,
                  datasource_path: 'properties_file',
                  export_path: 'pdf_file'

Generate excel report 

Cesar.excel_export  'report_path',
                  datasource: :sql,
                  datasource_path: 'properties_file',
                  export_path: 'pdf_file'

more examples in test folder
