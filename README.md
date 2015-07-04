# Cesar

JasperReport for ruby MRI enviroments 

## Instalation

gem install cesar

## Use

[cesar] (https://github.com/emafriedrich/cesar) provide four methods for generate or print reports through JasperReport


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
    :child_node => String #examples below

pdf_export, excel_export and print methods are short way for pdf export, excel export and print reports, respectly

The report_path **should not have** the .jasper extension.

## Examples

Generate pdf report 

    Cesar.pdf_export  'report_path',
                       datasource: :sql,
                       datasource_path: 'properties_file',
                       export_path: 'pdf_file'

Generate excel report 

    Cesar.excel_export  'report_path',
                         datasource: :sql,
                         datasource_path: 'properties_file',
                         export_path: 'excel_file'

more examples in test folder

### :child_node (only xml datasources)

If your structure is similar to

    <a>
      <b></b>
      <b></b>
    </a>
    
child_node must be equal to "b" to indicate to Cesar that you want export or print 1 report with 2 instance of "b". In other words, 1 report with 2 reports in 1 print job
### Requirements

Cesar require java >= 7

### datasource: :sql

Only support for postgresql. If you wont support for other DBMS, open a issue. 




