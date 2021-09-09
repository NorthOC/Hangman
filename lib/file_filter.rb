module Secret
	def secret
	data = File.read('../5desk.txt').split(' ')
	data = data.filter do |word|
		if word.length > 5 && word.length < 12
			word
		end
	end

	data.sample
	end
end
