/*Chapter 3.2*/
%let path=/folders/myfolders/Data_One/;

libname orion "/folders/myfolders/Data_One/";
/*Level 1*/
/*a, explore the orion.library and answer the questions.*/
proc contents data=orion.country;
run;
proc print data=orion.country;
run;
/*a, answer: 7 observations; 6 variables; South Africa;*/

/*b*/
proc contents data=orion._all_ nods;
run;
/*answer: US_SUPPLIERS;*/

/*Level 2*/
/*Examine the general data set properties of orion.staff.*/
proc contents data=orion.staff;
run;
/*b, answer: information is sorted according to index
   Employee_ID with ANSI character.*/

/*Challenge*/
/*answer: 
Name:autoexec.sas
Purpose: Auotoexec file can help set up variables of SAS and other system options to assist users.
How to create: Use SAS text editor with SAS statements and save 
         as autoexec file.
How could useful: One typical autoexec file is LIBNAME statement 
         which can help set the library.
*/

/*Chapter 4.1*/
/*Level 1*/
/*a*/
proc print data=orion.order_fact;
run;

/*b*/
proc print data=orion.order_fact;
     sum Total_Retail_Price;
run;

/*c*/
proc print data=orion.order_fact;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
run;
/*Obs column numbers are not sequential because they keep their original number.
  Yes, sum change to reflect only the subset.*/

/*d*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
run;
/*use log notes to verify the number of observations.*/

/*e*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
run;
/*add one Customer_ID column in the left side.*/

/*f*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
     var Customer_ID Order_ID Order_Type 
         Quantity Total_Retail_Price;
run;
/*The Customer_ID has appeared twice */

/*g*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
     var Order_ID Order_Type 
         Quantity Total_Retail_Price;
run;

/*Level 2*/
/* a*/
proc print data=orion.customer_dim;
run;
/* b*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
run;
/* c*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
     id Customer_ID;
run;
/* d*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
     id Customer_ID;
     var Customer_ID Customer_Name Customer_Age
         Customer_Type;
run;

/*Chapter 4.2*/
/*Level 1*/
/*Question 1*/
/*a*/
proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;
/*b*/
proc print data=work.sort_salary;
run;

/*Question 2*/
/*a*/
proc sort data=orion.employee_payroll
			 out=work.sort_salary2;
	by Employee_Gender descending Salary;
run;

/*b*/
proc print data=work.sort_salary2;
	by Employee_Gender;
run;

/*Level 2*/
/*a*/
proc sort data=orion.employee_payroll
			 out=work.sort_sal;
	by Employee_Gender descending Salary;
run;
/*b*/
proc print data=work.sort_sal noobs;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is missing and Salary>65000;
	var Employee_ID Salary Marital_Status;
 run;

/*Chapter 4.3*/
/*Level 1*/
/*Question 1*/
/*a, run the code*/
/*b, add a VAR statement to display only the variables shown
     in the report.*/
proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
/*c, Add TITLE and FOOTNOTE statements */
title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_Title: Sales Rep. IV';

proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
title;
footnote;

/*d, verify the output*/
/*e, */
proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;

/*Question 2*/
/*a, Modify the program to define and use the given labels.*/
title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs label;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;

title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

/*b, */
proc print data=orion.sales noobs split=' ';
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;

/*Level 2*/
/*a, Write a program to display a sub set of orion.employee_address as shown. Sort the observations by State, City, and Employee_Name*/
proc sort data=orion.employee_addresses out=work.address;
	where Country='US';
	by State City Employee_Name;
run;

/*display the sorted observations grouped by State.*/
title "US Employees by State";
proc print data=work.address noobs split=' ';
	var Employee_ID Employee_Name City Postal_Code;
	label Employee_ID='Employee ID'
			Employee_Name='Name'
			Postal_Code='Zip Code';
	by State;
run;

/*Chapter 5.1*/
/*Level 1*/
/*b*/
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
run;
/*c*/
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. 
		    Employee_Hire_Date date9.;
run;

/*Level 2*/
/*a*/
title1 'US Sales Employees';
title2 'Earning Under $26,000';

proc print data=orion.sales label noobs;
	where Country='US' and Salary<26000;
	var Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	label First_Name='First Name'
		   Last_Name='Last Name'
			Job_Title='Title'
			Hire_Date='Date Hired';
	format Salary dollar10. Hire_Date monyy7.;
run;
title;
footnote;

/*Chapter 5.2*/
/*Level 1*/
/*a, Retrieve the starter program*/
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;
/*b, Create a character format named $GENDER*/
proc format;
   value $gender
      'F'='Female'
      'M'='Male';
run;
/*c, Create a numeric format named MNAME that displays month numbers.*/
proc format;
   value mname
       1='January'
       2='February'
       3='March';
run;
/*d*/
proc print data=Q1Birthdays;
	 format Employee_Gender $gender.
          BirthMonth mname.;
run;
/*e, Submit and produce the report.*/          
title 'Employees with Birthdays in Q1';
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
   format Employee_Gender $gender.
          BirthMonth mname.;
run;
title;

/*Level 2*/
/*a, Retrieve the starter program.*/
proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   title1 'Salary and Gender Values';
   title2 'for Non-Sales Employees';
run;
/*b, Create a character format named $GENDER*/
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';
run;
/*c, Create a numeric format named SALRANGE that displays
     salary ranges as given.*/     
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';

   value salrange .='Missing salary'
      20000-<100000='Below $100,000'
      100000-500000='$100,000 or more'
              other='Invalid salary';
run;
/*d*/
title1 'Salary and Gender Values';
title2 'for Non-Sales Employees';

proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   format Salary salrange. Gender $gender.;
run;

title;

/*Chapter 6.2*/
/*a*/
data work.delays;
   set orion.orders;
run;
/*b*/
data work.delays;
   set orion.orders;
   Order_Month=month(Order_Date);
run; 
/*c*/
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
run;
/*d, The new data set should include only Employee _ID, Order_Date, Delivery_Date, and Order_Month.*/
/*e*/
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
run;     
/*f, Add permanent formats to display Order_Date and Delivery_Date as MM/DD/YYYY.*/   
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
	format Order_Date Delivery_Date mmddyy10.;
	keep Employee_ID Customer_ID Order_Date Delivery_Date Order_Month;
run;
/*g*/
proc contents data=work.delays;
run;
/*h*/
proc print data=work.delays;
run;

/*Chapter 9.1 */
/*Level 2*/
/*a*/
data work.birthday;
   set orion.customer;
run;
/*b*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
run; 
/*c*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
run;
/*d*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date9. Age2012 3.;
run;
/*e*/
proc print data=work.birthday;
run;

/*Chapter 9.2*/
/*Level*/
/*Question 1*/
/*a*/
data work.season;
   set orion.customer_dim; 
run;    
/*b*/
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
run;
/*c*/     
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
   keep Customer_FirstName Customer_LastName Customer_BirthDate   
        Customer_Age Promo Promo2; 
run;
/*d, Create the report as given. The results include 77 observations.*/
proc print data=work.season;
   var Customer_FirstName Customer_LastName Customer_BirthDate Promo 
       Customer_Age Promo2; 
run;

/*Question 2*/
/*a*/
data work.ordertype;
   set orion.orders;
run; 
/*b*/ 
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date); 
run;       
/*c*/ 
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then Type='Retail Sale';
   else if Order_Type=2 then Type='Catalog Sale';
   else if Order_Type=3 then Type='Internet Sale';
run;
/*d*/
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then 
      Type='Retail Sale';
   else if Order_Type=2 then do;
      Type='Catalog Sale';
	   SaleAds='Mail';
   end;
   else if Order_Type=3 then do;
      Type='Internet Sale';
	   SaleAds='Email';
   end;
run;
/*e*/      
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then 
      Type='Retail Sale';
   else if Order_Type=2 then do;
      Type='Catalog Sale';
	   SaleAds='Mail';
   end;
   else if Order_Type=3 then do;
      Type='Internet Sale';
	   SaleAds='Email';
   end;
   drop Order_Type Employee_ID Customer_ID;
run;
/*f*/
proc print data=work.ordertype;
run;

/*Chapter 10.1*/
/*Level 2*/
/*a*/
proc contents data=orion.charities;
run;

proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;
/*                        code           Company         ContactType
                      Type   Length    Type   Length   Type    Length
Orion.charities       char      6       char     40    char       10
Orion.us_suppliers    char      6       char     30    char       1   
Orion.consultants     char      6       char     30    char       8
*/
/*b*/
data work.contacts;	
	set orion.charities orion.us_suppliers;
run;
/*c*/
proc contents data=work.contacts;
run;
/* from the Orion.charities data set*/
/*d*/
data work.contacts2;	
	set orion.us_suppliers orion.charities;
run;
/*e*/
proc contents data=work.contacts2;
run;
/* From the Orion.us_suppliers.
/*f*/
data work.contacts3;	
	set  orion.us_suppliers orion.consultants;
run;
/*because variable ContactType has been defined as both character and numeric.*/

/*Chapter 10.3*/
/*Level 2*/
/*a*/
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;
/*b*/
data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;
/*c*/
proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;

/*Chapter 10.4*/
/*Level 2*/
/*a*/
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;
/*b*/
data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;
/*Create the report*/
proc print data=work.allcustomer;
run;