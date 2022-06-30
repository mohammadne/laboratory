# Apache Logs

> here we are aiming to do various operations to understand linux basic file operations.
>
> link to the [log](https://github.com/InsightDataScience/Parsing-Workshop/blob/master/exercises/analyzing_apache-logs/apache_logs.txt) file.

``` bash
# get first 10 logs 
head apache_logs.txt -n 10

# get ip addresses of the first 10 logs
head apache_logs.txt | awk '{print $1}'

# count status-code of the first 10 logs
head apache_logs.txt | awk '{print $9}' | uniq -c

# count status-code of the whole logs (wrong)
cat apache_logs.txt | awk '{print $9}' | uniq -c

# count status-code of the whole logs in a sorted fassion
cat apache_logs.txt | awk '{print $9}' | sort | uniq -c

# count status-code of the range 4xx whole logs in a sorted fassion
cat apache_logs.txt | awk '{print $9}' | grep '4[0-9][0-9]' | sort | uniq -c

# print mostly hitted IP address (wrong)
cat apache_logs.txt | awk '{print $1}' | sort | uniq -c | tail -n 1 | awk '{print $2}'

# print mostly hitted IP address 
cat apache_logs.txt | awk '{print $1}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}'
```