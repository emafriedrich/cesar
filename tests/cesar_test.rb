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
    export_path =   File.expand_path('andalacosa.pdf')
    Cesar.generate  File.expand_path('test'), 
                    child_node: 'COMPROBANTE',
                    datasource: :xml,
                    export_to: :pdf,
                    export_path: export_path,
                    datasource_path: File.expand_path('test.xml')
    assert_exist_file export_path
  end

  test "xls export with generate method" do 
    export_path = File.expand_path('andalacosa.xls')
    Cesar.generate  File.expand_path('test'), 
                    child_node: 'COMPROBANTE',
                    export_to: :excel,
                    datasource: :xml,
                    export_path: export_path,
                    datasource_path: File.expand_path('test.xml')
    
    assert_exist_file export_path
  end

  test "xls export with excel_export method" do 
    export_path = File.expand_path('andalacosa.xls')
    Cesar.excel_export  File.expand_path('test'), 
                        child_node: 'COMPROBANTE',
                        datasource: :xml,
                        export_path: export_path,
                        datasource_path: File.expand_path('test.xml')
    
    assert_exist_file export_path
  end

  test "invalid datasource option" do
    export_path = File.expand_path('andalacosa.xls')
    assert_raise ArgumentError do 
      Cesar.excel_export  File.expand_path('test'), 
                        datasource: :bad,
                        datasource_path: File.expand_path('test.xml')
    end
  end

  test "empty datasource_path" do 
    export_path = File.expand_path('andalacosa.xls')
    assert_raise ArgumentError do 
      Cesar.excel_export  File.expand_path('test'), 
                        datasource: :xml,
                        export_path: export_path
    end
  end

  test "empty export_path" do
    assert_raise ArgumentError do 
      Cesar.excel_export  File.expand_path('test'), 
                          datasource: :xml,
                          datasource_path: File.expand_path('test.xml')
    end
  end
end
