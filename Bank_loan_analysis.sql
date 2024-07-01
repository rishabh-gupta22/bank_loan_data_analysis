SELECT * FROM financial_loan

/*To find the total number of transactions*/
SELECT DISTINCT COUNT(*) AS total_loan_applications FROM financial_loan;

/*To find the total number of transactions month to date*/
SELECT DISTINCT COUNT(*) AS current_month_to_date_transactions FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

/*To find the total number of transactions previous month to date
The results of both current and previous date to month can be used to obtain month to month*/
SELECT DISTINCT COUNT(*) AS previous_month_to_date_transactions FROM financial_loan
WHERE MONTH(issue_date) = 1 AND YEAR(issue_date) = 2021;


/*To find the total funded amount*/
SELECT SUM(loan_amount) as total_funded_amount FROM financial_loan;

/*To find the total funded amount month to date*/
SELECT SUM(loan_amount) as MTD_funded_amount FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

/*To find the total received amount*/
SELECT SUM(total_payment) AS total_amount_received FROM financial_loan;

/*To find the Average Interest Rate*/
SELECT ROUND(AVG(int_rate)*100,2) AS average_interest_rate FROM financial_loan;

/*To find the Average DTI (Debt to income ratio)*/
SELECT ROUND(AVG(dti)*100,2) as average_dti FROM financial_loan;

/*To find the percentage of Good Loans*/
SELECT COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' then id END)*100
/
COUNT(id) as good_loan_percentage FROM financial_loan;

/*To find the Number of Good Loans*/
SELECT COUNT(id) as number_good_loan FROM financial_loan WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

/*To find the Total funded amount of Good Loans*/
SELECT SUM(loan_amount) total_good_loan FROM financial_loan WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

/*To find the Total received amount of Good Loans*/
SELECT SUM(total_payment) AS received_good_loan FROM financial_loan WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


/*To find the percentage of bad Loans*/
SELECT COUNT(CASE WHEN loan_status = 'Charged Off' then id END)*100
/
COUNT(id) as bad_loan_percentage FROM financial_loan;

/*To find the Number of Bad Loans*/
SELECT COUNT(id) as number_bad_loan FROM financial_loan WHERE loan_status = 'Charged Off';

/*To find the Total funded amount of Bad Loans*/
SELECT SUM(loan_amount) as total_bad_loan FROM financial_loan WHERE loan_status = 'Charged Off';

/*To find the Total received amount of Good Loans*/
SELECT SUM(total_payment) AS received_bad_loan FROM financial_loan WHERE loan_status = 'Charged Off';

/*To analyse data by loan status*/
SELECT 
	loan_status,
	COUNT(id) as total_loan_applications,
	SUM(total_payment) as total_payment_received,
	SUM(loan_amount) as total_funded_amount,
	ROUND(AVG(int_rate),2) as interest_rate,
	ROUND(AVG(dti),2) as DTI,
	SUM(total_payment)-SUM(loan_amount) as Profit
FROM financial_loan GROUP BY loan_status;

/*To analyse data by month*/
SELECT
	DATENAME(MONTH, issue_date) as month_name,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date) ORDER BY MONTH(issue_date);

/*To analyse data by Region (State)*/
SELECT
	address_state,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY address_state ORDER BY SUM(loan_amount) DESC;

/*To analyse data by Loan Tenure (Term)*/
SELECT
	term,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY term ORDER BY SUM(loan_amount) DESC;

/*To analyse data by Employee Experience*/
SELECT
	emp_length,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY emp_length ORDER BY SUM(loan_amount) DESC;

/*To analyse data by Purpose*/
SELECT
	purpose,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY purpose ORDER BY SUM(loan_amount) DESC;

/*To analyse data by Grade*/
SELECT
	grade,
	COUNT(id) as total_loan_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_received_amount
FROM financial_loan 
GROUP BY grade ORDER BY grade;

