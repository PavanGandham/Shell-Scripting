#!/bin/bash

ONE=14
dataset_date=`date`
Fourteendaysold=`date -d "$dataset_date - $ONE days" +%F`
echo $Fourteendaysold

TWO=7
dataset_date=`date`
sevendaysold=`date -d "$dataset_date - $TWO days" +%F`
echo $sevendaysold
date1=`echo $sevendaysold | sed 's/-//g'`
date2=`echo $Fourteendaysold | sed 's/-//g'`
echo $date1 with $date2