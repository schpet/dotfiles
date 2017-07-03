if !exists(':Tabularize')
  finish
endif

AddTabularPattern symbol /:/l1c0
AddTabularPattern \" /['"].*/l1
AddTabularPattern hash /,\zs/l0r1
