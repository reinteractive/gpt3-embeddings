require 'ruby/openai'
require 'csv'

client = OpenAI::Client.new(access_token: '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')

text_array = []
embedding_array = []

Dir.glob("training-data/*.txt") do |file|
  text = File.read(file).dump()
  text_array << text
end

text_array.each do |text|
  response = client.embeddings(
    parameters: {
      model: "text-embedding-ada-002",
      input: text
    }
  )
  
  embedding = response['data'][0]['embedding']

  embedding_hash = {embedding: embedding, text: text}
  embedding_array << embedding_hash
end

CSV.open("embeddings.csv", "w") do |csv|
  csv << [:embedding, :text]
  embedding_array.each do |obj|
    csv << [obj[:embedding], obj[:text]]
  end
end