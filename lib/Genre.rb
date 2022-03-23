class Genre 

    extend Concerns::Findable 
    @@all = []
    attr_accessor :name, :songs  

    def initialize(name) 
        @name = name 
        @songs = []
    end 

    def add_song(song)
        song.genre = self unless song.genre  
    end 

    def artists 
        self.songs.collect{ |song| song.artist }.uniq 
    end 

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre 
    end

    def save 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

    def self.destroy_all 
        @@all.clear
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

    def songs 
        Song.all.select{ |song| song.genre == self }
    end 

end 