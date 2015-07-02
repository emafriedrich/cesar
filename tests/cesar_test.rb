require File.expand_path("../lib/cesar", File.dirname(__FILE__))

scope do 

  test "non nil or empty report_path" do 
    assert_raise ArgumentError do 
      Cesar.generate nil
    end
    assert_raise ArgumentError do 
      Cesar.generate ""
    end
  end

  test "pdf export" do 
    export_path =   File.expand_path('andalacosa.pdf')
    Cesar.generate  File.expand_path('test'), 
                    child_node: 'COMPROBANTE',
                    datasource: :xml,
                    export_path: export_path,
                    datasource_path: File.expand_path('test.xml')
    
    assert File.exists?(export_path)
  end

  test "xls export" do 
    export_path = File.expand_path('andalacosa.xls')
    Cesar.generate  File.expand_path('test'), 
                    child_node: 'COMPROBANTE',
                    export_to: :excel,
                    datasource: :xml,
                    export_path: export_path,
                    datasource_path: File.expand_path('test.xml')
    
    assert File.exists?(export_path)
  end
end