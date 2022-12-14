require "net/http"
require "uri"
require "json"

class LibrarianController < ApplicationController
    protect_from_forgery
    
    def index
        @bookshelves=Bookshelf.all
    end
    
    def showshelf
        session[:shelf_id]=params[:id]
        redirect_to "/show"
    end
    
    def show
        @id=session[:shelf_id]
        @shelf=Bookshelf.find(@id)
        @shelfdata=BookCollectionList.where(Bookshelf_id: @id)
    end
    
    def edit
        session[:pagestatus]="edit"
        @status=true
        @id=session[:shelf_id]
        @shelfdata=BookCollectionList.where(Bookshelf_id: @id)
    end
    
    def edit_title
        @status=false
        render action: :edit
    end
    
    def confirmtitle
        
    end
   
    def new
        #randing
        shelf=Bookshelf.new(title: "",user_id: 0)
        shelf.save
        session[:shelf_id]=shelf.id
        redirect_to "/create"
    end
     
    def create
        session[:pagestatus]="create"
        @id=session[:shelf_id]
        shelf=Bookshelf.find(@id)
        if shelf.title == ""
            @status=false
        else
            @status=true
        end
        
        @shelfdata=BookCollectionList.where(Bookshelf_id: @id)
    end
    
    def title
        Bookshelf.find(session[:shelf_id]).update(title: params[:title])
        back_to(session[:pagestatus])
    end
    
    def add
        @add=nil
    end
    
    def search
        search_str=params[:search_field]
        @data=googlebookapi_data(search_str)
        render action: :add
    end
    
    def addbook2shelf
        googlebookesid=params[:gbapiid]
        addbook=BookCollectionList.new(Bookshelf_id: session[:shelf_id],googlebooksid: googlebookesid)
        if addbook.save
            #good
        else
            #bad
        end
        redirect_to "/back"
    end
    
    def delete_book
        book=BookCollectionList.find(params[:id])
        book.destroy
        back
    end
    
    def delete_shelf
        book=Bookshelf.find(params[:id])
        book.destroy
        redirect_to "/index"
    end
    
    def back
        back_to(session[:pagestatus])
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
    
    def googlebookapi_search_one(id)
        bookinfo=Struct.new(:id, :title, :thumbnail, :link)
        apiurl="https://www.googleapis.com/books/v1/volumes/"
        
        urlpath=apiurl+id
        url=URI.parse(urlpath)
        data=JSON.parse(Net::HTTP.get(url))
        
        id=data["id"]
        data=data["volumeInfo"]
        title=data["title"]
        thumbnail_images=data["imageLinks"]
        if thumbnail_images!=nil
            thumbnail=thumbnail_images["thumbnail"]
        else
            thumbnail=nil    
        end
        link=data["previewLink"]
        @book=bookinfo.new(id,title,thumbnail,link)
        
        return @book
    end
    
    helper_method :googlebookapi_data, :googlebookapi_search_one
end
