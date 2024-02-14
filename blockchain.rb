require 'digest'    						# For hash checksum digest function SHA256
require 'pp'        						# For pp => pretty printer
require 'colorize'           # For coloring console output

# require 'pry'                   # For on the fly debugging

require_relative 'block'					# class Block
require_relative 'transaction'		# method Transactions

LEDGER = []
USERS = []

def create_first_block(difficulty)

  puts "\n\nCreating first block...Genesis\n\n"
  # Create genesis block

  instance_variable_set("@b0",   
  Block.first(get_transactions_data(USERS), difficulty) )							 
  LEDGER << instance_variable_get("@b0")

  # Print message indicating the creation of the genesis block in red
  puts "===========================================Genesis Block========".colorize(:red)
  pp  @b0 
  puts "================================================================".colorize(:red)
  add_block(difficulty)

end



def add_block (difficulty)

  i = 1
  loop do
    instance_variable_set("@b#{i}", Block.next( (instance_variable_get("@b#{i-1}")),
                                                get_transactions_data(USERS),
                                                difficulty))


    LEDGER << instance_variable_get("@b#{i}")
    # Print information about the current block in yellow
    puts "======================================Block #{i}================".colorize(:yellow)
    pp instance_variable_get("@b#{i}")
    puts "================================================================".colorize(:yellow)
    i += 1
  end

end

def launcher
  puts "============================================================="
  puts "\n\tWelcome to Simple Blockchain In Ruby!\n\n".colorize(:blue)
  sleep 1.5
  puts "\tThis program was created by Anthony Amar and modified by Alvaro Terron for educational purposes.\n\n"
  sleep 1.5
  puts "\tPlease enter a difficulty level for our miners : "
  difficulty = gets.chomp

  puts "\n\t\t#{difficulty}? Alright ! Our miners will start working now.\n"
  puts "\n\n============================================================="
  create_first_block(difficulty.to_s)

end

# Launch the program
launcher
