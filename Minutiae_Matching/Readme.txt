how to run the matchingV2_1.m file

1. extract all the text files into a directory
2. place these files also in the same directory into which the text files were extracted
3. Type the following command to run the finger print matching algorithm

[SimilarityMatrix Del] = matchingV2_1( a , b , theta_threshold, dir_threshold )

Where
————-—
a)SimilarityMatrix will have the <delX delY theta #ofMatches MatchScore>
b)a, b are the input text files i.e. ‘0101.txt’ or ‘0201.txt’
c)theta_threshold is the theta_not value for checking the directional threshold
d)dir_threshold is the r_not value for checking the spatial threshold
e)Del has a list of one +ve count for each match.(used for testing need not worry about this).

HOW TO RUN:
============


[SimilarityMatrix Del] = matchingV2_1(‘0101.txt’ , ’0102.txt’ , 10 , 15);

Demo :
=======


[SimilarityMatrix Del] = matchingV2_1('0101.txt','0102.txt',10,5);


*for more see demo1.m file.
