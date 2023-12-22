class Song < ApplicationRecord
    validates_presence_of :title, :artist
end
