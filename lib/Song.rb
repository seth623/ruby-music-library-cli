require 'pry'
class Song

    @@all = []
    attr_accessor :name, :genre 
    attr_reader :artist   

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist 
        self.genre = genre if genre    
    end

    def artist=(artist)
        @artist = artist 
        artist.add_song(self) 
    end 

    def self.find_by_name(name)  
        self.all.detect{ |song| song.name == name }
    end 

    def self.find_or_create_by_name(name)
        if find_by_name(name)
            find_by_name(name)
        else 
            self.create(name)
        end 
    end

    def genre=(genre)
        @genre = genre 
        genre.add_song(self) 
    end 

    def save 
        self.class.all << self 
    end 
    
    def self.all 
        @@all 
    end
    
    def self.create(name, artist = nil, genre = nil)
        song = self.new(name, artist, genre)
        song.save 
        song   
    end 

    def self.create_from_filename(filename) 
        new_from_filename(filename).save
    end

    def self.destroy_all 
        @@all.clear
    end 

    def self.new_from_filename(filename) 
        
        file_name_array = filename.split(" - ") 

        song_name = file_name_array[1]
        artist_name = file_name_array[0]
        genre_name = file_name_array[2].gsub(".mp3", "")

        artist_object = Artist.find_or_create_by_name(artist_name)
        genre_object = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist_object, genre_object)

    end 

end 