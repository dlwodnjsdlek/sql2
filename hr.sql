select last_name, hire_date, to_char(hire_date, 'day') day,
         decode (to_char(hire_date, 'fmday'), 
                'monday',    1,
                'tuesday',   2,
                'wednesday', 3,
                'thursday',  4,
                'friday',    5,
                'saturday',  6,
                 'sunday', 7) num
from employees
order by 4;

select last_name, hire_date, to_char(hire_date, 'day'),
    case to_char(hire_date, 'day')
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end day
from employees
order by day;