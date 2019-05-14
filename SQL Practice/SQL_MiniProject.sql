/* The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name
  FROM country_club.Facilities
WHERE membercost != 0 

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT( name ) AS no_charge_facilities
FROM country_club.Facilities
WHERE membercost =0;

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid,
       name,
       membercost,
       monthlymaintenance
  FROM country_club.Facilities
WHERE membercost < (0.2 * monthlymaintenance);

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
  FROM country_club.Facilities
WHERE facid IN (1, 5);


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name,
       monthlymaintenance,
       CASE WHEN monthlymaintenance > 100 THEN 'expensive' 
            ELSE 'cheap' END AS category
  FROM country_club.Facilities;


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname,
       surname
  FROM country_club.Members
WHERE joindate IN (SELECT MAX(joindate) FROM country_club.Members);

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT fac_name.facility_name,
       CONCAT(member.firstname, ' ', member.surname) AS member_name
  FROM (
SELECT book.*,
       facility.name AS facility_name
  FROM country_club.Bookings book
  LEFT JOIN country_club.Facilities facility
  ON book.facid = facility.facid
WHERE book.facid IN (0,1)) fac_name
  LEFT JOIN country_club.Members member
  ON fac_name.memid = member.memid
ORDER BY 2;


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT name as facilityname,
       CONCAT(firstname,' ', surname) AS membername,
       CASE WHEN firstname = 'GUEST' THEN guestcost * slots
            ELSE membercost * slots END AS totalcost
  FROM country_club.Bookings book
  LEFT JOIN country_club.Facilities facility 
  ON book.facid = facility.facid
  LEFT JOIN country_club.Members member 
  ON book.memid = member.memid
WHERE CAST(starttime AS DATE) = '2012-09-14'
HAVING totalcost > 30
ORDER BY 3 DESC;


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT (SELECT fac.name AS facility_name
          FROM country_club.Facilities fac 
        WHERE book.facid = fac.facid) AS facility_name,
       (SELECT CONCAT(member.firstname, ' ', member.surname) as name
          FROM country_club.Members member
        WHERE book.memid = member.memid) AS member_name,
       (SELECT CASE WHEN book.memid = 0 THEN book.slots * fac.guestcost
                    ELSE book.slots * fac.membercost END AS total           
          FROM country_club.Facilities fac
        WHERE book.facid = fac.facid) AS total_cost
FROM country_club.Bookings book
WHERE CAST(book.starttime AS DATE) = '2012-09-14'
HAVING total_cost > 30;

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT facility.name as Facility,
       SUM(CASE WHEN book.memid = 0 THEN book.slots * facility.guestcost
            ELSE book.slots * facility.membercost END) as Revenue
  FROM country_club.Bookings book
  LEFT JOIN country_club.Facilities facility
  ON book.facid = facility.facid
  LEFT JOIN country_club.Members member
  ON book.memid = member.memid
GROUP BY 1
HAVING Revenue < 1000
ORDER BY 2
