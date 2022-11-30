require "net/http"
require "uri"
require "json"

class LibrarianController < ApplicationController
    def index
        #nanikakaku
    end
    
    
    
    def verification
        keyword="ハリーポッター"
        @data=googlebookapi_data(keyword)
        #@data=JSON.parse(googlebookapi_req(keyword))['items']
        
        
    end
    
    def googlebookapi_req(search_str)
        apiurl="https://www.googleapis.com/books/v1/volumes?q="
        
        urlpath=apiurl+URI.encode_www_form_component(search_str)
        url=URI.parse(urlpath)
        return Net::HTTP.get(url)
    end
    
    def googlebookapi_data(search_str)
        @booksdata=[]
        bookinfo=Struct.new(:id, :title, :thumbnail, :link)
        data=JSON.parse(googlebookapi_req(search_str))['items']
        
        data.each do |d|
            id=d["id"]
            d=d["volumeInfo"]
            title=d["title"]
            thumbnail=d["thumbnail"]
            link=d["infoLink"]
            b=bookinfo.new(id,title,thumbnail,link)
            @booksdata.push(b)
        end
        
        return @booksdata
    end
end
