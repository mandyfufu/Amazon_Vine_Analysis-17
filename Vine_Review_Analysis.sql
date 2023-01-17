CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

select count(*) from vine_table;  -- 3514942
select * from vine_table limit 10;

-- STEP 1
CREATE TABLE vine_filtered AS SELECT * FROM vine_table WHERE total_votes >= 20;
SELECT count(*) FROM vine_filtered; -- 27014
select * from vine_filtered limit 10;

-- STEP 2
CREATE TABLE vine_helpful AS SELECT * FROM vine_filtered WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;
SELECT count(*) FROM vine_helpful;  -- 24824

-- STEP 3
CREATE TABLE vine_paid AS SELECT * FROM vine_helpful WHERE vine = 'Y';
SELECT count(*) FROM vine_paid; -- 82

-- Step 4
CREATE TABLE vine_unpaid AS SELECT * FROM vine_helpful WHERE vine = 'N';
SELECT count(*) FROM vine_unpaid; -- 24742

-- Step 5 => total # of reviews  
select count(*) from vine_helpful;  -- 24824 total views 

-- # of 5 star reveiws
select count(*) from vine_helpful where star_rating >=5; 12840 -- total 5 star reviews 
(select count(review_id) from vine_helpful where vine='Y' and star_rating >=5); 33 -- total 5 star paid reviews
(select count(review_id) from vine_helpful where vine='N' and star_rating >=5); 12807 -- total 5 star unpaid reviews

-- % of 5 stars for paid reviews
select (paid_five_star/paid_reviews)*100 as paid_five_star_pct from
	(select cast(count(review_id) as float) as paid_five_star from vine_helpful where vine='Y' and star_rating >=5) as aa
	inner join 
	(select cast(count(review_id) as float) as paid_reviews from vine_helpful where vine='Y') as bb
	on 1=1  -- 40.243902439024396

-- % 5 star unpaid reviews
select (unpaid_five_star/unpaid_reviews)*100 as unpaid_five_star_pct from
	(select cast(count(review_id) as float) as unpaid_five_star from vine_helpful where vine='N' and star_rating >=5) as aa
	inner join 
	(select cast(count(review_id) as float) as unpaid_reviews from vine_helpful where vine='N') as bb
	on 1=1  -- 51.76218575701237
  

