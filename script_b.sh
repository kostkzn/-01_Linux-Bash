#!/bin/bash

log="./apache_log.txt"

echo
echo "Apache log analyzer"
echo "Log path: $log"
echo
 
def_most_active_client () {
local foo=$(awk '{print $1}' $1 | sort -rn | uniq -c | sort -rn | head -n1 |
    awk '{print $2, "(" $1,"requests)"}')
echo "1. From which ip were the most requests?"
echo "   The highest activity were from: $foo" 
echo
}

def_most_requested_page () {
local foo=$(awk '{print $7}' $1 | sort | uniq -c | sort -rn | head -n1 | sed "s+^[ ]*++g" |
     awk '{print $2, "("$1,"requests)"}')
echo "2. What is the most requested page?"
echo "   The most requested page is: $foo"
echo 
}

def_request_counter () {
echo "3. How many requests were there from each ip?"
echo "   QTY   IP"
echo "   --------------------"
awk '{print $1}' $1 | sort | uniq -c | sort -rn | sed "s+^[ ]*++g" |
     awk '{print "  ", $1,"\t" ,$2}'
echo 
}

def_missing_pages () {
echo "4. What non-existent pages were clients referred to?"
echo "   Missing pages:"
awk '$9 ~/(404|500)/ {print "  ", $7}' $1  # Error codes from 400 to 599
echo 
}


def_most_requested_time () {
local foo=$(awk '{print $4}' $1 | sed "s+^\[++g" | sed "s+:..$++g"  | uniq -c | sort -rn | head -1 | sed "s+[/:]+\ +g" | awk '{print $5 ":" $6, "in", $2, $3, $4, "(" $1,"requests)"}')

echo "5. What time did site get the most requests?"
echo "   The site was most requested at: $foo "
echo 
}

def_search_bots () {
echo "6. What search bots have accessed the site?"
echo "   The site was visited by:"
awk '$14~/[Bb]ot/ {print $14}' $1 | sort | uniq -c | sed "s+\(^.*\)/.*$+\1+g" | 
    awk '{print "   " $2, "\t (" $1, "visits)"}'
}

def_most_active_client $log
def_most_requested_page $log
def_request_counter $log
def_missing_pages $log
def_most_requested_time $log
def_search_bots $log
