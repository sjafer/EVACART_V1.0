%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FTH.ma
% Author: Ryan Lawler
%
% Description: This model describes a follow the herd evacuation procedure
% for a mix of people who are familiar or unfamiliar with the surroundings. 
% Those unfamiliar with the surroundings will fall in line and follow 
% the people surrounding them.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[top]
components : FTH

[FTH]
type : cell
dim : (17, 17, 3)
delay : transport
defaultDelayTime : 1000
border : nowrapped

%Floor plane neighbors
neighbors : FTH(-2,-2,0) FTH(-2,-1,0) FTH(-2,0,0) FTH(-2,1,0) FTH(-2,2,0)
neighbors : FTH(-1,-2,0) FTH(-1,-1,0) FTH(-1,0,0) FTH(-1,1,0) FTH(-1,2,0)
neighbors : FTH(0,-2,0)  FTH(0,-1,0)  FTH(0,0,0)  FTH(0,1,0)  FTH(0,2,0)
neighbors : FTH(1,-2,0)  FTH(1,-1,0)  FTH(1,0,0)  FTH(1,1,0)  FTH(1,2,0)
neighbors : FTH(2,-2,0)  FTH(2,-1,0)  FTH(2,0,0)  FTH(2,1,0)  FTH(2,2,0)

%Distance plane neighbors. Plan to use the neighbors two cells away in order to determine direction
neighbors :                           FTH(-2,0,1)
neighbors :              FTH(-1,-1,1) FTH(-1,0,1) FTH(-1,1,1) 	
neighbors : FTH(0,-2,1)  FTH(0,-1,1)  FTH(0,0,1)  FTH(0,1,1)  FTH(0,2,1)
neighbors :              FTH(1,-1,1)  FTH(1,0,1)  FTH(1,1,1)
neighbors :                           FTH(2,0,1)  	

% Panic Transfer
neighbors : FTH(0,0,2)
neighbors : FTH(0,0,-2)

%Initialize Floor Map
initialvalue : 0
initialCellsValue : FTH.val

%Panic plane
zone : panic_plane  { (0,0,0)..(16,16,2) }

%Distance plane
zone : dist_plane 	{ (0,0,1)..(16,16,1) }

%Maze plane
zone : floor_plane 	{ (0,0,0)..(16,16,0) }

localtransition : fth-rule

[panic_plane]
%rule : {(0,0,-2)} 0 { t }

rule : {(0,0,0)} 1000 {15*(0,0,-2)=(0,0,0)}
rule : {(0,0,-2)*6} 1000 {3*(0,0,-2)=(0,0,0)}
rule : {(0,0,-2)*9} 1000 {6*(0,0,-2)=(0,0,0)}
rule : {(0,0,-2)*12} 1000 {9*(0,0,-2)=(0,0,0)}
rule : {(0,0,-2)*15} 1000 {12*(0,0,-2)=(0,0,0)}
rule : {(0,0,-2)*3} 1000 {(0,0,-2)>0}

rule : 0 1000 {(0,0,0)!=(0,0,-2)}

rule : {(0,0,0)}    1000 { t }


[dist_plane]
rule : {(0,0,0)}    1000 { t }

[floor_plane]

%Exit Building
rule : 0 1000 {(0,0,0)>0 and (0,0,0)<90 and ((0,1,0)=900 or (1,1,0)=900 or (1,0,0)=900 or (1,-1,0)=900 or (0,-1,0)=900 or (-1,-1,0)=900 or (-1,0,0)=900 or (-1,1,0)=900)}

%Change to panic state
%rule : {(0,0,0)+10000} 1000 {(0,0,0)>0 and (0,0,0)<900 and ((0,0,0)*9)=(0,0,2)}
rule : 1 1000 {(0,0,0)>0 and (0,0,0)<900 and ((0,0,0)*15)=(0,0,2)}


%Change State to follower
rule : 101 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(201)>0 or stateCount(210)>0)}
rule : 102 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(202)>0 or stateCount(220)>0)}
rule : 103 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(203)>0 or stateCount(230)>0)}
rule : 104 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(204)>0 or stateCount(240)>0)}
rule : 105 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(205)>0 or stateCount(250)>0)}
rule : 106 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(206)>0 or stateCount(260)>0)}
rule : 107 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(207)>0 or stateCount(270)>0)}
rule : 108 1000 {((0,0,0)>=1 and (0,0,0)<9) and (stateCount(208)>0 or stateCount(280)>0)}

%Change state to directional plane user
rule : 401 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(301)>0 or stateCount(401)>0)}
rule : 402 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(302)>0 or stateCount(402)>0)}
rule : 403 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(303)>0 or stateCount(403)>0)}
rule : 404 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(304)>0 or stateCount(404)>0)}
rule : 405 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(305)>0 or stateCount(405)>0)}
rule : 406 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(306)>0 or stateCount(406)>0)}
rule : 407 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(307)>0 or stateCount(407)>0)}
rule : 408 1000 {(((0,0,0)>=101 and (0,0,0)<=109) or ((0,0,0)>=201 and (0,0,0)<=209)) and (stateCount(308)>0 or stateCount(408)>0)}

%Unknowledgeable Person - Become Follower
rule : 110 1000 {(0,0,0)>=101 and (0,0,0)<109 and (-1,0,0)<=0 and ((-2,0,0)=201 or (0,2,0)=207 or (0,-2,0)=203 or (0,1,0)=207 or (0,-1,0)=203 or (-1,-1,0)=201 or (-1,1,0)=201 or (0,1,0)=270 or (0,-1,0)=230)}
rule : 120 1000 {(0,0,0)>=101 and (0,0,0)<109 and (-1,1,0)<=0 and ((-2,2,0)=202 or (2,2,0)=208 or (-2,-2,0)=204 or (1,1,0)=208 or (-1,-1,0)=204 or (-2,0,0)=202 or (0,2,0)=202 or (1,1,0)=280 or (-1,-1,0)=240)}
rule : 130 1000 {(0,0,0)>=101 and (0,0,0)<109 and (0,1,0)<=0 and ((0,2,0)=203 or (2,0,0)=201 or (-2,0,0)=205 or (1,0,0)=201 or (-1,0,0)=205 or (-1,1,0)=203 or (1,1,0)=203 or (1,0,0)=210 or (-1,0,0)=250)}
rule : 140 1000 {(0,0,0)>=101 and (0,0,0)<109 and (1,1,0)<=0 and ((2,2,0)=204 or (2,-2,0)=202 or (-2,2,0)=206 or (1,-1,0)=202 or (-1,1,0)=206 or (0,2,0)=204 or (2,0,0)=204 or (1,-1,0)=220 or (-1,1,0)=260)}
rule : 150 1000 {(0,0,0)>=101 and (0,0,0)<109 and (1,0,0)<=0 and ((2,0,0)=205 or (0,-2,0)=203 or (0,2,0)=207 or (0,-1,0)=203 or (0,1,0)=207 or (1,1,0)=205 or (1,-1,0)=205 or (0,-1,0)=230 or (0,1,0)=270)}
rule : 160 1000 {(0,0,0)>=101 and (0,0,0)<109 and (1,-1,0)<=0 and ((2,-2,0)=206 or (-2,-2,0)=204 or (2,2,0)=208 or (-1,-1,0)=204 or (1,1,0)=208 or (2,0,0)=206 or (0,-2,0)=206 or (-1,-1,0)=240 or (1,1,0)=280)}
rule : 170 1000 {(0,0,0)>=101 and (0,0,0)<109 and (0,-1,0)<=0 and ((0,-2,0)=207 or (-2,0,0)=205 or (2,0,0)=201 or (-1,0,0)=205 or (1,0,0)=201 or (1,-1,0)=207 or (-1,-1,0)=207 or (-1,0,0)=250 or (1,0,0)=210)}
rule : 180 1000 {(0,0,0)>=101 and (0,0,0)<109 and (-1,-1,0)<=0 and ((-2,-2,0)=208 or (-2,2,0)=206 or (2,-2,0)=202 or (-1,1,0)=206 or (1,-1,0)=202 or (0,-2,0)=208 or (-2,0,0)=208 or (-1,1,0)=260 or (1,-1,0)=220)}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Leader
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rule : 201 1000 {(0,0,0)>=1 and (0,0,0)<90 and (1,0,0)>=1 and (1,0,0)<90 and (-1,-1,0)<=0 and (-1,0,0)<=0 and (-1,1,0)<=0 and (0,1,0)<=0}
rule : 201 1000 {(0,0,0)>=1 and (0,0,0)<90 and (1,-1,0)>=1 and (1,-1,0)<90  and (-1,-1,0)<=0 and (-1,0,0)<=0 and (-1,1,0)<=0 and (0,1,0)<=0}
rule : 201 1000 {(0,0,0)>=1 and (0,0,0)<90 and (0,-1,0)>=1 and (0,-1,0)<90  and (-1,-1,0)<=0 and (-1,0,0)<=0 and (-1,1,0)<=0 and (0,1,0)<=0}
rule : 201 1000 {(0,0,0)>=1 and (0,0,0)<90 and (1,1,0)>=1 and (1,1,0)<90  and (-1,-1,0)<=0 and (-1,0,0)<=0 and (-1,1,0)<=0 and (0,1,0)<=0}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Merge Leader
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rule : 101 1000 {((0,0,0)>201 and (0,0,0)<=209 and stateCount(201)>0)}
rule : 102 1000 {((0,0,0)>202 and (0,0,0)<=209 and stateCount(202)>0)}
rule : 103 1000 {((0,0,0)>203 and (0,0,0)<=209 and stateCount(203)>0)}
rule : 104 1000 {((0,0,0)>204 and (0,0,0)<=209 and stateCount(204)>0)}
rule : 105 1000 {((0,0,0)>205 and (0,0,0)<=209 and stateCount(205)>0)}
rule : 106 1000 {((0,0,0)>206 and (0,0,0)<=209 and stateCount(206)>0)}
rule : 107 1000 {((0,0,0)>207 and (0,0,0)<=209 and stateCount(207)>0)}
%rule : 108 1000 {((0,0,0)>201 and (0,0,0)<=209 and stateCount(208)>0)}

%%%%%%%%%%%%%%%%%%%%%%%%%
%Random Movement
%%%%%%%%%%%%%%%%%%%%%%%%
%Get Direction
rule : {(randInt(7)+1)*10} 1000 {(0,0,0)>=1 and (0,0,0)<9}

%Enter Cell
rule : 1 1000 {(0,0,0)=0 and (1,0,0)=10}
rule : 2 1000 {(0,0,0)=0 and (1,-1,0)=20 and ((1,0,0)!=10 or (1,0,0)!=110)}
rule : 3 1000 {(0,0,0)=0 and (0,-1,0)=30 and ((1,0,0)!=10 or (1,-1,0)!=20 or (1,0,0)!=110 or (1,-1,0)!=120)}
rule : 4 1000 {(0,0,0)=0 and (-1,-1,0)=40 and ((1,0,0)!=10 or (1,-1,0)!=20 or (0,-1,0)!=30 or (1,0,0)!=110 or (1,-1,0)!=120 or (0,-1,0)!=130)}
rule : 5 1000 {(0,0,0)=0 and (-1,0,0)=50 and ((1,0,0)!=10 or (1,-1,0)!=20 or (0,-1,0)!=30 or (-1,-1,0)!=40 or (1,0,0)!=110 or (1,-1,0)!=120 or (0,-1,0)!=130 or (-1,-1,0)!=140)}
rule : 6 1000 {(0,0,0)=0 and (-1,1,0)=60 and ((1,0,0)!=10 or (1,-1,0)!=20 or (0,-1,0)!=30 or (-1,-1,0)!=40 or (-1,0,0)!=50 or (1,0,0)!=110 or (1,-1,0)!=120 or (0,-1,0)!=130 or (-1,-1,0)!=140 or (-1,0,0)!=150)}
rule : 7 1000 {(0,0,0)=0 and (0,1,0)=70 and ((1,0,0)!=10 or (1,-1,0)!=20 or (0,-1,0)!=30 or (-1,-1,0)!=40 or (-1,0,0)!=50 or (-1,1,0)!=60 or (1,0,0)!=110 or (1,-1,0)!=120 or (0,-1,0)!=130 or (-1,-1,0)!=140 or (-1,0,0)!=150 or (-1,1,0)!=160)}
rule : 8 1000 {(0,0,0)=0 and (1,1,0)=80 and ((1,0,0)!=10 or (1,-1,0)!=20 or (0,-1,0)!=30 or (-1,-1,0)!=40 or (-1,0,0)!=50 or (-1,1,0)!=60 or (0,1,0)!=70 or (1,0,0)!=110 or (1,-1,0)!=120 or (0,-1,0)!=130 or (-1,-1,0)!=140 or (-1,0,0)!=150 or (-1,1,0)!=160 or (0,1,0)!=170)}

%Leave Cell - Collision detection for Random and Followers
rule : 0 1000 {((0,0,0)=10 and (-1,0,0)=0)}
rule : 0 1000 {((0,0,0)=20 and (-1,1,0)=0 and (0,1,0)!=10 and (0,1,0)!=110)}
rule : 0 1000 {((0,0,0)=30 and (0,1,0)=0 and (1,1,0)!=10 and (1,0,0)!=20 and (1,1,0)!=110 and (1,0,0)!=120)}
rule : 0 1000 {((0,0,0)=40 and (1,1,0)=0 and (2,1,0)!=10 and (2,0,0)!=20 and (1,0,0)!=30 and (2,1,0)!=110 and (2,0,0)!=120 and (1,0,0)!=130)}
rule : 0 1000 {((0,0,0)=50 and (1,0,0)=0 and (2,0,0)!=10 and (2,-1,0)!=20 and (1,-1,0)!=30 and (0,-1,0)!=40 and (2,0,0)!=110 and (2,-1,0)!=120 and (1,-1,0)!=130 and (0,-1,0)!=140)}
rule : 0 1000 {((0,0,0)=60 and (1,-1,0)=0 and (2,-1,0)!=10 and (2,-2,0)!=20 and (1,-2,0)!=30 and (0,-2,0)!=40 and (0,-1,0)!=50 and (2,-1,0)!=110 and (2,-2,0)!=120 and (1,-2,0)!=130 and (0,-2,0)!=140 and (0,-1,0)!=150)}
rule : 0 1000 {((0,0,0)=70 and (0,-1,0)=0 and (1,-1,0)!=10 and (1,-2,0)!=20 and (0,-2,0)!=30 and (-1,-2,0)!=40 and (-1,-1,0)!=50 and (-1,0,0)!=60 and (1,-1,0)!=110 and (1,-2,0)!=120 and (0,-2,0)!=130 and (-1,-2,0)!=140 and (-1,-1,0)!=150 and (-1,0,0)!=160)}
rule : 0 1000 {((0,0,0)=80 and (-1,-1,0)=0 and (0,-1,0)!=10 and (0,-2,0)!=20 and (-1,-2,0)!=30 and (-2,-2,0)!=40 and (-2,-1,0)!=50 and (-2,0,0)!=60 and (-1,0,0)!=70 and (0,-1,0)!=110 and (0,-2,0)!=120 and (-1,-2,0)!=130 and (-2,-2,0)!=140 and (-2,-1,0)!=150 and (-2,0,0)!=160 and (-1,0,0)!=170)}

%Try Again
rule : 1 1000 {((0,0,0)=10 and (-1,0,0)!=0)}
rule : 1 1000 {((0,0,0)=20 and (-1,1,0)!=0)}
rule : 1 1000 {((0,0,0)=30 and (0,1,0)!=0)}
rule : 1 1000 {((0,0,0)=40 and (1,1,0)!=0)}
rule : 1 1000 {((0,0,0)=50 and (1,0,0)!=0)}
rule : 1 1000 {((0,0,0)=60 and (1,-1,0)!=0)}
rule : 1 1000 {((0,0,0)=70 and (0,-1,0)!=0)}
rule : 1 1000 {((0,0,0)=80 and (-1,-1,0)!=0)}

%Leader - Change Direction Exit
rule : 210 1000 {((0,0,0)>=201 and (0,0,0)<209 and (-2,0,0)=900)}
rule : 220 1000 {((0,0,0)>=201 and (0,0,0)<209 and (-2,2,0)=900)}
rule : 230 1000 {((0,0,0)>=201 and (0,0,0)<209 and (0,2,0)=900)}
rule : 240 1000 {((0,0,0)>=201 and (0,0,0)<209 and (2,2,0)=900)}
rule : 250 1000 {((0,0,0)>=201 and (0,0,0)<209 and (2,0,0)=900)}
rule : 260 1000 {((0,0,0)>=201 and (0,0,0)<209 and (2,-2,0)=900)}
rule : 270 1000 {((0,0,0)>=201 and (0,0,0)<209 and (0,-2,0)=900)}
rule : 280 1000 {((0,0,0)>=201 and (0,0,0)<209 and (-2,-2,0)=900)}

%Follower - Change Direction Exit
rule : 110 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((-2,0,0)=900)}
rule : 120 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((-2,2,0)=900)}
rule : 130 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((0,2,0)=900)}
rule : 140 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((2,2,0)=900)}
rule : 150 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((2,0,0)=900)}
rule : 160 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((2,-2,0)=900)}
rule : 170 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((0,-2,0)=900)}
rule : 180 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((-2,-2,0)=900)}

rule : 0 1000 {(0,0,0)>=101 and (0,0,0)<109 and ((-1,0,0)=900 or (-1,1,0)=900 or (0,1,0)=900 or (1,1,0)=900 or (1,0,0)=900 or (1,-1,0)=900 or (0,-1,0)=900 or (-1,-1,0)=900)}

%Leader - Keep Current Direction
rule : 210 1000 {(0,0,0)=201 and (-1,0,0)=0 and (-2,0,0)!=-1}
rule : 220 1000 {(0,0,0)=202 and (-1,1,0)=0 and (-2,2,0)!=-1}
rule : 230 1000 {(0,0,0)=203 and (0,1,0)=0 and (0,2,0)!=-1}
rule : 240 1000 {(0,0,0)=204 and (1,1,0)=0 and (2,2,0)!=-1}
rule : 250 1000 {(0,0,0)=205 and (1,0,0)=0 and (2,0,0)!=-1}
rule : 260 1000 {(0,0,0)=206 and (1,-1,0)=0 and (2,-2,0)!=-1} 
rule : 270 1000 {(0,0,0)=207 and (0,-1,0)=0 and (0,-2,0)!=-1 }
rule : 280 1000 {(0,0,0)=208 and (-1,-1,0)=0 and (-2,-2,0)!=-1} 

%Leader - Change Direction Wall
rule : 201 1000 {((0,0,0)=202 and (-2,2,0)=-1)}
rule : 202 1000 {((0,0,0)=203 and (0,2,0)=-1)}
rule : 203 1000 {((0,0,0)=204 and (2,2,0)=-1)}
rule : 204 1000 {((0,0,0)=205 and (2,0,0)=-1)}
rule : 205 1000 {((0,0,0)=206 and (2,-2,0)=-1)}
rule : 206 1000 {((0,0,0)=207 and (0,-2,0)=-1)} 
rule : 207 1000 {((0,0,0)=208 and (-2,-2,0)=-1)}
rule : 208 1000 {((0,0,0)=201 and (-2,0,0)=-1)} 

%Leader - Enter Cell
rule : 201 1000 {(0,0,0)=0 and (1,0,0)=210}
rule : 202 1000 {(0,0,0)=0 and (1,-1,0)=220}
rule : 203 1000 {(0,0,0)=0 and (0,-1,0)=230}
rule : 204 1000 {(0,0,0)=0 and (-1,-1,0)=240}
rule : 205 1000 {(0,0,0)=0 and (-1,0,0)=250}
rule : 206 1000 {(0,0,0)=0 and (-1,1,0)=260}
rule : 207 1000 {(0,0,0)=0 and (0,1,0)=270}
rule : 208 1000 {(0,0,0)=0 and (1,1,0)=280}

%Leader - Leave Cell
rule : 0 1000 {((0,0,0)=210 and (-1,0,0)=0) or ((0,0,0)=201 and (-1,0,0)=900)}
rule : 0 1000 {((0,0,0)=220 and (-1,1,0)=0) or ((0,0,0)=202 and (-1,1,0)=900)}
rule : 0 1000 {((0,0,0)=230 and (0,1,0)=0) or ((0,0,0)=203 and (0,1,0)=900)}
rule : 0 1000 {((0,0,0)=240 and (1,1,0)=0) or ((0,0,0)=204 and (1,1,0)=900)}
rule : 0 1000 {((0,0,0)=250 and (1,0,0)=0) or ((0,0,0)=205 and (1,0,0)=900)}
rule : 0 1000 {((0,0,0)=260 and (1,-1,0)=0) or ((0,0,0)=206 and (1,-1,0)=900)}
rule : 0 1000 {((0,0,0)=270 and (0,-1,0)=0) or ((0,0,0)=207 and (0,-1,0)=900)}
rule : 0 1000 {((0,0,0)=280 and (-1,-1,0)=0) or ((0,0,0)=208 and (-1,-1,0)=900)}

%Follower - Change Direction Exit
rule : 110 1000 {((0,0,0)>=101 and (0,0,0)<109 and (-2,0,0)=900)}
rule : 120 1000 {((0,0,0)>=101 and (0,0,0)<109 and (-2,2,0)=900)}
rule : 130 1000 {((0,0,0)>=101 and (0,0,0)<109 and (0,2,0)=900)}
rule : 140 1000 {((0,0,0)>=101 and (0,0,0)<109 and (2,2,0)=900)}
rule : 150 1000 {((0,0,0)>=101 and (0,0,0)<109 and (2,0,0)=900)}
rule : 160 1000 {((0,0,0)>=101 and (0,0,0)<109 and (2,-2,0)=900)}
rule : 170 1000 {((0,0,0)>=101 and (0,0,0)<109 and (0,-2,0)=900)}
rule : 180 1000 {((0,0,0)>=101 and (0,0,0)<109 and (-2,-2,0)=900)}

%Follower - Respond to Leader Direction Change
rule : 101 1000 {(0,0,0)=102 and stateCount(201)>0}
rule : 102 1000 {(0,0,0)=103 and stateCount(202)>0}
rule : 103 1000 {(0,0,0)=104 and stateCount(203)>0}
rule : 104 1000 {(0,0,0)=105 and stateCount(204)>0}
rule : 105 1000 {(0,0,0)=106 and stateCount(205)>0}
rule : 106 1000 {(0,0,0)=107 and stateCount(206)>0}
rule : 107 1000 {(0,0,0)=108 and stateCount(207)>0}
rule : 108 1000 {(0,0,0)=101 and stateCount(208)>0}

%Follower - Directly behind Leader
%rule : 110 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and ((-1,0,0)=208 or (-1,0,0)=202)}
%rule : 120 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and ((-1,1,0)=201 or (-1,1,0)=203)}
%rule : 130 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and ((0,1,0)=202 or (0,1,0)=204)}
%rule : 140 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and ((1,1,0)=203 or (1,1,0)=205)}
%rule : 150 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and (2,0,0)=0 and ((1,0,0)=204 or (1,0,0)=206)}
%rule : 160 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and (2,-2,0)=0 and ((1,-1,0)=205 or (1,-1,0)=207)}
%rule : 170 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and (0,-2,0)=0 and ((0,-1,0)=206 or (0,-1,0)=208)}
%rule : 180 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,0,0)=0 and (-2,-2,0)=0 and ((-1,-1,0)=207 or (-1,-1,0)=201)}

%Follower - Get Direction off Leader
rule : 110 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((-1,-1,0)=210 or (-1,0,0)=210 or (-1,1,0)=210 or (-2,-2,0)=210 or (-2,0,0)=210 or (-2,2,0)=210)}
rule : 120 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((-2,0,0)=220 or (-1,-1,0)=220 or (0,2,0)=220 or (-2,1,0)=220 or (-2,2,0)=220 or (-1,2,0)=220)}
rule : 130 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((-1,1,0)=230 or (0,1,0)=230 or (1,1,0)=230 or (-2,2,0)=230 or (0,2,0)=230 or (2,2,0)=230)}
rule : 140 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((0,2,0)=240 or (1,1,0)=240 or (2,0,0)=240 or (1,2,0)=240 or (2,2,0)=240 or (2,1,0)=240)}
rule : 150 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((1,1,0)=250 or (1,0,0)=250 or (1,-1,0)=250 or (2,2,0)=250 or (2,0,0)=250 or (2,-2,0)=250)}
rule : 160 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((2,0,0)=260 or (1,-1,0)=260 or (0,-2,0)=260 or (2,-1,0)=260 or (2,-2,0)=260 or (1,-2,0)=260)}
rule : 170 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((1,-1,0)=270 or (0,-1,0)=270 or (-1,-1,0)=270 or (2,-2,0)=270 or (0,-2,0)=270 or (-2,-2,0)=270)}
rule : 180 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((0,-2,0)=280 or (-1,-1,0)=280 or (-2,0,0)=280 or (-1,-2,0)=280 or (-2,-2,0)=280 or (-2,-1,0)=280)}

%Follower - Get Direction off Follower
rule : 110 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,-1,0)=230 and (-1,1,0)=270 and ((-1,-1,0)=110 or (-1,0,0)=110 or (-1,1,0)=110 or (-2,-1,0)=110 or (-2,0,0)=110 or (-2,1,0)=110)}
rule : 120 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((-2,0,0)=120 or (-1,1,0)=120 or (0,2,0)=120 or (-2,1,0)=120 or (-2,2,0)=120 or (-1,2,0)=120)}
rule : 130 1000 {((0,0,0)>=101 and (0,0,0)<109) and (-1,1,0)=250 and (1,1,0)=210 and ((-1,1,0)=130 or (0,1,0)=130 or (1,1,0)=130 or (-1,2,0)=130 or (0,2,0)=130 or (1,2,0)=130)}
rule : 140 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((0,2,0)=140 or (1,1,0)=140 or (2,0,0)=140 or (1,2,0)=140 or (2,2,0)=140 or (2,1,0)=140)}
rule : 150 1000 {((0,0,0)>=101 and (0,0,0)<109) and (1,1,0)=270 and (1,-1,0)=230 and ((1,1,0)=150 or (1,0,0)=150 or (1,-1,0)=150 or (2,1,0)=150 or (2,0,0)=150 or (2,-1,0)=150)}
rule : 160 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((2,0,0)=160 or (1,-1,0)=160 or (0,-2,0)=160 or (2,-1,0)=160 or (2,-2,0)=160 or (1,-2,0)=160)}
rule : 170 1000 {((0,0,0)>=101 and (0,0,0)<109) and (1,-1,0)=210 and (-1,-1,0)=250 and ((1,-1,0)=170 or (0,-1,0)=170 or (-1,-1,0)=170 or (1,-2,0)=170 or (0,-2,0)=170 or (-1,-2,0)=170)}
rule : 180 1000 {((0,0,0)>=101 and (0,0,0)<109) and ((0,-2,0)=180 or (-1,-1,0)=180 or (-2,0,0)=180 or (-1,-2,0)=180 or (-2,-2,0)=180 or (-2,-1,0)=180)}

%Follower - Carry On Direction
rule : 110 1000 {(0,0,0)=101 and (-1,0,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 120 1000 {(0,0,0)=102 and (-1,1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 130 1000 {(0,0,0)=103 and (0,1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 140 1000 {(0,0,0)=104 and (1,1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 150 1000 {(0,0,0)=105 and (1,0,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 160 1000 {(0,0,0)=106 and (1,-1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 170 1000 {(0,0,0)=107 and (0,-1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 180 1000 {(0,0,0)=108 and (-1,-1,0)=0 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}

rule : 170 1000 {((0,0,0)=108 or (0,0,0)=101 or (0,0,0)=102) and (-1,0,0)=-1 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 150 1000 {((0,0,0)=106 or (0,0,0)=107 or (0,0,0)=108) and (0,-1,0)=-1 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 130 1000 {((0,0,0)=104 or (0,0,0)=105 or (0,0,0)=106) and (1,0,0)=-1 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}
rule : 110 1000 {((0,0,0)=102 or (0,0,0)=103 or (0,0,0)=104) and (0,1,0)=-1 and (stateCount(201)=0 and stateCount(210)=0 and stateCount(202)=0 and stateCount(220)=0 and stateCount(203)=0 and stateCount(230)=0 and stateCount(204)=0 and stateCount(240)=0 and stateCount(205)=0 and stateCount(250)=0 and stateCount(206)=0 and stateCount(260)=0 and stateCount(207)=0 and stateCount(270)=0 and stateCount(208)=0 and stateCount(280)=0)}

%Follower - Enter Cell
rule : 101 1000 {(0,0,0)=0 and (1,0,0)=110}
rule : 102 1000 {(0,0,0)=0 and (1,-1,0)=120}
rule : 103 1000 {(0,0,0)=0 and (0,-1,0)=130}
rule : 104 1000 {(0,0,0)=0 and (-1,-1,0)=140}
rule : 105 1000 {(0,0,0)=0 and (-1,0,0)=150}
rule : 106 1000 {(0,0,0)=0 and (-1,1,0)=160}
rule : 107 1000 {(0,0,0)=0 and (0,1,0)=170}
rule : 108 1000 {(0,0,0)=0 and (1,1,0)=180}

%Follower - Leave Cell
rule : 0 1000 {((0,0,0)=110 and (-1,0,0)=0) or ((0,0,0)=101 and (-1,0,0)=900)}
rule : 0 1000 {((0,0,0)=120 and (-1,1,0)=0) or ((0,0,0)=102 and (-1,1,0)=900)}
rule : 0 1000 {((0,0,0)=130 and (0,1,0)=0) or ((0,0,0)=103 and (0,1,0)=900)}
rule : 0 1000 {((0,0,0)=140 and (1,1,0)=0) or ((0,0,0)=104 and (1,1,0)=900)}
rule : 0 1000 {((0,0,0)=150 and (1,0,0)=0) or ((0,0,0)=105 and (1,0,0)=900)}
rule : 0 1000 {((0,0,0)=160 and (1,-1,0)=0) or ((0,0,0)=106 and (1,-1,0)=900)}
rule : 0 1000 {((0,0,0)=170 and (0,-1,0)=0) or ((0,0,0)=107 and (0,-1,0)=900)}
rule : 0 1000 {((0,0,0)=180 and (-1,-1,0)=0) or ((0,0,0)=108 and (-1,-1,0)=900)}

%Follower - Blocked
rule : 101 1000 {(0,0,0)=110 and (-1,0,0)=-1}
rule : 102 1000 {(0,0,0)=120 and (-1,1,0)=-1}
rule : 103 1000 {(0,0,0)=130 and (0,1,0)=-1}
rule : 104 1000 {(0,0,0)=140 and (1,1,0)=-1}
rule : 105 1000 {(0,0,0)=150 and (1,0,0)=-1}
rule : 106 1000 {(0,0,0)=160 and (1,-1,0)=-1}
rule : 107 1000 {(0,0,0)=170 and (0,-1,0)=-1}
rule : 108 1000 {(0,0,0)=180 and (-1,-1,0)=-1}

%Follower - Stuck - Change Direction
rule : 110 1000 {(0,0,0)=101}
rule : 120 1000 {(0,0,0)=102}
rule : 130 1000 {(0,0,0)=103}
rule : 140 1000 {(0,0,0)=104}
rule : 150 1000 {(0,0,0)=105}
rule : 160 1000 {(0,0,0)=106}
rule : 170 1000 {(0,0,0)=107}
rule : 180 1000 {(0,0,0)=108}

%Follower - Leader's Direction
rule : 101 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(201)>0)}
rule : 102 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(202)>0)}
rule : 103 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(203)>0)}
rule : 104 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(204)>0)}
rule : 105 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(205)>0)}
rule : 106 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(206)>0)}
rule : 107 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(207)>0)}
rule : 108 1000 {(0,0,0)>=110 and (0,0,0)<190 and (stateCount(208)>0)}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Directional - Knows way out
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Keep Direction
rule : 310 1000 {(0,0,0)=301 and (0,0,1)=0}
rule : 320 1000 {(0,0,0)=302 and (0,0,1)=0}
rule : 330 1000 {(0,0,0)=303 and (0,0,1)=0}
rule : 340 1000 {(0,0,0)=304 and (0,0,1)=0}
rule : 350 1000 {(0,0,0)=305 and (0,0,1)=0}
rule : 360 1000 {(0,0,0)=306 and (0,0,1)=0} 
rule : 370 1000 {(0,0,0)=307 and (0,0,1)=0}
rule : 380 1000 {(0,0,0)=308 and (0,0,1)=0}

%Get Direction
rule : 310 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=1}
rule : 320 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=2}
rule : 330 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=3}
rule : 340 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=4}
rule : 350 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=5}
rule : 360 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=6} 
rule : 370 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=7}
rule : 380 1000 {(0,0,0)>=301 and (0,0,0)<309 and (0,0,1)=8} 

%Enter Cell
rule : 301 1000 {(0,0,0)=0 and (1,0,0)=310}
rule : 302 1000 {(0,0,0)=0 and (1,-1,0)=320}
rule : 303 1000 {(0,0,0)=0 and (0,-1,0)=330}
rule : 304 1000 {(0,0,0)=0 and (-1,-1,0)=340}
rule : 305 1000 {(0,0,0)=0 and (-1,0,0)=350}
rule : 306 1000 {(0,0,0)=0 and (-1,1,0)=360}
rule : 307 1000 {(0,0,0)=0 and (0,1,0)=370}
rule : 308 1000 {(0,0,0)=0 and (1,1,0)=380}

%Leave Cell
rule : 0 1000 {((0,0,0)=310 and (-1,0,0)=0) or ((0,0,0)=310 and (-1,0,0)=900)}
rule : 0 1000 {((0,0,0)=320 and (-1,1,0)=0) or ((0,0,0)=320 and (-1,1,0)=900)}
rule : 0 1000 {((0,0,0)=330 and (0,1,0)=0) or ((0,0,0)=330 and (0,1,0)=900)}
rule : 0 1000 {((0,0,0)=340 and (1,1,0)=0) or ((0,0,0)=340 and (1,1,0)=900)}
rule : 0 1000 {((0,0,0)=350 and (1,0,0)=0) or ((0,0,0)=350 and (1,0,0)=900)}
rule : 0 1000 {((0,0,0)=360 and (1,-1,0)=0) or ((0,0,0)=360 and (1,-1,0)=900)}
rule : 0 1000 {((0,0,0)=370 and (0,-1,0)=0) or ((0,0,0)=370 and (0,-1,0)=900)}
rule : 0 1000 {((0,0,0)=380 and (-1,-1,0)=0) or ((0,0,0)=380 and (-1,-1,0)=900)}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mob with Directional Plane Access
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Keep Direction
rule : 410 1000 {(0,0,0)=401 and (0,0,1)=0}
rule : 420 1000 {(0,0,0)=402 and (0,0,1)=0}
rule : 430 1000 {(0,0,0)=403 and (0,0,1)=0}
rule : 440 1000 {(0,0,0)=404 and (0,0,1)=0}
rule : 450 1000 {(0,0,0)=405 and (0,0,1)=0}
rule : 460 1000 {(0,0,0)=406 and (0,0,1)=0} 
rule : 470 1000 {(0,0,0)=407 and (0,0,1)=0}
rule : 480 1000 {(0,0,0)=408 and (0,0,1)=0}

%Get Direction
rule : 410 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=1}
rule : 420 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=2}
rule : 430 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=3}
rule : 440 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=4}
rule : 450 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=5}
rule : 460 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=6} 
rule : 470 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=7}
rule : 480 1000 {(0,0,0)>=401 and (0,0,0)<409 and (0,0,1)=8} 

%Go Around
%rule : 410 1000 {((0,0,0)=480 and (-1,-1,0)>=1 and (-1,-1,0)<900) or ((0,0,0)=420 and (-1,1,0)>=1 and (-1,1,0)<900)}
%rule : 420 1000 {((0,0,0)=410 and (-1,0,0)>=1 and (-1,0,0)<900) or ((0,0,0)=430 and (0,1,0)>=1 and (0,1,0)<900)}
%rule : 430 1000 {((0,0,0)=420 and (-1,1,0)>=1 and (-1,1,0)<900) or ((0,0,0)=440 and (1,1,0)>=1 and (1,1,0)<900)}
%rule : 440 1000 {((0,0,0)=430 and (0,1,0)>=1 and (0,1,0)<900) or ((0,0,0)=450 and (1,0,0)>=1 and (1,0,0)<900)}
%rule : 450 1000 {((0,0,0)=440 and (1,1,0)>=1 and (1,1,0)<900) or ((0,0,0)=460 and (1,-1,0)>=1 and (1,-1,0)<900)}
%rule : 460 1000 {((0,0,0)=450 and (1,0,0)>=1 and (1,0,0)<900) or ((0,0,0)=470 and (0,-1,0)>=1 and (0,-1,0)<900)}
%rule : 470 1000 {((0,0,0)=460 and (1,-1,0)>=1 and (1,-1,0)<900) or ((0,0,0)=480 and (-1,-1,0)>=1 and (-1,-1,0)<900)}
%rule : 480 1000 {((0,0,0)=470 and (0,-1,0)>=1 and (0,-1,0)<900) or ((0,0,0)=410 and (-1,0,0)>=1 and (-1,0,0)<900)}

%Enter Cell
rule : 401 1000 {(0,0,0)=0 and (1,0,0)=410}
rule : 402 1000 {(0,0,0)=0 and (1,-1,0)=420 and (1,0,0)!=410}
rule : 403 1000 {(0,0,0)=0 and (0,-1,0)=430 and ((1,0,0)!=410 or (1,-1,0)!=420)}
rule : 404 1000 {(0,0,0)=0 and (-1,-1,0)=440 and ((1,0,0)!=410 or (1,-1,0)!=420 or (0,-1,0)!=430)}
rule : 405 1000 {(0,0,0)=0 and (-1,0,0)=450 and ((1,0,0)!=410 or (1,-1,0)!=420 or (0,-1,0)!=430 or (-1,-1,0)!=440)} 
rule : 406 1000 {(0,0,0)=0 and (-1,1,0)=460 and ((1,0,0)!=410 or (1,-1,0)!=420 or (0,-1,0)!=430 or (-1,-1,0)!=440)}
rule : 407 1000 {(0,0,0)=0 and (0,1,0)=470 and ((1,0,0)!=410 or (1,-1,0)!=420 or (0,-1,0)!=430 or (-1,-1,0)!=440 or (-1,0,0)!=450 or (-1,1,0)!=460)}
rule : 408 1000 {(0,0,0)=0 and (1,1,0)=480 and ((1,0,0)!=410 or (1,-1,0)!=420 or (0,-1,0)!=430 or (-1,-1,0)!=440 or (-1,0,0)!=450 or (-1,1,0)!=460 or (0,1,0)!=470)}

%Leave Cell
rule : 0 1000 {(0,0,0)=410 and (-1,0,0)=0}
rule : 0 1000 {(0,0,0)=420 and (-1,1,0)=0 and (0,1,0)!=410}
rule : 0 1000 {(0,0,0)=430 and (0,1,0)=0 and (1,1,0)!=410 and (1,0,0)!=420}
rule : 0 1000 {(0,0,0)=440 and (1,1,0)=0 and (2,1,0)!=410 and (2,0,0)!=420 and (1,0,0)!=430}
rule : 0 1000 {(0,0,0)=450 and (1,0,0)=0 and (2,0,0)!=410 and (2,-1,0)!=420 and (1,-1,0)!=430 and (0,-1,0)!=440}
rule : 0 1000 {(0,0,0)=460 and (1,-1,0)=0 and (2,-1,0)!=410 and (2,-2,0)!=420 and (1,-2,0)!=430 and (0,-2,0)!=440 and (0,-1,0)!=450}
rule : 0 1000 {(0,0,0)=470 and (0,-1,0)=0 and (1,-1,0)!=410 and (1,-2,0)!=420 and (0,-2,0)!=430 and (-1,-2,0)!=440 and (-1,-1,0)!=450 and (-1,0,0)!=460}
rule : 0 1000 {(0,0,0)=480 and (-1,-1,0)=0 and (0,-1,0)!=410 and (0,-2,0)!=420 and (-1,-2,0)!=430 and (-2,-2,0)!=440 and (-2,-1,0)!=450 and (-2,0,0)!=460 and (-1,0,0)!=470}

rule : 0 1000 {(0,0,0)=410 and (-1,0,0)=900}
rule : 0 1000 {(0,0,0)=420 and (-1,1,0)=900}
rule : 0 1000 {(0,0,0)=430 and (0,1,0)=900}
rule : 0 1000 {(0,0,0)=440 and (1,1,0)=900}
rule : 0 1000 {(0,0,0)=450 and (1,0,0)=900}
rule : 0 1000 {(0,0,0)=460 and (1,-1,0)=900}
rule : 0 1000 {(0,0,0)=470 and (0,-1,0)=900}
rule : 0 1000 {(0,0,0)=480 and (-1,-1,0)=900}

rule : {(0,0,0)} 1000 { t }

[fth-rule]

rule : {(0,0,0)} 1000 { t }