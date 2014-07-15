path = '/Users/heymanhn/Dropbox/Zipfian_24hr/q1.txt'
open(path).readline()
data =open(path).read()
splt=data.split( );
#print splt

"""
Saved file as q1.txt. 
file contains the following format:
L#$KJ#()JSEFS(DF)(SD*F
#KJ$H#K$JH@#K$JHD)SF
SDFLKJ#{P@$OJ{SDPFODS{PFO{
#K$HK#JHSFHD(*SHF)SF{HP
#L$H@"#$H"@#L$KH#"@L$K
#~L$KJ#:$SD)FJ)S(DJF)(S
#$KJH#$
SDLKFJD(FJ)SDJFSDLFKS
~L#$KJ:@LK$#J$
LSJDF(S*JDF(*SJDF(*J(DSF*J

For every position in the string, find the breakdown (in percentage) for each symbol encountered. 
The goal of this exercise is to calculate the population percentages for each symbol in each position,
i.e.: what percentage of times do I see symbol X in position Y? 

sample output:
Position: 0 [('S', '20.0%'), ('#', '50.0%'), ('L', '20.0%'), ('~', '10.0%')]
Position: 1 [('#', '10.0%'), ('$', '10.0%'), ('K', '20.0%'), ('L', '20.0%'), ('D', '20.0%'), ('S', '10.0%'), ('~', '10.0%')]
Position: 2 [('#', '10.0%'), ('$', '30.0%'), ('F', '10.0%'), ('K', '10.0%'), ('J', '20.0%'), ('L', '20.0%')]
Position: 3 [('$', '30.0%'), ('H', '20.0%'), ('K', '20.0%'), ('J', '10.0%'), ('L', '10.0%'), ('D', '10.0%')]

etc

"""

from collections import defaultdict

#Find the length of the longest string
length=[]
for s in range(len(splt)):
        string= splt[s]
        length.append(len(string))
print 'max string length=',max(length)


# Loop through positions 0 through longest length of string, redefine a list called vertical that 
# takes the symbol at position i of string s (in this example we have strings 0 through 9)

for i in range(max(length)):
    vertical =[]
    for s in range(len(splt)):
        string= splt[s]
        if i < len(string):						#If current string becomes empty after position i, go to the next string
            vertical.append(string[i])
        else:
            s+=1
        #print s, vertical


    characters = list(set(vertical))			#Finds distinct symbols in list vertical
    d = defaultdict(int)				
    for v in vertical:
        d[v] += 1 								#Use defaultdict to count number of occurrences for each symbol

    total_len = float(sum(d.values()))
    print 'Position:', i,[(characters, str(num/total_len*100)+'%') for characters, num in d.items()]
    #print 'Position:', i,[(characters, num, str(num/total_len*100)+'%') for characters, num in d.items()]

