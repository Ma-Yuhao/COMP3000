

# Sale-fish:Shopping website for young people



## Project brief

### Website front  users

```
1. Registration and login: website users complete user registration and login;
2. Browse products: select products according to conditions;
3. Shopping: users choose their favorite products to join the shopping cart, and then they can submit the order directly from the shopping cart and pay for them.
4. Order view: users can view their own order information.
```



### Website administrator  users

```
a. User management
b. Commodity management
c. Order view
```



## Development software

```
1.python 3.6.5
2.mysql 5.6
3.redis 3.2.100
4.pycharm 2019
5.Navicat 12
```

## Project deployment

### Install dependency package

```
Execute: PIP install - R requirements.txt in the project root directory
Note:
1. Requirements.txt is placed in the root directory of the project
2. If the execution is completed and the subsequent steps prompt that a package is missing, PIP install package name will be executed
```



### Create database

```
1. Open settings.py and modify the database configuration information to ensure that it is consistent with the user name, password, port and other information of the local computer mysql.
2. Create a database named store with Navicat, encoding UTF-8.
3. Synchronize database: execute under the project root directory:
（1）python manage.py makemigrations
（2）python manage.py migrate
```



## Create super administrator user

```
python manage.py createsuperuser 
Fill in the user name and password according to the system prompt information.
```

## Start project

```
1. CMD switches to the redis directory and executes redis-server.exe
2. Open the store project with pycharm and select Python interpreter in the settings
Click the start button of the software to run the project
Or directly switch to the store directory in CMD to execute Python manage.py runserver
Note: when pycharm runs Django project, pay attention to whether your pycharm has a Python interpreter
If you have more than one python, you should pay attention to which Python is used in the current project.
```