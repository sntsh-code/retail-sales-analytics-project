*/
===================================
# Inserting CSV Data into MySQL Table #
===================================

---------------------------------------------------------------------------------------------------------------------------------------------
This document describes the process of importing a CSV file into a MySQL database table using the Table Data Import Wizard in MySQL Workbench.
---------------------------------------------------------------------------------------------------------------------------------------------

## Steps Followed ## 

1. Opened MySQL Workbench and connected to the database server.

2. Chose the target database:

      Selected **mydatabase** from the schema list.

3. Right-clicked on Tables → selected **Table Data Import Wizard**.

      In the import wizard:
      
      Selected the CSV file path from the system.
      
      Clicked Next.
      
      Provided the target table name:
      
      Entered customers as the table name.
      
      Enabled the option “Drop table if exists” to avoid conflicts with existing tables.
      
      Clicked Next and then Finish to complete the import.

------------
## Result ##
------------
  
        The CSV file was successfully imported into the customers table within the mydatabase schema.
  
----------
## NOTE ##
----------
        This steps are followed for Import Raw Data for Tables : customers, orders, region, products, order_items.
