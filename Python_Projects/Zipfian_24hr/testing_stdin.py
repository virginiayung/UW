#import sys, io
#string = "A line from the string as stdin IO \n This line wont be read"    # A line of text we'll use as stdin
#file = open('test.txt')   # A text file we'll use as stdin
#line = raw_input()    # Input from stdin, hopefully keyboard in this case
#print(line)
#sys.stdin = io.StringIO(string)    # Assigning stdin a File-like object from the string
#line = raw_input()    # Read a line from the stdin
#print(line)
#sys.stdin = file    # Assign stdin the file object, so it will read from it
#line = raw_input()    # Read a line from file
#print(line)


#sys.stdin = sys.__stdin__    # Reset the stdin to its default value




import sys, re
from collections import defaultdict, OrderedDict
from operator import itemgetter
#Initializing counter
sentences = 0
lines = 0 
word = 0
#print "Number of arguments: ", len(sys.argv)
# parse command line
# extra 4: The ability to accept input from STDIN, or from file specifid on the command line.
#command line file : cat test_mochi.txt| python testing_stdin.py
if len(sys.argv) > 1:
	f = open(sys.argv[1]).read()
else:
    f = sys.stdin.read()

print f


d = defaultdict(int)
for word in f.split():
    d[word] += 1
distinct_word = d.items()


#sentences = f.split('.')+f.split('!')+f.split('?') does not work since we have two !!
sentences = [s.strip() for s in re.split('[\.\?!]', f) if s]
lines = f.split('\n')


print 'Total Word Count =', len(f.split())	#same as int(sum(d.values()))
print 'Unique word count =',len(distinct_word)
print 'Number of Sentences =', len(sentences)
print 'Number of Lines =', len(lines),'\n'

print 'extra 1: Average Word Count in Sentence =', float(len(f.split())/len(sentences))


W = re.findall(r"[\w']+", f)
print 'W=', '\n', W, '\n'
print len(W)

def phrases(w):
        phrase = []
        for w in W:
            p = phrase.append(w)
            if len(phrase) > 3:
                phrase.remove(phrase[0])
            if len(phrase) == 3:
                yield tuple(phrase)

#print 'list of phrases',list(phrases(W)), '\n'

Phrases = defaultdict(int)
for p in phrases(W):
        Phrases[p] += 1

sorted_phrases=sorted(Phrases.items(),key=itemgetter(1), reverse =True)
print 'extra 2: sorted phrases by count', '\n', sorted_phrases, '\n'

s =sorted(d.items(),key=itemgetter(1), reverse =True)
print "extra 3: List of Words in Descending Count:",'\n', s, '\n'








