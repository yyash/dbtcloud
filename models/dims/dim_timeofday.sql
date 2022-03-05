{{ config(materialized='table') }}

select 
        TIME_PK as TIMEOFDAY_KEY, 
        HOUR_24 as TIMEOFDAY_24HR,
        HOUR_12 as TIMEOFDAY_12HR,
        HOUR_1 as HROFDAY,
        MINUTE_1 as MINOFDAY
from 
		
		(select 
			TIMEADD(minute, SEQ4(), '2017-01-01 00:00:00') as TEMP_TIMESTAMP,  
            seq4() as TEMP_SEQUENCE,
			row_number() over (order by TEMP_SEQUENCE) as TIME_PK,
            to_time(to_char(TEMP_TIMESTAMP,'HH24:MI:00'),'HH24:MI:00') HOUR_24,
            to_char(TEMP_TIMESTAMP,'HH12:MI:00 PM') HOUR_12,
         hour(TEMP_TIMESTAMP) as HOUR_1,
         minute(TEMP_TIMESTAMP) as MINUTE_1
   		from table(generator(rowcount => 1440))
            
        )
