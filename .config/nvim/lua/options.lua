local projectionist_heuristics = {
  ["app/|spec/"] = {
    ["app/*.rb"] = { alternate = "spec/{}_spec.rb" },
    ["spec/*_spec.rb"] = { alternate = "app/{}.rb" }
  }
}

vim.g.projectionist_heuristics = projectionist_heuristics
