require 'dotenv'
require 'ruby/openai'
require 'csv'
require 'cosine_similarity'

Dotenv.load()

openai = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

puts "Welcome to the Sterling Parts AI Knowledge Base. How can I help you?"
question = gets

response = openai.embeddings(
  parameters: {
    model: "text-embedding-ada-002",
    input: question
  }
)

question_embedding = response['data'][0]['embedding']

similarity_array = []

CSV.foreach("embeddings.csv", headers: true) do |row|
  text_embedding = JSON.parse(row['embedding'])
  similarity_array << cosine_similarity(question_embedding, text_embedding)
end

index_of_max = similarity_array.index(similarity_array.max)
original_text = ""

CSV.foreach("embeddings.csv", headers: true).with_index do |row, rowno|
  if rowno == index_of_max
    original_text = row['text']
  end
end

prompt = 
"You are an AI assistant. You work for Sterling Parts which is a car parts online store located in Australia.
You will be asked questions from a customer and will answer in a helpful and friendly manner.

You will be provided company information from Sterline Parts under the [Article] section. The customer question
will be provided unders the [Question] section. You will answer the customers questions based on the article.
If the users question is not answered by the article you will respond with 'I'm sorry I don't know.'

[Article]
#{original_text}

[Question]
#{question}"

response = openai.completions(
  parameters: {
    model: "text-davinci-003",
    prompt: prompt,
    temperature: 0.2,
    max_tokens: 500,
  }
)

puts "\nAI response:\n"
puts response['choices'][0]['text'].lstrip
