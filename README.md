# SQL - Simple Shop Database
Technology used : sql

## Description
This project aims to create a simple relational database for a shop selling bikes and perform a couple of operations on the database, including :

* creating a database, new tables
* adding and changing data & tables' structures
* adding primary & foreign keys as well as relations between tables
* checking for errors and fix them
* performing operations on tables


## Creating a database and its tables
The database and tables creation has been performed using MySQL via the file [shop.sql](shop.sql).


```mermaid
erDiagram
    CUSTOMERS ||--O{ ORDERS : place

    ORDERS {
        int OrderId PK
        date OrderDate
        int CustomerId FK
        int ProductId FK
        int Quantity
    }

    CUSTOMERS {
        int CustomerId PK
        string FirstName
        string LastName
        int Age
        string City
    }

        ORDERS ||--O{ PRODUCTS : contain

    PRODUCTS {
        int ProductId PK
        string ProductName
        int Price
        int BrandId FK
    }


        PRODUCTS ||--|| BRANDS : have

    BRANDS {
        int BrandId PK
        string BrandName
    }

```


## Sources
[kaggle bike products dataset](https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database)

[lucjankonopka github repo with a similar project](https://github.com/lucjankonopka/sql_shop_database/tree/main)