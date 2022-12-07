require "net/http"
require "uri"
require "json"

class LibrarianController < ApplicationController
    def index
        @bookshelves=[]#Bookshelf.all
    end
    
    def showshelf
    end
    
    def edit
        @titlestatus=true
    end
   
    def new
        #randing
        shelf=Bookshelf.new(title: "",user_id: 0)
        shelf.save
        session[:shelf_id]=shelf.id
        redirect_to "/create"
    end
     
    def create
        @id=session[:shelf_id]
        shelf=Bookshelf.find(@id)
        if shelf.title == ""
            @status=false
        else
            @status=true
        end
        
        @shelfdata=BookCollectionList.find_by(id: @id)
    end
    
    def title
        Bookshelf.find(session[:shelf_id]).update(title: params[:title])
        back_to(params[:from])
    end
    
    def add
        @from=params[:id]
    end
    
    def back
        back_to(params[:id])
    end
    
    def back_to(from)
        if from=="create"
            redirect_to "/create"
        else
            redirect_to "/edit"
        end
    end
    
    def verification
        keyword="ハリーポッター"
        @data=googlebookapi_data(keyword)
        
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
            thumbnail_images=d["imageLinks"]
            if thumbnail_images!=nil
                thumbnail=thumbnail_images["thumbnail"]
            else
                thumbnail=nil    
            end
            link=d["infoLink"]
            b=bookinfo.new(id,title,thumbnail,link)
            @booksdata.push(b)
        end
        
        return @booksdata
    end
end
