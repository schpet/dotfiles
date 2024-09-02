local projectionist_heuristics = {}

local rb_heuristics = {}

rb_heuristics['*.rb'] = {
  alternate = '{}_test.rb',
  type = 'source'
}

rb_heuristics['*_test.rb'] = {
  alternate = '{}.rb',
  type = 'test'
}


projectionist_heuristics["*.rb"] = rb_heuristics
