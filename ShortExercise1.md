# The Problem #

Later on in the exercises we shall be exploring how Weather patterns can be examined from the past to help us look at what might happen in the future, for a specific time and location.

So lest start off by examining the weather dataset.

# The Code #
  * **library(rattle)**  _Loads the Rattle package and the associated datasets into the memory._
  * **weatherAUS** _Loads in the weatherAUS dataset_
  * **names(weatherAUS)** _Shows the variables Names_
  * **nrow(weatherAUS)** _displays the number of rows (observations on the longest variable)_
  * **ncol(weatherAUS)** _displays the number of columns (variables)_
  * **head(weatherAUS)** _First six records of the dataset._
  * **tail(weatherAUS)** _the last six rows of the dataset._
  * **sample(weatherAUS)** _A snapshot of some of the data._


# The Exercise #

_Lets Start R_

**library(rattle)**  _Loads the Rattle package and the associated datasets into the memory._

The dataset we need to solve this problem is one associated dataset with Rattle, called weatherAUS.

_Lets load in the dataset_

**weatherAUS** _Loads in the weatherAUS dataset_

This first thing we want to do is to get a feel for our data. So we want to look at the names of the variables,

**names(weatherAUS)** _Shows the variables Names_

```
[1] "Date"          "Location"     "MinTemp"       "MaxTemp"       
[5] "Rainfall"      "Evaporation"  "Sunshine"      "WindGustDir"  
[9] "WindGustSpeed" "WindDir9am"    "WindDir3pm"   "WindSpeed9am" 
[13] "WindSpeed3pm" "Humidity9am"  "Humidity3pm"   "Pressure9am"  
[17] "Pressure3pm"  "Cloud9am"     "Cloud3pm"      "Temp9am"      
[21] "Temp3pm"      "RainToday"    "RISK_MM"       "RainTomorrow"
```

We also want to look at the number of variables and the number of observations.

**nrow(weatherAUS)** _displays the number of rows (observations on the longest variable)_
```
[1] 28818
```
**ncol(weatherAUS)** _displays the number of columns (variables)_
```
[1] 24
```
Now we want to look at a dataset to gain some knowledge about the data. So we need to look at the Head , Tail, and Sample..

**head(weatherAUS)** _First six records of the dataset._

```
       Date LocationMinTempMaxTempRainfallEvaporationSunshine WindGustDir
1  2008-12-01  Albury   13.4   22.9     0.6         NA      NA          W
2  2008-12-02  Albury    7.4   25.1     0.0         NA      NA        WNW
3  2008-12-03  Albury   12.9   25.7     0.0         NA      NA        WSW
4  2008-12-04  Albury    9.2   28.0     0.0         NA      NA         NE
5  2008-12-05  Albury   17.5   32.3     1.0         NA      NA          W
6  2008-12-06  Albury   14.6   29.7     0.2         NA      NA        WNW

WindGustSpeed WindDir9amWindDir3pmWindSpeed9am WindSpeed3pmHumidity9am
1           44         W       WNW          20          24         71
2           44       NNW       WSW           4          22         44
3           46         W       WSW          19          26         38
4           24        SE         E          11           9         45
5           41       ENE        NW           7          20         82
6           56         W         W          19          24         55

 Humidity3pm Pressure9am Pressure3pm Cloud9am Cloud3pm Temp9am Temp3pm
1         22      1007.7      1007.1        8       NA    16.9    21.8
2         25      1010.6      1007.8       NA       NA    17.2    24.3
3         30      1007.6      1008.7       NA        2    21.0    23.2
4         16      1017.6      1012.8       NA       NA    18.1    26.5
5         33      1010.8      1006.0        7        8    17.8    29.7
6         23      1009.2      1005.4       NA       NA    20.6    28.9

  RainToday RISK_MM RainTomorrow
1       No     0.0           No
2       No     0.0           No
3       No     0.0           No
4       No     1.0           No
5       No     0.2           No
6       No     0.0           No
```

**tail(weatherAUS)** _the last six rows of the dataset._

```
            Date Location MinTemp MaxTemp Rainfall Evaporation Sunshine
28813 2010-07-25   Darwin    25.8    34.2        0         9.4      9.7
28814 2010-07-26   Darwin    26.6    34.7        0        10.4      8.7
28815 2010-07-27   Darwin    25.2    34.2        0         9.8      9.4
28816 2010-07-28   Darwin    23.3    34.3        0         7.2     10.7
28817 2010-07-29   Darwin    21.5    33.3        0         7.6     11.1
28818 2010-07-30   Darwin    22.8    33.6        0         7.0     10.1
      WindGustDir WindGustSpeed WindDir9am WindDir3pm WindSpeed9am WindSpeed3pm
28813           E            61        ESE          E           26           28
28814           E            50        ESE        ESE           22           30
28815           E            52        ESE        ENE           22           30
28816         ENE            44        ESE         NE           24           28
28817         ESE            37          E        WNW           17           28
28818         NNW            31        SSE        NNW           13           20
      Humidity9am Humidity3pm Pressure9am Pressure3pm Cloud9am Cloud3pm Temp9am
28813          52          37      1012.9      1009.2        6        3    27.3
28814          53          38      1014.5      1010.5        7        2    27.1
28815          63          40      1015.0      1010.8        5        3    26.5
28816          63          34      1014.2      1010.3        3        1    27.5
28817          70          49      1013.9      1009.6        4        2    26.1
28818          75          52      1014.0      1011.2        5        7    26.4
      Temp3pm RainToday RISK_MM RainTomorrow
28813    33.6        No       0           No
28814    33.4        No       0           No
28815    32.8        No       0           No
28816    33.5        No       0           No
28817    32.1        No       0           No
28818    31.5        No       0           No
```

**sample(weatherAUS)** -A snapshot of some of the data. The results are two big to print here.

```
718      13.2      2.4    BadgerysCreek 2009-04-21           S
719      13.7      8.4    BadgerysCreek 2009-04-22          SE
720      13.6      1.6    BadgerysCreek 2009-04-23          NE
721       7.9      0.2    BadgerysCreek 2009-04-24           N
722      12.8      0.4    BadgerysCreek 2009-04-25           N
723      12.7      0.0    BadgerysCreek 2009-04-26           W
724       4.8      0.0    BadgerysCreek 2009-04-27          SW
725       4.8      0.0    BadgerysCreek 2009-04-28           W
726       4.6      0.0    BadgerysCreek 2009-04-29         ESE
```