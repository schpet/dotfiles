function unindent
awk '{if (NR==1) {len=index($0, $1); }; print substr($0, len)}'
end
