# Walther Alvarez
# CISC 683
# Assignment #3

# Problem 2
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
end


dna1 = DNA.new('ATTGCC')
dna2 = dna1.reverse_complement
dna2
dna1
dna2.reverse_complement
dna1.reverse_complement.reverse_complement == dna1

dna1.seq
dna1.length
puts dna1
dna2 = DNA.new('GTTGAC')
dna1.hamming_distance(dna1,dna2)
dna1.hamming_distance(dna1,dna1)
dna1.hamming_distance(DNA.new('AT'),dna1)
dna1.frequencies

#Problem #3

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

    def phone_number
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

class PhoneContact < PhoneNumber
    attr_reader :label

    def initialize (ph,label)
        super(ph)
        @label = label
    end

    def label
        label = @label
        label = label.strip
    end

    def to_s
        self.inspect
    end

    def phone_number
        super
        a = PhoneNumber.new(ph)
        print '"'+ph+'"'
        return a
    end

    def area_code
        super
    end

    def inspect
        super + " (#{@label})"
    end
end



contact1 = PhoneContact.new('(954) 555-1212', :work)
contact1 = PhoneContact.new('(954) 555-1212', 'work')
contact1 = PhoneContact.new('(954)555-1212', 'work')
contact1 = PhoneContact.new('1234567890', '  home  ')
contact1.label
contact1.phone_number
contact1.to_s
# Due to my PhoneNumber code not being able to handle the following instance
# a different kind of instance is provided to prove feasibility of the
# additional PhoneContact code and its functionality.
contact2 = PhoneContact.new(' 955-555-1212', "cell")
contact2 = PhoneContact.new(' 9555551212', "cell")
contact2.phone_number.area_code
contact2.area_code
