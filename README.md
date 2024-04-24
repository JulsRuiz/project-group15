Database Creation and Population Instructions:
- 
1. Download all files in repository
2. Create the database:
  
   createdb project

   psql project
   
3. Run the following commands to populate database:
   
    \i projectSchema.sql
   
    \i queries.sql
   
    \q --> to exit the database
   
4. Install python pip and psycopg2 packages with the following commands:
   
   sudo pacman -Syu
   
   sudo pacman -S python-pip python-psycopg2 python-flask
   
5. Run the Flask application with the following commands:

   export FLASK_APP=app.py

   flask run
6. Click on the link provided http://127.0.0.1:5000/

End User Usage Instructions: 
-
1. Pick one of the two traits from the dropdown, adg and 





Queries and Views:
-
- Births: The queries will create a view that will be returning a table of the date of birth of each goat in the database by using the goat id and date of birth

- Deaths: The queries will create a view that will be returning a table of the death date of each goat in the database that has died by using the goat id and checking if the status date of the goat is "dead".

- Lifespan: The queries will create a view that will be returning a table of each goat in the database and their lifespan. 

Collaborators: 
- Julian Ruiz
- Sam Francese
- Saanvi Goyal 
