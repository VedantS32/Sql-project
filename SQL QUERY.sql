create database Hospital_db;

use Hospital_db;

SELECT * FROM appointments;
SELECT * FROM billing;
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM treatments;

#Lists all Dermatology from the doctors table.1
SELECT * FROM doctors WHERE specialization = 'Dermatology';

#Shows appointments sorted by the latest date first.2
SELECT * FROM appointments ORDER BY appointment_date DESC;

#Counts total number of patients.3
SELECT COUNT(*) AS total_patients FROM patients;

#Counts how many patients belong to each gender.4
SELECT gender, COUNT(*) AS count_per_gender 
FROM patients 
GROUP BY gender;



#Returns the average billing amount.5
SELECT AVG(amount) AS avg_billing_amount FROM billing;



#ok
#Total Billing per Patient6
SELECT CONCAT(p.first_name, ' ', p.last_name) AS NAME, SUM(b.amount) AS total_billed
FROM billing as b
JOIN patients as p ON b.patient_id = p.patient_id
GROUP BY name;

#ok
#Gives the latest appointment date per patient.7
SELECT a.patient_id, MAX(a.appointment_date) AS latest_appointment
FROM appointments a
GROUP BY a.patient_id;

#ok
#Returns the highest billed treatment.8
SELECT * 
FROM billing 
ORDER BY amount DESC 
LIMIT 1;



#ok
#Lists patients who never booked an appointment.9
SELECT p.patient_id, p.first_name, p.last_name
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

#OK
#Shows how many patients each doctor has seen.10
SELECT CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, COUNT(a.patient_id) AS patients_seen
FROM doctors as  d
JOIN appointments as  a ON d.doctor_id = a.doctor_id
GROUP BY doctor_name;

#OK
#Subquery: Patients with more than 3 appointments. 11
SELECT p.patient_id, p.first_name, p.last_name
FROM Patients p
WHERE (
  SELECT COUNT(*) 
  FROM Appointments a 
  WHERE a.patient_id = p.patient_id
) > 3;
