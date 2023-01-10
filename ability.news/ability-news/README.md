Welcome to ability-news.
==

- This is the `landing page`. https://sites.google.com/view/abilitynews/project/objective

- This is the ip address of the ability.news website, if you are interested in it, you can hava a look: http://47.103.139.22/

- The project has two versions, one is using the Node.js (the website on the server is using this version, you can find it under "AbilityNews" folder), while the other one is using the SpringBoot (this version is still in updating, you can find it under "spring" folder).

- The main folder is just for the team to make changes, if the changes are approved by all team members, it will be merged to the "AbilityNews" folder, so not necessary to look at this one


NODE.JS + EXPRESS + BOOTSTRAP + MYSQL
==

Functions:
==
1. User Management
2. Admin Management
3. Topic Management
4. Banner Management
5. News Management
6. Comment Management
7. System Management


Directory:
==
1. node_modules: module packge
2. config: database configuration
3. views: static web page
4. public: static resource for web page
5. upload: resource for downloading and uploading   
6. router: router files
7. app.js: entrance file for website
8. package.json


How to run AbilityNews locally?
==
1. You have Node.js downloaded on your local computer
2. Download the  [Database file](https://abilitynewsweb.atlassian.net/wiki/spaces/PCS/pages/613580811/Database+file+for+running)
3. Create the database, with account name: root/ and password: 123456
4. Open the database and pull the code from the gitlab
5. get into the direcory where app.js is located and run "node app.js"
6. Open the website on the local host 8080. 


Database we have with each filed listed：
==
1. Admin : id, username, password, status, time
2. Editor: editor_id, user_id
3. Banner: id, name, url, sort, img
4. Topic: id, name, keywords, description, url
5. News: id, cid, title, img, time, author, text, summary, likeNumber
6. Comments: id, author, time, like, text, news_id
7. registered_users: user_id, user_first_name, user_last_name, username, userEmail, password, log_in_status, last_log_in_time
8. registereduser: id, username, password, status, time
9. reporter: reporter_id, user_id
10. topadmin: id, username, password
11. topic: id, name, sort, keywords, description

Reference:

picture：https://images.app.goo.gl/KYqtgHHMJ364qnzAA
