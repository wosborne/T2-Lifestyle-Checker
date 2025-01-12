T2 - Lifestyle Checker Web App
Introduction
A local health authority wants to provide lifestyle choice information to its registered patients. This information will be displayed to relevant patients based on their current lifestyle choices. To do this the local authority would like to build a simple web application that patients can use. The web application will work as follows

Ask the user to enter their NHS Number and details, the system will then call an API to identify the patient.
The application will ask the user a number of simple questions about their current lifestyle choices, the answers to these along with their age will be used to generate a risk score. Users who score over a certain threshold will be directed to the information pack.
Part One
Create a web based app that asks the user to provide the following details

NHS Number
Surname
Date of Birth
The app should then validate the user as a valid patient by calling the following api (see notes )

https://al-tech-test-apim.azure-api.net/tech-test/t2/patients/{nhsNumber}

The api will respond with a 404 if the patient cannot be found or a json body like the one below

{

  "nhsNumber": "123456789",
  "name": "DOE, John",
  "born": "25-12-1990"
}
There are 4 possible outcomes

Patient cannot be found - user is shown "Your details could not be found" message
Patient found, but details do not match - user is shown "Your details could not be found" message
Patient found, details match but they are under 16 years old - user is shown a message "You are not eligble for this service"
Patient found and details match - user progresses to part 2
Part Two
The application will ask the citizen to answer the following 3 questions

Q1. Do you drink on more than 2 days a week?
Q2. Do you smoke?
Q3. Do you exercise more than 1 hour per week?
After submitting their answers the application will generate a score based on the following scoring chart.

Scoring
For questions 1 & 2 the points are awarded for anwsering yes, but for question 3 points are awarded for answering no. All questions must be answered.

AGE	16 -21	22 - 40	41 -65	64+
Q1	1	2	3	3
Q2	2	2	2	3
Q3	1	3	2	1
There are two possible outcomes

The user scores 3 or less - they are shown a message "Thank you for answering our questions, we don't need to see you at this time. Keep up the good work!"
The user scores 4 or more - they are shown a message "We think there are some simple things you could do to improve you quality of life, please phone to book an appointment"
Part Three (Optional / Advanced)
How could the code be implemented in such a way that the scoring mechanism could be altered without requiring the code to be recompiled and re-deployed? This could be a change to age groups or scores for individual questions.

API Details
You will need to provide a subscription key to make calls to the API, this subscription key must be sent in the Ocp-Apim-Subscription-Key header. The subscription key will be provided separately.

NB: You should not check this subscription key into your code repository, you may be marked down if you do so.

There are 5 patients configured, which should allow you to test various scenarios

Nhs Number	Name	Age	DOB
111222333	DOE, John	18	Jan 14
222333444	SMITH, Alice	25	Mar 2
333444555	CARTER, Bob	46	May 20
444555666	BOND, Charles	70	July 18
555666777	MAY, Megan	14	Nov 14
(NB: The API will always return a DOB that makes the patient the "correct age" - therefore if you call the API on the day before the patients birthday, when you call it the next day the year of their DOB will have changed so that they remain the same age )