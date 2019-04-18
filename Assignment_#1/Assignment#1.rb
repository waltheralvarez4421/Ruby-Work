# Walther Alvarez
# CISC 683
# Assignment #1

# Problem #1 The function delete_first(a, obj) 
# that deletes from a only its first item that 
# is equal to obj, if any. 

a = Array[1,2,1,3,1,4,2,5]
a.delete(1)
a

a = Array[1,2,1,3,1,4,2,5]

def delete_first(a, obj)
    Integer x = obj
    a.each do |v|
        y = v
        if x == y then
            a.delete_at(a.index(x)) 
            break
        else
        end
    end
    a
end

a

delete_first(a,1)


# Problem #2 
# The Fibonacci sequence fib is defined thus: 
# fib(1) = fib(2) = 1, and fib(n) = fib(n−1)+fib(n−2) for n>2.
# This is a function fib_array(n) that returns an array 
# containing the first n values of the Fibonacci sequence. 

def fibonacci( n )
    return  n  if n <= 1
    a = fibonacci( n - 1 ) 
    b = fibonacci( n - 2 )
    c = a + b
    return c
end 

def fib_array(n)
    x = []
    if n == 0
        x << n
    else
        while x.length != n 
            if n <= 2
            	a = fibonacci(n)
                x << a
            else
            	b = (n - (n-1)..n).to_a
            	b.each do |v|
                   y = v
                   a = fibonacci(y)
                   x << a
                end
            end
        end
        print x
    end
end

fib_array(1)

fib_array(2)

fib_array(6)

fib_array(10)

# Problem #3 
# This is afunction fib(n) that returns the n’th Fibonacci value
def fib_r(a, b, n)
  n == 0 ? a : fib_r(b, a + b, n - 1)
end

def fib(n)
  fib_r(0, 1, n)
end

# Problem #4
# This is a function count_occurrences(a, obj) 
# that counts the number of items in array a that are equal to obj.
a = Array[1,2,1,3,1,4,2,5]

def count_occurrences(a, obj)
	Integer x = obj
	i = 0
    a.each do |v|
        y = v
        if x == y then
        	i += 1
        else
        end
    end
    return i
end

a

count_occurrences(a, 1)

count_occurrences(a, 2)

# Problem #5
# An int-array is an array of zero or more int-expressions, 
# where an int-expression is an integer or an int-array. 
# Informally, an int-array is an array of integers that can nest to any depth. 
# This is a function count_occurrences_rec(a, i) that counts the number 
# of times that the integer i occurs in the  int-array a.
a = Array[1,[1,2],[[[1,1],1]]]

def count_occurrences_rec(a,i)
	Integer g = 0
    c = i.to_s
    a = a.map { |v|  v.to_s   }.join(",")
    a.each_char do |char|
        if char == c then
        	g += 1
        else
        end
    end
    return g
end

count_occurrences_rec(a,1)

# Problem #6 
# This is a function insert(x, a) that takes an integer x 
# and an array a of integers in nondecreasing order and 
# returns a new sorted array that includes x and the integers of a. 
# The function does not modify a.
a = [2,3,5,9,12]

def insert(x,a)
    c = a.dup
    c.push(x)
    c = c.sort
    return c
end

insert(5,a)

insert(10,a)

insert(20,a)

# Problem #7
# This is a function insertion_sort(a) that takes an array of numbers
# and returns an array of the same values in nondecreasing order, without modifying a. 
# The function uses the insert function written in the previous problem.
def insert(x,a)
    c = a.dup
    c.push(x)
    c = c.sort
end

def insertion_sort(a)
  c = a.dup
  size = c.length
  i = 0
  f = []
  while i < size do
    f = insert(c[i],f)
    i += 1
    g = f
  end
  return g
end

b = Array.new(12) {Random.rand(100)}

insertion_sort(b)

b

insertion_sort(b) == b.sort

# Problem #8
# The factorial of an integer n is defined fact(n)=n!=n*(n−1)*(n−2)...*1.
# Here are five different versions of the function fact, named fact1, … fact5.
def fact1(n)
  if n == 0
    return 1
  else 
    return n*fact1(n-1)
  end
end

fact1(5)

fact1(40)

def fact2(n)
  sum = 1
  until n == 0
    sum *= n
    n -= 1
  end
 sum
end

fact2(5)

fact2(40)

def fact3(n)
  n == 0 ? 1 : n*factorial(n-1)
end

fact3(5)

fact3(40)

def factorial(n)
  (1..n).inject(:*) || 1
end

fact4(5)

fact4(40)

