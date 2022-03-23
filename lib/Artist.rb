class Artist 

    extend Concerns::Findable 
    @@all = []
    attr_accessor :name

    def initialize(name)
        @name = name 
    end 

    def add_song(song)
        song.artist = self unless song.artist     
    end 
    
    def genres 
        self.songs.collect{ |song| song.genre }.uniq
    end 

    def save 
        self.class.all << self 
    end 

    def self.all
        @@all 
    end

    def self.create(name)
        artist = self.new(name)
        artist.save 
        artist  
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
        Song.all.select{ |song| song.artist == self }
    end 

end 