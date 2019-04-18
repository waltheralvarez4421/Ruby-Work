# Walther Alvarez
# CISC 683
# Assignment #2

# Problem 1
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

class DNA < Hamming
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
end

dna1 = DNA.new('ATTGCC')
dna1.seq
dna1.length
puts dna1
dna2 = DNA.new('GTTGAC')
dna1.hamming_distance(dna1,dna2)
dna1.hamming_distance(dna1,dna1)
dna1.hamming_distance(DNA.new('AT'),dna1)
dna1.frequencies

#Problem #2

class PhoneNumber
    attr_reader :ph
    
    def initialize(ph)
    	ph = ph.to_s
    	@ph = self.class.normalize(ph)
    	return self.inspect
    end

    def inspect
    	@ph
    end

    def area_code
    	phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
        m = phone_re.match(ph)
        m[1]
    end

    def prefix
    	phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
        m = phone_re.match(ph)
        m[2]
    end

    def root
    	phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
    	m = phone_re.match(ph)
        m[3]
    end

    def self.normalize(ph)
    	ph = ph.strip
    	a = ph[0]
    	b = ph[5]
    	c = ph[3]
    	if ph.length < 10 || /\)/.match(ph[3]) || /\s/.match(ph[4])
    		raise ArgumentError.new('Improper Phone Number Syntax')
    	end
    	a = a.to_i unless a.match(/[^[:digit:]]+/)
    	if  a.is_a?(Integer) == true then
    	    phone_re = /(\d{3})+(\d{3})+(\d{4})/
    	    m = phone_re.match(ph)
            return '('+m[1]+') ' + m[2]+'-'+m[3]
        elsif b == ' '      	
        	phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
        	m = phone_re.match(ph)
            return '('+m[1]+') ' + m[2]+'-'+m[3]
        elsif c == '-'        	
        	phone_re = /(\d{3})\W+(\d{3})-(\d{4})/
        	m = phone_re.match(ph)
            return '('+m[1]+') ' + m[2]+'-'+m[3]
        else 
        	phone_re = /\((\d{3})\)+(\d{3})-(\d{4})/
        	m = phone_re.match(ph)
            return '('+m[1]+') ' + m[2]+'-'+m[3]
        end
        return ph.to_s
    end
end


a = PhoneNumber.new(1234567890)
a.area_code
a.prefix
a.root
d = PhoneNumber.new(' (555)444-3333')
PhoneNumber.new(' (555) 444-3333')
PhoneNumber.new(' 7778889999 ')
PhoneNumber.new('777-888-9999')
puts d

PhoneNumber.new('1234')
PhoneNumber.new('(12) 333-4444')
PhoneNumber.new('123- 456- 7890')

