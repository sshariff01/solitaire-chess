#!/usr/bin/env ruby
require_relative '../lib/solitaire_helper'

worker = SolitaireHelper.new

worker.process_input

worker.solve_solitaire