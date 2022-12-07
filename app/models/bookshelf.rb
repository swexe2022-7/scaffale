class Bookshelf < ApplicationRecord
    has_many :BookCollectionList, dependent: :destroy
end
