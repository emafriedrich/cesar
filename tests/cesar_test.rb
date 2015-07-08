require File.expand_path("../lib/cesar", File.dirname(__FILE__))

def assert_exist_file export_path
  begin
    assert File.exists?(export_path)
    assert File.size(export_path) != 0
    File.delete export_path  
    true
  rescue
    false
  end
end

def report_path
  File.expand_path('test')
end

def pdf_export_path
  File.expand_path('andalacosa.pdf')
end


def datasource_xml_path
  File.expand_path('test.xml')
end

def xls_export_path
  File.expand_path('andalacosa.xls')
end

scope do 

  test "non nil or empty report_path" do 
    assert_raise ArgumentError do 
      Cesar.generate nil
    end
    assert_raise ArgumentError do 
      Cesar.generate ""
    end
  end

  test "pdf export with generate method" do 
    Cesar.generate  report_path, 
                    child_node: 'COMPROBANTE',
                    datasource: :xml,
                    export_to: :pdf,
                    export_path: pdf_export_path,
                    datasource_path: datasource_xml_path
    assert_exist_file pdf_export_path
  end

  test "xls export with generate method" do 
    Cesar.generate  report_path, 
                    child_node: 'COMPROBANTE',
                    export_to: :excel,
                    datasource: :xml,
                    export_path: xls_export_path,
                    datasource_path: datasource_xml_path
    assert_exist_file xls_export_path
  end

  test "xls export with excel_export method" do 
    Cesar.excel_export  report_path, 
                        child_node: 'COMPROBANTE',
                        datasource: :xml,
                        export_path: xls_export_path,
                        datasource_path: datasource_xml_path
    
    assert_exist_file xls_export_path
  end

  test "invalid datasource option" do
    assert_raise ArgumentError do 
      Cesar.excel_export  report_path, 
                        datasource: :bad,
                        datasource_path: datasource_xml_path
    end
  end

  test "empty datasource_path" do 
    assert_raise ArgumentError do 
      Cesar.excel_export  report_path, 
                        datasource: :xml,
                        export_path: xls_export_path
    end
  end

  test "empty export_path" do
    assert_raise ArgumentError do 
      Cesar.excel_export  report_path, 
                          datasource: :xml,
                          datasource_path: datasource_xml_path
    end
  end

  test "id without sql option"  do 
    assert_raise ArgumentError do 
      Cesar.generate report_path,
                     id: 1,
                     datasource: :xml,
                     datasource_path: File.expand_path('properties.properties'),
                     export_path: pdf_export_path
    end
  end

end
