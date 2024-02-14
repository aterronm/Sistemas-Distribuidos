class Block
  attr_reader :index, :timestamp, :transactions, 
              :transactions_count, :previous_hash, 
              :nonce, :hash, :difficulty_bits, :nonce_time

  def initialize(index, transactions, previous_hash, difficulty_bits)
    @index             = index
    @timestamp         = Time.now
    @transactions      = transactions
    @transactions_count = transactions.size
    @previous_hash     = previous_hash

    # Two attributes have been added for nonce response time and difficulty bits
    @difficulty_bits   = difficulty_bits
    @nonce, @hash, @nonce_time = compute_hash_with_proof_of_work
  end

  # Method to calculate hash with proof of work
  def compute_hash_with_proof_of_work
    inicio = Time.now
    nonce = 0
    loop do 
      hash = calc_hash_with_nonce(nonce)
      if hash.start_with?(self.difficulty_bits)
        final = Time.now
        nonce_time = (final - inicio)
        return [nonce, hash, nonce_time]
      else
        nonce += 1
      end
    end
  end

  # Method to calculate hash with nonce
  def calc_hash_with_nonce(nonce=0)
    sha = Digest::SHA256.new
    sha.update( nonce.to_s + 
                @index.to_s + 
                @timestamp.to_s +
                @difficulty_bits.to_s +
                @transactions.to_s + 
                @transactions_count.to_s + 
                @previous_hash )
    sha.hexdigest 
  end

  # Method to create genesis block
  def self.first( *transactions, difficult)
    # Uses index zero (0) and arbitrary previous_hash ("0")
    Block.new( 0, transactions, "0", difficult)
  end

  # Method to create next block
  def self.next( previous, transactions, difficult)
    Block.new( previous.index+1, transactions, previous.hash, difficult)
  end
end  # class Block
