 --(1)  Find the five oldest users that exists on instagram

 SELECT *
 FROM users 
 ORDER BY created_at
 LIMIT 5;



 --(2)  Find the users who have never posted a single photo on instagram 

 SELECT username 
 FROM users 
 LEFT JOIN photos 
    ON users.id = photos.user_id
 WHERE photos.id IS NULL;



 --(3)  USer who get most likes on a single photo on instagram

 SELECT 
     photos.id,
     photos.image_url,
     COUNT(*) AS total 
 FROM photos 
 INNER JOIN likes
     ON likes.photo_id = photos.id
 INNER JOIN users 
     ON photos.user_id = users.id
 GROUP BY photos.id
 ORDER BY total DESC
 LIMIT 1;


 --(4)  Top five most commonly used hashtags on the platform

 SELECT 
     tags.tag_name,
     COUNT(*) as total
 FROM photo_tags
 JOIN tags
     ON photo_tags.tag_id = tags.id
 GROUP BY tags.id 
 ORDER BY total DESC 
 LIMIT 5;



 --(5)  What day of the week do most users register on ?

 SELECT 
     DAYNAME(created_at) AS day,
     COUNT(*) AS total
 FROM users 
 GROUP BY day 
 ORDER BY total DESC 
 LIMIT 1;

 --(6)  Average user posts on instagram. Also, provide the total number of photos on instagram and total number of users

       -- total numbers of photos
       SELECT COUNT(*) FROM photos;

       -- total number of users
       SELECT COUNT(*) FROM users;

       -- average user posts on instagram
       SELECT
            (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);


 --(7)  Provide data on bots, who have liked every single photo on the site

 SELECT 
     username,
     COUNT(*) AS num_likes
 FROM users 
 INNER JOIN likes 
     on users.id = likes.user_id
 GROUP BY likes.user_id 
 HAVING num_likes = (SELECT COUNT(*) FROM photos)  