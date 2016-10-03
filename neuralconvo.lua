require 'torch'
require 'nn'
require 'rnn'

neuralconvo = {}

torch.include('neuralconvo', 'dataset.lua')
torch.include('neuralconvo', 'seq2seq.lua')

return neuralconvo
