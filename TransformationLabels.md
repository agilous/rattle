# Introduction #

These are the different types of transform in Rattle, and the prefixes of the variables after they have been transformed. When you undertake a transformation in Rattle, a new variable is generated and added to the bottom of the dataset. The prefix is added to the front of each one, so there is an audit trail of the transformations.

For Example **`RRC_MinTemp`** is the  **`MinTemp`**  from the  **weather**  dataset, which has been transformed by using the _Rescale_ transformation. It is also possible to transform a transformed variable. For example  **`RBG_WindDir9am_RMA_MinTemp`**  is the same variable **`MinTemp`** from the **weather** dataset, that was first transformed with other variables using _Normalize - Matrix_ and then transformed by using _order - By Group_ using the categorical **`WindDir9am`** as the grouping variable.


# Transform Tab #

## **Type Rescale** ##
| **Normalize** |
|:--------------|
|Label          | Prefix        |
|Rescale        | RRC           |
|Scale 0-1      | `R01`         |
|-Median/MAD    | RMD           |
|Natural Log    | RLG           |
|Matrix         | RMA           |

| **Order** |
|:----------|
|Label      | Prefix    |
|Rank       | RRK       |
|By Group   | RBG       |

## **Type Impute** ##
|Label | Prefix|
|:-----|:------|
|Zero/Missing | IZR   |
|Mean  | IMN   |
|Median | IMD   |
|Mode  | IMO   |
|Constant |  ICN  |

## **Type Recode** ##

_Please Note_ The number 4 represents the number of Bins assigned to this transformation, and can be changed in the Rattle Transformation Recode Binning section to the desired number of Bins.

| **Binning**  |
|:-------------|
|Label         | Prefix       |
|Quantiles     | BQ4          |
|Kmeans        | BK4          |
|Equal With    | BE4          |

|Label | Prefix|
|:-----|:------|
|Indicator Variable | TIN   |
|Join Categories| TJN   |
|As Categorics| TFC   |
|As Numeric |  TNM  |