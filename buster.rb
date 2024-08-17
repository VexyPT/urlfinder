require 'net/http'
require 'uri'
require 'optparse'
require 'io/console'
require 'time'

# Function to check URLs
def check_url(url, found_urls, status_codes)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  if status_codes.include?(response.code.to_i)
    found_urls << { url: url, status: response.code }
    puts "[+] #{url} (Status: #{response.code})"
  end
rescue
  # Suppress error messages
end

def main(target, wordlist, threads, status_codes)
  wordlist_lines = File.readlines(wordlist).map(&:strip)
  queue = Queue.new
  found_urls = []

  wordlist_lines.each do |word|
    queue << "#{target}/#{word}"
  end

  puts "====================================================="
  puts "UrlFinder v1.0.0"
  puts "====================================================="
  puts "[+] Mode         : dir"
  puts "[+] Url/Domain   : #{target}"
  puts "[+] Threads      : #{threads}"
  puts "[+] Wordlist     : #{wordlist}"
  puts "[+] Status codes : #{status_codes.join(', ')}"
  puts "[+] Timeout      : 10s"
  puts "====================================================="
  puts "#{Time.now.iso8601} Starting urlfinder"
  puts "====================================================="

  workers = (0...threads).map do
    Thread.new do
      while !queue.empty?
        url = queue.pop(true) rescue nil
        check_url(url, found_urls, status_codes) if url
      end
    end
  end

  workers.each(&:join)

  puts "====================================================="
  puts "#{Time.now.iso8601} Finished"
  puts "====================================================="

  if found_urls.empty?
    puts "No URLs found."
  else
    puts "Found URLs:"
    found_urls.each { |entry| puts "#{entry[:url]} (Status: #{entry[:status]})" }
  end
end

# Command-line options setup
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: buster.rb -u URL -w WORDLIST -t THREADS"

  opts.on("-u", "--url TARGET", "Target URL") do |u|
    options[:target] = u
  end

  opts.on("-w", "--wordlist WORDLIST", "Path to wordlist") do |w|
    options[:wordlist] = w
  end

  opts.on("-t", "--threads THREADS", Integer, "Number of threads (default: 10)") do |t|
    options[:threads] = t
  end

  opts.on("--status-codes CODES", Array, "Comma-separated list of status codes to look for (default: 200)") do |codes|
    options[:status_codes] = codes.map(&:to_i)
  end
end.parse!

# Check if mandatory parameters are provided
if options[:target].nil? || options[:wordlist].nil?
  puts "Please provide a target URL and a wordlist."
  exit
end

# Default status codes to look for if not provided
options[:status_codes] ||= [200]

# Run the brute force
main(options[:target], options[:wordlist], options[:threads] || 10, options[:status_codes])