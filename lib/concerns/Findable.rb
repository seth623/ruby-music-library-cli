module Concerns::Findable 

    def find_by_name(n) 
        self.all.detect{ |x| x.name == n }
    end 

    def find_or_create_by_name(n)
        if find_by_name(n)
            find_by_name(n) 
        else 
            self.create(n)
        end  
    end 

end 