# enstratus_helper
enstratus_helper is a simple ruby class that helps making request to enStratus web service easier. With enstratus_helper, you only have to specify the resource you want to request, and it will handle the signature generation & HTTP header initialization for you.


## Usage

```ruby
     require 'enstratus_helper'
     access_key = "my_access_key"
     secret_key = "super_secret_key"

     ehelper = EnstratusHelper.new(:access_key => access_key, :secret_key => secret_key)

     # You can specify whether to use json or xml format
     ehelper = EnstratusHelper.new(:access_key => access_key, :secret_key => secret_key, :accept => 'application/json')

     # Example of doing GET requests
     puts ehelper.request :get, 'http://api.enstratus.com/api/enstratus/2011-02-24/geography/Region'
     puts ehelper.request :get, 'http://api.enstratus.com/api/enstratus/2011-02-24/infrastructure/MachineImage?regionId=my_region_id'
     puts ehelper.request :get, 'http://api.enstratus.com/api/enstratus/2011-02-24/infrastructure/Server'

     # You can explicitly define GET request header. Here, we're explicitly specifying the format to be JSON
     #puts ehelper.request :get, 'http://api.enstratus.com/api/enstratus/2011-02-24/admin/BillingCode', :header => {'Accept' => 'application/json'}

     # Example of doing POST requests
     xml_data =<<EOF
     <addBillingCode>
       <billingCode>
         <name>API Dev 1</name>
         <financeCode>API 1</financeCode>
         <description>API Development</description>
         <softQuota>USD50.00</softQuota>
       </billingCode>
     </addBillingCode>
     EOF
     json_data = {:addBillingCode => {:billingCode => {:name => 'API 3', :financeCode => "API 3", :description => "description", :softQuota => 'USD11.01', :hardQuota => 'USD11.11'}}}.to_json

     ehelper.request :post, 'http://api.enstratus.com/api/enstratus/2011-02-24/admin/BillingCode', :data => xml_data
     ehelper.request :post, 'http://api.enstratus.com/api/enstratus/2011-02-24/admin/BillingCode', :data => xml_data, :header => {'Accept' => 'application/xml'}
     ehelper.request :post, 'http://api.enstratus.com/api/enstratus/2011-02-24/admin/BillingCode', :data => json_data, :header => {'Accept' => 'application/json'}
```
