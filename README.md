# Amazon_Vine_Analysis-17

Overview:
This analysis looks at the Amazon's Vine program. The Amazon Vine program is a service that allows manufacturers and publishers to receive reviews for their products. In this project we are analyzing the US Automative review dataset. First we use PySpark to perform teh ETL process and then we use SQL to determine if there are any bias toward favorable reviews from Vine members in the dataset.  

Dataset = https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Automotive_v1_00.tsv.gz

Results:

There are over 3M records in the vine_table, a cleansing process is applied to ensure we look at reviews that are helpful and avoid having division by zero errors. First we filter out total votes that are less than 20, then we divide the helpful votes by total votes and only look at results that are equal or greater than 50% to ensure the data is meaningful. Lastly we look at paid and unpaid reviews and look for bias between the two. 

Total meaningful data (helpful_votes/total_votes) >=0.5 count = 24,824
Total paid reviewer count = 82
Total unpaid review count = 24742

Total 5 star review count = 12840
Total paid 5 star review count = 33
Total unpaid 5 star review count = 12807

%age of paid 5 star review = 40%
%age of unpaid 5 star review = 52%

Summary:
In conclusion there is no bias when looking at 5 star reviewing ratings. But to ensure we don't misrepresent the dataset we should also look at non 5 star reviews as well. 


