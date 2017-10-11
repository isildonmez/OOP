class Person
	#attr_reader :name
	attr_writer :name
	# attr_accessor :name

	def initialize(name, surname)
		@name = name
		@surname = surname
		@is_this_person_on_wikipedia = false
	end

	# def name=(other)
	# 	@name = other
	# end

	#def name
	#	@name
	#end

	def full_name
		name + ' ' + surname
	end

	def name
		return @name unless name.nil?

		# Name is missing, fetch it from wikipedia
		@name = some_code_to_fetch_from_wikipedia_a_random_name
		@name
	end

	private

	def is_this_person_on_wikipedia
		return @is_this_person_on_wikipedia unless @is_this_person_on_wikipedia.nil?

		@is_this_person_on_wikipedia = fetch_from_wikipedia
	end
end

myself = Person.new('Alfredo', 'Motta')
puts myself.name
puts myself.full_name

myself = Person.new(nil, nil)
puts myself.name # => I want this to print a random name from Wikipedia



