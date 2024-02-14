require 'colorize'                # For coloring console output

# Method to display registered users
def display_registered_users(user_list)
  puts "\n\n\tRegistered Users:\n\n"
  user_list.each_with_index do |user, index|
    puts "\t\t#{index + 1}. #{user}\n"
  end
  puts "\n\n"
end

# Method to check if a user exists in the user list
def user_exist?(username, user_list)
  user_list.each do |u|
    return true if u == username
  end
  return false
end

# Method to get transactions data for a block
def get_transactions_data(users)
  transactions_block ||= []
  blank_transaction = Hash[from: "", to: "", what: "", qty: ""]

  loop do
    puts "\n\tWho's sending? : "
    from = gets.chomp.downcase

    # Check if sender is a registered user, if not, add them to the user list
    unless user_exist?(from, users)
      users << from
      puts "\n\tNew user named #{from} registered!\n.colorize(:yellow)"
    end

    print "\n\tWhat do you want to send? : "
    what = gets.chomp
    print "\n\tHow much quantity? : "
    qty  = gets.chomp
    print "\n\tWho do you want to send it to? : "
    to   = gets.chomp.downcase

    # Check if receiver is a registered user, if not, add them to the user list
    unless user_exist?(to, users)
      users << to
      puts "\n\tNew user named #{to} registered!\n".colorize(:yellow)
    end

    transaction = { from: from, to: to, what: what, qty: qty }
    transactions_block << transaction

    print "\nDo you want to make another transaction for this block? (Y/n) : "
    new_transaction = gets.chomp.downcase

    if new_transaction == "y"
      self
    else
      # Display registered users and return the transactions block
      display_registered_users(users)
      return transactions_block
      break
    end
  end
end
