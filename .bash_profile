echo -e "\e[95m   _____ __             __                   ___          ____  _ \e[39m"
echo -e "\e[95m  / ___// /_____ ______/ /   ____  _________/ ( )_____   / __ \(_)\e[39m"
echo -e "\e[95m  \__ \/ __/ __ \`/ ___/ /   / __ \/ ___/ __  /|// ___/ / /_/ / / \e[39m"
echo -e "\e[95m ___/ / /_/ /_/ / /  / /___/ /_/ / /  / /_/ /  (__  )  / ____/ /  \e[39m"
echo -e "\e[95m/____/\__/\__,_/_/  /_____/\____/_/   \__,_/  /____/  /_/   /_/   \e[39m"
echo -e "\e[95m                                                                  \e[39m"

let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %B %e %Y, %r"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.    
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
( : '~'.~.'~' : ) Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Running Processes..: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   IP Addresses.......: `/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1` and `wget -q -O - http://icanhazip.com/ | tail`
   '~ .~~~. ~'    Free Disk Space....: `df -Pk | grep -E '^/dev/sda1' | awk '{ print $4 }' | awk -F '.' '{ print $1 }'`k on /dev/sda1
       '~'        Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=2&locCode=75189" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
$(tput sgr0)"
