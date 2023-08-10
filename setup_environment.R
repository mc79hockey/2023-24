    require(tidyverse)
    require(keyring)
    require(networkD3)
    require(RPostgreSQL)
    require(usethis)
    
    drv <- dbDriver('PostgreSQL')
    con <- dbConnect(
      drv,
      host = key_get('puddy','puddy_host_name'),
      port = 5432,
      user = 'puddy_admin',
      db = 'puddy',
      password = key_get('puddy','puddy_admin')
    )
    
    age = function(from, to) {
      from_lt = as.POSIXlt(from)
      to_lt = as.POSIXlt(to)
      
      age = to_lt$year - from_lt$year
      
      ifelse(to_lt$mon < from_lt$mon |
               (to_lt$mon == from_lt$mon & to_lt$mday < from_lt$mday),
             age - 1, age)
    }
