function [distance] = executeQBH(sig, index_file)

load(index_file, 'RTree1','track_RTree1','database1', 'RTree2','track_RTree2','database2', 'RTree3','track_RTree3','database3', 'RTree4','track_RTree4','database4', 'RTree5','track_RTree5','database5', 'RTree6','track_RTree6','database6', 'RTree7','track_RTree7','database7', 'RTree8','track_RTree8','database8', 'RTree9','track_RTree9','database9', 'RTree10','track_RTree10','database10');

[LDTW_distance1,p1] = performLDTW(database1, RTree1,query_data,200,3);
[LDTW_distance2,p2] = performLDTW(database2, RTree2,query_data,200,3);
[LDTW_distance3,p3] = performLDTW(database3, RTree3,query_data,200,3);
[LDTW_distance4,p4] = performLDTW(database4, RTree4,query_data,200,3);
[LDTW_distance5,p5] = performLDTW(database5, RTree5,query_data,200,3);
[LDTW_distance6,p6] = performLDTW(database6, RTree6,query_data,200,3);
[LDTW_distance7,p7] = performLDTW(database7, RTree7,query_data,200,3);
[LDTW_distance8,p8] = performLDTW(database8, RTree8,query_data,200,3);
[LDTW_distance9,p9] = performLDTW(database9, RTree9,query_data,200,3);
[LDTW_distance10,p10] = performLDTW(database10, RTree10,query_data,200,3);

distance = zeros(10,4);

distance(1,1)=sum(LDTW_distance1(1:p1-1)==0);
distance(1,2)=sum(LDTW_distance1(1:p1-1)==1);
distance(1,3)=sum(LDTW_distance1(1:p1-1)==2);
distance(1,4)=sum(LDTW_distance1(1:p1-1)==3);

distance(2,1)=sum(LDTW_distance2(1:p2-1)==0);
distance(2,2)=sum(LDTW_distance2(1:p2-1)==1);
distance(2,3)=sum(LDTW_distance2(1:p2-1)==2);
distance(2,4)=sum(LDTW_distance2(1:p2-1)==3);

distance(3,1)=sum(LDTW_distance3(1:p3-1)==0);
distance(3,2)=sum(LDTW_distance3(1:p3-1)==1);
distance(3,3)=sum(LDTW_distance3(1:p3-1)==2);
distance(3,4)=sum(LDTW_distance3(1:p3-1)==3);

distance(4,1)=sum(LDTW_distance4(1:p4-1)==0);
distance(4,2)=sum(LDTW_distance4(1:p4-1)==1);
distance(4,3)=sum(LDTW_distance4(1:p4-1)==2);
distance(4,4)=sum(LDTW_distance4(1:p4-1)==3);

distance(5,1)=sum(LDTW_distance5(1:p5-1)==0);
distance(5,2)=sum(LDTW_distance5(1:p5-1)==1);
distance(5,3)=sum(LDTW_distance5(1:p5-1)==2);
distance(5,4)=sum(LDTW_distance5(1:p5-1)==3);

distance(6,1)=sum(LDTW_distance6(1:p6-1)==0);
distance(6,2)=sum(LDTW_distance6(1:p6-1)==1);
distance(6,3)=sum(LDTW_distance6(1:p6-1)==2);
distance(6,4)=sum(LDTW_distance6(1:p6-1)==3);

distance(7,1)=sum(LDTW_distance7(1:p7-1)==0);
distance(7,2)=sum(LDTW_distance7(1:p7-1)==1);
distance(7,3)=sum(LDTW_distance7(1:p7-1)==2);
distance(7,4)=sum(LDTW_distance7(1:p7-1)==3);

distance(8,1)=sum(LDTW_distance8(1:p8-1)==0);
distance(8,2)=sum(LDTW_distance8(1:p8-1)==1);
distance(8,3)=sum(LDTW_distance8(1:p8-1)==2);
distance(8,4)=sum(LDTW_distance8(1:p8-1)==3);

distance(9,1)=sum(LDTW_distance9(1:p9-1)==0);
distance(9,2)=sum(LDTW_distance9(1:p9-1)==1);
distance(9,3)=sum(LDTW_distance9(1:p9-1)==2);
distance(9,4)=sum(LDTW_distance9(1:p9-1)==3);

distance(10,1)=sum(LDTW_distance10(1:p10-1)==0);
distance(10,2)=sum(LDTW_distance10(1:p10-1)==1);
distance(10,3)=sum(LDTW_distance10(1:p10-1)==2);
distance(10,4)=sum(LDTW_distance10(1:p10-1)==3);

end