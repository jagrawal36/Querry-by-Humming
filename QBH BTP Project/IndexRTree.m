function [RTree,track_RTree] = IndexRTree(database, M,m)

% Assuming a three dimensional R Tree as we have used three dimensions for
% representing the data in the database from MIDI file

max_dimension = 9999;
track_RTree = 2;
[no_of_segments, dimension] = size(database);

RTree = cell(max_dimension, 1+dimension*2+M+1);
RTree(1,1)={-1};
RTree(2,1)={-1};
for i = 2:dimension*2+1;
    RTree(1,i)={0}; 
end
k=2;
for i = 1:dimension
    RTree(2,k)={database(1,i)};
    RTree(2,k+1)={database(1,i)};
    k=k+2;
end
RTree(1,1+dimension*2+1)={2};
RTree(2,1+dimension*2+1)={-1};
for i=1+dimension*2+2:1+dimension*2+M
    RTree(1,i)={-1};
    RTree(2,i)={-1};
end
RTree(1,1+dimension*2+M+1)={0};
RTree(2,1+dimension*2+M+1)={-1};


entity=cell(2+dimension,1);
entity(1)={1};
for i = 1:M
    for j = 2:dimension+1
        entity(j)={database(i,j-1)};
    end
    entity(2+dimension)={i};
    [RTree, track_RTree] = insertIntoRTree(database, RTree, track_RTree, entity, M,m, dimension);
end
%indexing first
RTree(2,1+dimension*2+M)={1};

for i = 2:dimension*2+1
    RTree(1,i) = RTree(2,i);
end

% initialization finished
entity=cell(2+dimension,1);
entity(1)={1};
for i=M+1:length(database)
    for j = 2:dimension+1
        entity(j)={database(i,j-1)};
    end
    entity(2+dimension)={i};
    [RTree, track_RTree] = insertIntoRTree(database, RTree, track_RTree, entity, M,m, dimension);
end
end






