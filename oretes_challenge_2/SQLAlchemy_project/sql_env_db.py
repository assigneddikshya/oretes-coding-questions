import sqlalchemy as db
import pandas as pd

#Establish connection and verify
engine = db.create_engine('mysql://user:password@host:host/company') #we have chosen 'company db'
connection  = engine.connect()
metadata = db.MetaData()
employee = db.Table('employee', metadata, autoload=True, autoload_with=engine)
print(employee.columns.keys())
print(repr(metadata.tables['employee']))

#Queries
query = db.select([employee])

ResultProxy = connection.execute(query)
ResultSet = ResultProxy.fetchall()
ResultSet[:3]

#put the result in a dataframe
df = pd.DataFrame(ResultSet)
df.columns = ResultSet[0].keys()
df

#Sqlalchemy queries
db.select([employee]).where(employee.columns.Gender == 'F')

#SQl queries
db.select([employee.columns.Address, employee.columns.Gender]).where(employee.columns.Address.in_(['TX']))
db.select([employee]).where(db.and_(employee.columns.Address == 'California', employee.columns.Gender != 'M'))

female_pop = db.func.sum(db.case([(employee.columns.Gender == 'F', employee.columns.Salary)],else_=0))
total_pop = db.cast(db.func.sum(employee.columns.Salary), db.Float)
query = db.select([female_pop/total_pop * 100])
result = connection.execute(query).scalar()
print(result)

#Automatic join
#2 tables
#1. Department
dept = db.Table('department', metadata, autoload=True, autoload_with=engine)
dept_loc = db.Table('dept_locations', metadata, autoload=True, autoload_with=engine)
project_loc = db.Table('project', metadata, autoload=True, autoload_with=engine)

#Join them using Dnumber(Department number)
query = db.select([dept.columns.Dnumber, dept_loc.columns.Dlocation, project_loc.columns.Plocation])
result = connection.execute(query).fetchall()
df2 = pd.DataFrame(result)
df2.columns = result[0].keys()
df2.head(5)

#Manual join
query = db.select([dept, dept_loc])
query = query.select_from(dept.join(dept_loc, dept.columns.Dnumber == dept_loc.columns.Dnumber))
results = connection.execute(query).fetchall()
df3 = pd.DataFrame(results)
df3.columns = results[0].keys()
df3.head(5)

query = db.select([dept_loc, project_loc])
query = query.select_from(dept_loc.join(project_loc, dept_loc.columns.Dnumber == project_loc.columns.Dnum))
results = connection.execute(query).fetchall()
df4 = pd.DataFrame(results)
df4.columns = results[0].keys()
df4.head(5)

#Creating and inserting data into tables
emp = db.Table('emp', metadata,
              db.Column('Id', db.Integer()),
              db.Column('name', db.String(255), nullable=False),
              db.Column('salary', db.Float(), default=100.0),
              db.Column('active', db.Boolean(), default=True)
              )

metadata.create_all(engine)

#Inserting data
#Inserting record one by one
query = db.insert(emp).values(Id=1, name='naveen', salary=60000.00, active=True) 
ResultProxy = connection.execute(query)

#Inserting many records at ones
query = db.insert(emp) 
values_list = [{'Id':'2', 'name':'ram', 'salary':80000, 'active':False},
               {'Id':'3', 'name':'ramesh', 'salary':70000, 'active':True}]
ResultProxy = connection.execute(query,values_list)

results = connection.execute(db.select([emp])).fetchall()
df5 = pd.DataFrame(results)
df5.columns = results[0].keys()
df5.head(4)

#Updating data in databases(emp table)
emp = db.Table('emp', metadata, autoload=True, autoload_with=engine)

# Build a statement to update the salary to 100000
query = db.update(emp).values(salary = 100000)
query = query.where(emp.columns.Id == 1)
results = connection.execute(query)

results = connection.execute(db.select([emp])).fetchall()
df6 = pd.DataFrame(results)
df6.columns = results[0].keys()
df6.head(4)

#Delete rows from table(the emp table)

emp = db.Table('emp', metadata, autoload=True, autoload_with=engine)

# Build a statement to delete where salary < 100000
query = db.delete(emp)
query = query.where(emp.columns.salary < 100000)
results = connection.execute(query)

results = connection.execute(db.select([emp])).fetchall()
df7 = pd.DataFrame(results)
df7.columns = results[0].keys()
df7.head(4)

#Dropping table(s)

table_name.drop(engine) #drops a single table
metadata.drop_all(engine) #drops all the tables in the database

emp.drop(engine)


