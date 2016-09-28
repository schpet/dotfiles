if !exists(':Tabularize')
  finish 
endif

AddTabularPattern symbol /:/l1c0
AddTabularPattern \" /['"].*/l1
