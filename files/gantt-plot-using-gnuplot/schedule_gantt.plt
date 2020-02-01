# schedule plot thesis/dissertation proposal
#
reset
set termoption dash
set terminal pngcairo  background "#ffffff" fontscale 1.0 dashed size 740, 480
set termoption enhanced
# set bmargin 7
#
# ----------------------------------------------------------------------------------------
# line types, point types and explicit rgbcolor names
# ----- line spec -----
#  lt   : 1;  2; 3;  4;  5;
#  style: -; --; .; -.; -:
#
# ----- point spec -----
#  pt   : 1; 2; 3;      4;      5; 6;      7; 8;      9; 10;      11; 12;     13;
#  style: +; x; *; square; 4-fill; o; 6-fill; ^; 8-fill;  v; 10-fill; <>;12-fill;
#
# ----- color spec -----
#  black, dark-grey, grey[10-10-100],
#  red, dark-red, light-red, magenta, coral, light-coral, orange-red, dark-magenta, light-magenta
#  green, dark-green, spring-green, forest-green, sea-green, web-green, light-green, dark-spring-green
#  blue, dark-blue, midnight-blue, web-blue, royalblue, medium-blue, light-blue, aquamarine,
#        navy,  skyblue, cyan, dark-cyan, light-cyan
#  yellow, goldenrod, light-goldenrod,
#  purple, dark-chartreuse, orchid, brown
#  khaki, dark-khaki
# ----------------------------------------------------------------------------------------

# --- custom variables
completed = 0x000000;# 0xFFE599;
uncompleted = 0xD5D1D1; # 0xF1C232;

set style arrow 1 heads back filled lt 2 lc rgb "red" lw 2
set style arrow 2 heads back nofilled lt 3 lc rgb "red" lw 2  size screen 0.008,90.000,90.000
set style arrow 3 heads filled  lt 1 lc rgb "red" lw 2 size screen 0.025,30,45
set style arrow 4 nohead nofilled dt 2 lc rgb "red" lw 2
set style arrow 5 heads noborder lc rgb "red" lw 2 size screen 0.03,15,135
set style arrow 6 heads empty lc rgb "red" lw 2 size screen 0.03,15,135
set style arrow 7 nohead back nofilled lc rgb "red" lw 2

# --- schedule data
# category        start    end   status
$SCHEDULES << EOD 
"event 1"             0     14     OPEN
"event 2"            11     13     OPEN
catota                3     10   CLOSED
"something else"      4      8   CLOSED
giroscópio            7     13     OPEN
"event 3"            13     15     OPEN
research              0     24     OPEN
research              0     12   CLOSED
"event 1"             0     12   CLOSED
"event 2"            11     12   CLOSED
giroscópio            7     12   CLOSED
EOD

# set output
set output "scheduleThesisGantt.png"

# disable legend
unset key

# grid and tics
set mxtics 
set mytics
set grid xtics
set grid ytics
set grid mxtics

# create list of keys
List = ''
set table $Dummy
    plot $SCHEDULES u (List=List.'"'.strcol(1).'" ',NaN) w table
unset table
# print List

# create list of unique keys (events)
scheduleList = ''
do for [i=1:words(List)] {
    item = word(List,i)
    found = 0
    do for [j=1:words(scheduleList)] {
        if (item eq word(scheduleList,j)) { found=1; break }
    }
    if (!found) { scheduleList = scheduleList.'"'.item.'" '}}
# print scheduleList  # test

# define functions for lookup/index and color
Lookup(s) = (Index = NaN, sum [i=1:words(scheduleList)] \
    (Index = s eq word(scheduleList,i) ? i : Index,0), Index)
# print Lookup("research") # little testiculus

Color(s) = s eq "CLOSED" ?  completed : uncompleted

# set range of x-axis and y-axis
set xrange [-1:]
set yrange [0.5:words(scheduleList)+0.5]

# set xlabel
set xlabel "semesters"

# set today
today = 12

set arrow from today, 0.5 to today,words(scheduleList)+0.5 as 7

plot $SCHEDULES u 2:(Idx=Lookup(strcol(1))): 3 : 2 :(Idx-0.2):(Idx+0.2): \
    (Color(strcol(4))): ytic(strcol(1)) w boxxyerror fill solid 0.7 lw 2.0 lc rgb var notitle
