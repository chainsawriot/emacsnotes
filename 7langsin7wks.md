# Ruby
## puts 'it is true' if 0
0 is true in Ruby
## Dynamic typing
do type checking until the code is executed
## Duck typing
If two objects have the same set of methods, they should be the same, regardless of the underlyng type.

### day 1 excercise

``` ruby
puts 'Hello world.'
'Hello. Ruby.'.rindex('Ruby') # parens are optional.
'Hello. Ruby.'.rindex 'Ruby' # So Perl!

# print my name 10 times
i = 0
while i < 10
	puts 'Chainsaw'
	i = i + 1
end

# print sentences 10 times
for i in 1..10
	puts "This is sentence #{i}"
end

# run from file
# ruby xyz.rb

# number guessing
i = rand(101)
puts 'Guess a number, from 0 to 100'
while true
	j = gets.chomp.to_i
	if j > i
		puts 'To high'
	elsif j < i
		puts 'To low'
	else
		puts 'You got it!'
		break
	end
end

```
