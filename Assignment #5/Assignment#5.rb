#Assignment #5
#Walther Alarez   
#CISC 683

#Problem 1
class PhoneContact     
    attr_reader :phone_number, :label 
    def initialize(name,phone_number, label) 
        @name = name
        @phone_number = PhoneNumber.new(phone_number)         
        @label = label.to_s 
    end 
    def ==(other)        
        phone_number == other.phone_number && label == other.label 
    end 
    def to_s        
        phone_number.to_s + ' (' + label + ')' 
    end 
end 

class PhoneNumber < PhoneContact
    def initialize(phone_number) 
        @phone_number = normalize(phone_number)    
    end 
    def normalize(phone_number)       
        ph = phone_number.to_s.strip        
        patterns = [/^(\d{10})$/, /^(\d{3})-(\d{3})-(\d{4})$/, /^\((\d{3})\)\s*(\d{3})-(\d{4})$/]         
        matches = patterns.map {|pat| pat.match(ph)}        
        match = matches.find {|m| m.is_a?(MatchData)}         
        if match then 
                    match.captures.join         
        else 
            raise ArgumentError, "Improper phone number syntax"        
        end 
    end 
    def name
        @name
    end
    
    def label
        @label
    end
    def phone_number         
        @phone_number 
    end 
    def area_code       
        phone_number.slice(0,3) 
    end 
    def prefix       
        phone_number.slice(3,3) 
    end 
    def root        
        phone_number.slice(6,4) 
    end 
    def ==(other)        
        phone_number == other.phone_number 
    end 
    def to_s        
        '(' + area_code + ') ' + prefix + '-' + root 
    end 
end 


class PhoneBook < PhoneNumber
    def initialize
        @name =""
        @phoneBookList = Array.new(20)
        phoneBookList = @phoneBookList
        @count = 0

    end
   
    def add(name, phone_number, label)
        phoneBookList[@count] = PhoneContact.new(name,phone_number,label)
        @count +=1
    end
    
    def find_contact(name, label)
        $i = 0
        while $i < 20  do
            if (name == phoneBookList[$i].name and label == phoneBookList[$i].label) then
                return True
            end
            $i = $i + 1
        end
        return False
    end
                
    def find(name)
        $i = 0
        while $i < 20  do
            if (name == phoneBookList[$i].name) then
                return True
            end
            $i = $i + 1
        end
        return False
    end
    
    def delete(name)
        $i = 0
        while $i < 20  do
            if (name == phoneBookList[$i].name ) then
                phoneBookList.delete($i)
                return
            end
            $i = $i + 1
        end
    end
    
    def delete_contact(name, label)
        $i = 0
        while $i < 20  do
            if (name == phoneBookList[$i].name and label == phoneBookList[$i].label) then
                phoneBookList.delete($i)
                return
            end
            $i = $i + 1
        end
    end

    def to_s  
        $i = 0
        while $i < 20  do
            print phoneBookList[$i].to_s
            $i = $i + 1
        end
    end
end

book = PhoneBook.new 
book.add('Lennon, John', '954-555-1234', 'work') 
book.add('Garcia, Jerry', 9541112222, 'work') 
book.add('Lennon, John', '(954) 123-4567', :home) 
book.add('Garcia, Jerry', 9541234567, 'cell') 
book.add('Simon, Paul', '9543334444', 'cell') 
puts "**Entire book" 
puts book 
puts "**Jerry's entry" 
puts book.find('Garcia, Jerry') 
if not book.find('Jagger, Mick') then     
    puts "**No entry for Mick" 
end 
puts "**Paul's cell number:" 
puts book.find_contact('Simon, Paul', :cell) 
book.add('Garcia, Jerry', '4445555555', :cell) 
puts "**Jerry's new entry:" 
puts book.find('Garcia, Jerry') 
puts "**Entire phone book:" 
puts book 
puts "**Delete John's work number" 
book.delete_contact('Lennon, John', 'work') 
puts book.find('Lennon, John') 
puts "**Delete John's home number; should delete his entry" 
book.delete_contact('Lennon, John', 'home') 
puts book.find('Lennon, John') 
puts "**Delete Paul's entry" 
book.delete('Simon, Paul') 
puts "**Now we have only Jerry's entry in the whole book" 
puts book 


#Problem 2
class Hamming
  def hamming_distance(original, mutation)
    # check equal length
    if original.length != mutation.length
      raise ArgumentError.new('dnas of different length')
    end

    # go through both strings
    difference = 0
    mutation_char = mutation.seq.split("")
    original.seq.each_char.with_index(0) do |character, index|
      unless mutation_char[index] == character.to_s
        difference = difference + 1
      end
    end

    difference
  end
end

class DNA 
    attr_reader :seq
    
    def initialize(seq)
        @seq = self.class.normalize(seq)
        self.inspect
    end

    def inspect
        seq
    end

    def seq
        @seq
    end

    def to_s
        @seq
    end

    def length
        f = @seq
        f.length
    end

    def self.normalize(seq)
        seq.to_s
    end

    def frequencies
        seq = @seq
        a = seq.count "A"
        t = seq.count "T"
        g = seq.count "G"
        c = seq.count "C"
        Hash["A", a, "T", t, "G", g, "C", c]
    end
  
    def reverse_complement
        str = seq
        nucleotide_complement=Hash['A' => 'T', 'T' => 'A', 'C' => 'G', 'G' => 'C']
        str1 = str.gsub /\w/,nucleotide_complement
        str2 = str1.reverse
        return str3 = DNA.new(str2)
    end

    def ==(another_seq)
        self.length == another_seq.length
    end

    def most_frequent_kmers(n)
        str = seq
        a = n
        a.times.
          flat_map { |i| str[i..-1].each_char.each_cons(a).to_a }.
            uniq.
              each_with_object({}) do |a,h|
                  r = /#{a.first}(?=#{a.drop(1).join('')})/
                      h[a.join('')] = str.scan(r).size
                  end.max_by { |_,v| v }
    end
end


dna1 = DNA.new('ATTGATTCCG')
dna1.most_frequent_kmers(1)
dna1.most_frequent_kmers(2)
dna1.most_frequent_kmers(3)
dna1.most_frequent_kmers(4)
