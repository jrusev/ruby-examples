# The program guesses the user's number by keeping a list of all possible numbers,
# and pruning the list after each answer. The next guess can be any number from the list.
# Either you guess correctly or run out of numbers, which indicates a problem with scoring.
size = 4
scores = []
guesses = []
puts "Playing Bulls & Cows with #{size} unique digits."
possible_guesses = [*'1'..'9'].permutation(size).to_a.shuffle
 
loop do
  guesses << current_guess = possible_guesses.pop
  print "Guess #{guesses.size} is #{current_guess.join}. Answer (bulls,cows)? "
  scores << score = gets.split(',').map(&:to_i)
 
  # handle win
  break (puts "Yeah!") if score == [size,0]
 
  # filter possible guesses
  possible_guesses.select! do |guess|
    bulls = guess.zip(current_guess).count{|g,cg| g == cg}
    cows = size - (guess - current_guess).size - bulls
    [bulls, cows] == score
  end
 
  # handle 'no possible guesses left'
  if possible_guesses.empty?
    puts "Error in scoring?"
    guesses.zip(scores).each{|g, (b, c)| puts "#{g.join} => bulls #{b} cows #{c}"}
    break
  end
end