def add_time(start, duration, day_in_week=None):
    time, part_of_day = start.split()
    minute, hour, part, day = Time_adder(time,duration,part_of_day)
    
    format = f"{hour}:{minute} {part}"
    if day_in_week != None:
        cformat = day_name(day_in_week,format,day)
        dformat = day_cal(day,cformat)
    else:
        dformat = day_cal(day,format)
    
    return dformat

def Time_adder(t, d, p):
    hour, minute = t.split(":")
    dhour, dminute = d.split(":")
    m = (int(minute)+int(dminute)) % 60
    holder = (int(hour) + int(dhour)) + (int(minute)+int(dminute)) //60
    h = 12 if holder % 12 == 0 else holder % 12
    day = holder // 24 
    
    if p == "AM" and holder >= 24:
      part = p
    elif p == "PM" and holder >= 12:
        part = "AM"
        day += 1
    elif p == "AM" and holder >= 12:
      part = "PM"
    else:
      part = p
    
    return str(m).rjust(2,"0") ,h ,part,day

def day_cal(day,format):
    if day == 1 :
        nformat = f"{format} (next day)"
    elif day > 1:
        nformat = f"{format} ({day} days later)"
    else:
        nformat = format
    return nformat


def day_name(diw,f,day):
    week = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    if day == 0:
        nformat = f"{f}, {diw}"
    elif day > 0:
        index = week.index(diw.capitalize())
        nindex = (index + day) % 7
        nformat = f"{f}, {week[nindex]}"
    return nformat
