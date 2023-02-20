# GPT-3 (OpenAI) Semantic Search example
## OpenAI Embeddings

This repo is taken from the reinteractive article 
"Creating an Intelligent Knowledge Base Q&A App with GPT-3 and Ruby"

The purpose of this file is to provide an example of how to use OpenAI embeddings to create 
a knowledge base Q&A. The technology implements semantic search 

This example has two major Ruby files:

1. embeddings.rb
2. questions.rb

The embeddings rb file converts any text files in the /training-data folder into vector embeddings.
The questions rb file is used to ask GPT-3 questions about the training data and return meaningful
answers.

You can provide any text files in the training-data, with the following conditions:

1. The file must be a txt file.
2. The text should have a maximum of 2000 words.

If you have a document greater than 2000 words you will need to split it up into multiple pages.

## Setting up the script

Install the required dependencies.

```
gem install ruby-openai
```

## Preparing training data

The data you want to prepare should be saved into the training-data folder. Each file needs to be a text file and have a maximum of 2000 words.