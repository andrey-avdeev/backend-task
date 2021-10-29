# SQL
## Scripts and migrations
All migrations you can find in **migrations/** directory.

## 1 task
### Description
Write down a query that gives us a breakdown of spend in GBP by each user. Use the exchange rate with the largest timestamp. 

### Answer
```sql
--TODO
```

## 2 task
### Description:
Write down the same query, but this time, use the latest exchange rate smaller or equal then the transaction timestamp. The solution should have the two columns: user_id, total_spent_gbp, ordered by user_id

### Answer
```sql
--TODO
```

## 3 task
### Description
Bonus for Postgres superstars: Consider the same schema, but now let’s add some random data, to simulate real scale: http://sqlfiddle.com/#!17/c6a70 or https://dbfiddle.uk/?rdbms=postgres_9.6&fiddle=231257838892f0198c58bb5f46fb0d5d 

Write a solution for the previous task. Please ensure It executes within 5 seconds. 

### Answer
Optimizations:
```sql
--TODO
```

# Python
## Task 1
### Description
Given an input as json array (each element is a flat dictionary) write a program that will parse this json, and return a nested dictionary of dictionaries of arrays, with keys specified in command line arguments and the leaf values as arrays of flat dictionaries matching appropriate groups
python nest.py nesting_level_1 nesting_level_2 … nesting_level_n
Example input for json can be found here:  http://jsonformatter.org/74f158
For example, when invoked like this:
cat input.json | python nest.py currency country city
the output should be in json format and look like this: http://jsonformatter.org/615048
Please note, that the nesting keys should be stripped out from the dictionaries in the leaves.
Also please note that the program should support an arbitrary number of arguments, that is arbitrary levels of nesting.

### Solution
--TODO

## Task2
### Description
Create a REST service from the first task. Make sure your methods support basic auth. Input json should be received via POST request, nesting parameters should be specified as request parameters.

### Solution
--TODO