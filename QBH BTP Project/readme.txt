To run a test
-------------------

1--> Record a query of, say 5 seconds, using function:

		query=wavrecord(220500,44100);

2--> The database (indexed in R Tree) is already saved as 'indexedDatabase.mat'

3--> Call the function:

	distance = executeQBH(query, 'indexedDatabase.mat');

4--> The distance matrix computed shows the number of segments with distance 0 in first column,
     number of segments with distance 1 in second column, and so on.

5--> The row having greatest number of segments with distance 0 and 1 is the row in database which is
     identified as melody hummed by user.

6--> The database folder can be found in the project folder. A file 'sample.mid' contains the original
     midi file and 'sample_next.mid' contains the melody extracted from midi file.