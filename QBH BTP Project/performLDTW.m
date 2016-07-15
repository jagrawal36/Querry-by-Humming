function [LDTW_distance,p] = performLDTW(database, RTree,query,M,dimension)
tic
[dr,dc] = size(database);
[qr,qc] = size(query);
LDTW_distance =zeros(dr*qr, 1);
p=1;
for i = 1:qr    
    q = query(i,:);
    leaf_index  = Search(RTree,q,M,dimension);
    for j = 1:M
        if cell2mat(RTree(leaf_index, 1+dimension*2+j)) ~=-1
            d = database(cell2mat(RTree(leaf_index,1+dimension*2+j)),:);
            LDTW_distance(p)= LDTW(q,1,d,1,2);
            p=p+1;
        end
    end
    
end
toc
end


        
