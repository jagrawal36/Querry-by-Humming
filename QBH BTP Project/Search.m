function leaf_index = Search(RTree, query,M,dimension)

entity=cell(2+dimension,1);
entity(1)={1};

for j = 2:dimension+1
    entity(j)={query(j-1)};
end
entity(2+dimension)={1};

leaf_index = ChooseLeaf(RTree, 1, entity, M, dimension, 1e+20);

end
