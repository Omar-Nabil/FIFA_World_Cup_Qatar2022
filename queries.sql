--teams with most goals 
select team , sum(pm.goals) 
from player p join player_match pm on p.name = pm.name
group by p.team
order by sum(pm.goals) desc

--matches with most goals
select t1_name , t2_name , T1_score + t2_score as score
from Match 
order by score 

-- number of participations for each player 
select name , count(name) 
from play_match 
group by name 
order by count(name) desc

-- goalkeepers with most cleansheets 
select p.name , count(p.name) as clean_sheets
from player p , player_match pm , Match m  
where p.name = pm.name and pm.t1 = m.T1_name and pm.t2 = m.T2_name  
and pos = 'GK' and (p.team = m.T1_name and m.T2_score = 0 
or p.team = m.T2_name and m.T1_score = 0) 
group by p.name
order by count(p.name) desc

-- find names of players who played in the semi-final and show their teams
select p.name , p.team
from player p , player_match pm, knockout_matches km
where pm.name = p.name and pm.t1 = km.T1_name and pm.t2 = km.T2_name
and km.round = 4
order by p.team

-- name and nationality and age of the youngest manager 
select mgr_name , mgr_nationality , mgr_age 
from team 
where mgr_age <= (select min(mgr_age) from team)

-- all information about oldest player 
select * from player where dob <= (select min(dob) from player)

-- youngest 10 players 
select top 10 name ,  2022 - YEAR(dob) as age
from player 
order by dob desc

-- clubs with most players 
select club , count(name)
from player 
group by club 
order by COUNT(name) desc

-- average age of teams
select team , avg(2022 - YEAR(dob))
from player
group by team