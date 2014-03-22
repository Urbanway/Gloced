module ApplicationHelper

  def title
    "gloced"
  end
  def logo
    image_tag("/images/logo.png", :alt => "Gloced")
  end
  def get_geo(what)
  				require 'open-uri'
 				require 'json'
 				json_object = JSON.parse(open("http://www.geobytes.com/IpLocator.htm?GetLocation&template=json.txt&ip_address=#{request.remote_ip}").read)

 				if request.remote_ip == "127.0.0.1"
 				  vari = "local"
 				else
 				  vari = json_object['geobytes'][what]
         end
         return vari
    end
 
end
