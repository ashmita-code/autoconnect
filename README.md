# autoconnect
**Project Overview**
In this project, I designed and implemented a database containing six tables with appropriate key constraints. The tables included are:

-Agent
-Client_info
-Employee
-Insurance_Details
-SoldCars
-UsedCars

Each table stores relevant information specific to its purpose, ensuring a well-structured and normalized database.

**Query Execution and Visualization**
After setting up the database, I executed several queries to retrieve and analyze future details from the dataset. These queries are stored in the autoconnect_queries.sql file.

Next, I connected my Jupyter Notebook (autoconnect.ipynb) to the database, executed the same queries using Python, and created visualizations to better interpret the data.

**Technologies and Libraries Used**
The following Python libraries were utilized for database connectivity, data manipulation, and visualization:

import os
import matplotlib.pyplot as plt
import pymysql
import pandas as pd
import sqlite3
import seaborn as sns
from datetime import datetime


This project demonstrates database management, SQL querying, and data visualization techniques, providing insights into the stored data.
