REM                 Group Case Study
REM Francis Ogunlaja (2024092880)
REM Giulia Moliterno Santos (2025015348)
REM Ramandeep Kaur (2024093666)
REM Rukmal Mahinda Hettiyakandage Fernando (2025014919)
REM Taiwo Ernestina Jivoh (2025016367)
REM 
REM       International Business University
REM        MBAC1022025: Business Analytics
REM             Prof. Foad Aghamiri
REM               August 16, 2025

REM See readme.md for prerequisites.

REM load main data, sort by CustomerID and remove columns we don't plan to use in the decision tree
mlr --csv sort -f CustomerID then cut -f CustomerID,Count,Country,State,"Zip Code",Latitude,Longitude,Gender,"Senior Citizen",Partner,Dependents,"Tenure Months","Phone Service","Multiple Lines","Internet Service","Online Security","Online Backup","Device Protection","Tech Support","Streaming TV","Streaming Movies","Paperless Billing","Monthly Charges","Churn Label",CLTV Telco_customer_churn.csv > TEMP_Telco_customer_churn.csv

REM load Demographics data, sort by Customer ID and remove columns either already present in main data or which we don't plan to use
mlr --csv sort -f "Customer ID" then cut -f "Customer ID","Age","Under 30","Number of Dependents" Telco_customer_churn_demographics.csv > TEMP_Telco_customer_churn_demographics.csv

REM load Services data, sort by Customer ID and remove columns either already present in main data or which we don't plan to use
mlr --csv sort -f "Customer ID" then cut -f "Customer ID","Referred a Friend","Number of Referrals",Offer,"Avg Monthly Long Distance Charges","Internet Type","Avg Monthly GB Download","Streaming Music","Unlimited Data","Total Charges","Total Refunds","Total Extra Data Charges","Total Long Distance Charges","Total Revenue" Telco_customer_churn_services.csv > TEMP_Telco_customer_churn_services.csv

REM merge the data into the final CSV file, first we merge the two smaller files together and then that result with the main data
mlr --csv join -j "Customer ID" -f TEMP_Telco_customer_churn_demographics.csv TEMP_Telco_customer_churn_services.csv > TEMP_merge1.csv
mlr --csv join -j CustomerID -l CustomerID -r "Customer ID" -f TEMP_Telco_customer_churn.csv TEMP_merge1.csv > Telco_customer_churn_merged.csv

REM remove temporary intermediate files
del TEMP_Telco_customer_churn.csv
del TEMP_Telco_customer_churn_demographics.csv
del TEMP_Telco_customer_churn_services.csv
del TEMP_merge1.csv

REM Done.
echo Done!