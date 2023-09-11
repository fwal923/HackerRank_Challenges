/*
You are given three tables: Students, Friends and Packages.
Students contains two columns: ID and Name.
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend).
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

Write a query to output the names of those students whose best friends got offered a higher salary than them.
Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

*/

/*
goal:
output students whose best friend has higher salary

order by:
salary amount offered

students: id - name
friends: id (match on students.id and packages.id) - friend_id (= id of only best friend, match on students/packages.id also)
packages: id (match on students.id and friends.id) - salary

need to:
look at the salary for the id and salary for the friend_id.
if friend_id is higher then output the name for id (from students)

*/

with salary_student as
(select 
    f.id as s_id,
    salary as s_salary,
    rank() over (order by f.id) as student_rank
    from
    packages p
    join friends f on p.id = f.id),

salary_friend as
(select
    f.id as f_id,
    salary as f_salary,
    rank() over (order by f.id) as friends_rank
    from
    packages p
    join friends f on p.id = f.friend_id)

select
name
from
students s
join salary_student st on s.id = st.s_id
join salary_friend fr on s.id = fr.f_id
where student_rank = friends_rank and st.s_salary < fr.f_salary
order by fr.f_salary
