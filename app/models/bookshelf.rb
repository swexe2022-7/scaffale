class Bookshelf < ApplicationRecord
    has_many :bookCollectionList, dependent: :destroy
end
