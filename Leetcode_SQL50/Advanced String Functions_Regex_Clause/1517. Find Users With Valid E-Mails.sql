
--ignore every things that is not included in the sqaure bracket
select *
FROM Users
WHERE mail like '[a-zA-Z]%@leetcode.com'
AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^0-9a-zA-Z_.-]%';


-- --or using regex in mysql (not supported by MS server)
-- SELECT user_id, name, mail FROM Users
-- WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode[.]com'