function pbcopycsv
csv2html | textutil -stdin -format html -convert rtf -stdout | pbcopy
end
