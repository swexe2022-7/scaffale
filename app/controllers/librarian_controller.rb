require "net/http"
require "uri"
require "json"

class LibrarianController < ApplicationController
    def index
        #nanikakaku
    end
    
    
    
    def verification
        keyword="ハリーポッター"
        
        json=googlebookapi_req(keyword)
        @data=JSON.parse(json)
        
    end
    
    def googlebookapi_req(search_str)
        apiurl="https://www.googleapis.com/books/v1/volumes?q="
        
        urlpath=apiurl+URI.encode_www_form_component(search_str)
        url=URI.parse(urlpath)
        return Net::HTTP.get(url)
    end
end
