General Election 2024 Analysis
Indian General Elections 2024 Data Insights
This project contains a collection of SQL queries to analyze the results of the 2024 Indian General Elections. The analysis covers various aspects such as seat distribution, party performance, alliance classification, and constituency-level details.

Table of Contents
Overview
Queries
Total Seats
State-wise Seat Distribution
NDA Alliance Performance
I.N.D.I.A. Alliance Performance
Party Alliance Classification
Constituency-level Analysis
Vote Distribution Analysis
State-level Party Performance
Alliance-wise State Performance
Top Candidates by Votes
License
Overview
The dataset includes detailed results from the 2024 Indian General Elections, spanning:

Constituency-wise and state-wise results.
Performance of major alliances like NDA and I.N.D.I.A.
Insights into winning candidates, vote margins, and party-level statistics.
Queries
Total Seats
SQL
SELECT DISTINCT COUNT(`Parliament Constituency`) AS Total_Seats
FROM constituencywise_results;
This query calculates the total number of seats in the election.

State-wise Seat Distribution
SQL
SELECT
    s.state AS state_name,
    COUNT(sr.`Parliament Constituency`) AS total_seats
FROM constituencywise_results cr
INNER JOIN statewise_results sr
    ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
INNER JOIN states s
    ON s.`State ID` = sr.`State ID`
GROUP BY s.State;
This query shows the total number of seats available for elections in each state.

NDA Alliance Performance
Total Seats Won by NDA:

SQL
SELECT
    SUM(CASE WHEN PARTY IN (
        'Bharatiya Janata Party - BJP',
        'Telugu Desam - TDP',
        'Janata Dal (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM'
    )
    THEN WON ELSE 0 END) AS NDA_Total_Seats_Won
FROM partywise_results;
Seats Won by Individual NDA Parties:

SQL
SELECT party AS Party_Name,
    WON AS Seats_Won
FROM partywise_results
WHERE PARTY IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
)
ORDER BY Seats_Won DESC;
I.N.D.I.A. Alliance Performance
Total Seats Won by I.N.D.I.A.:

SQL
SELECT
    SUM(CASE WHEN party IN (
        'Indian National Congress - INC',
        'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India (Marxist) - CPI(M)',
        'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Jharkhand Mukti Morcha - JMM',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP'
    )
    THEN WON ELSE 0 END) AS INDIA_Total_Seats_Won
FROM partywise_results;
Seats Won by Individual I.N.D.I.A. Parties:

SQL
SELECT party AS Party_Name, WON AS Seats_Won
FROM partywise_results
WHERE PARTY IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Communist Party of India - CPI',
    'Rashtriya Janata Dal - RJD'
)
ORDER BY Seats_Won DESC;
Party Alliance Classification
SQL
ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A.'
WHERE PARTY IN ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', ...);

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE PARTY IN ('Bharatiya Janata Party - BJP', 'Shiv Sena - SHS', ...);

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;
Constituency-level Analysis
SQL
SELECT
    cr.`Winning Candidate`,
    pr.`Party`,
    pr.party_alliance,
    cr.`Total Votes`,
    cr.margin,
    cr.`Constituency Name`
FROM constituencywise_results cr
INNER JOIN partywise_results pr ON cr.`Party ID` = pr.`Party ID`
WHERE cr.`Constituency Name` = 'AGRA';
Vote Distribution Analysis
SQL
SELECT cd.`EVM Votes`,
    cd.`Postal Votes`,
    cd.`Total Votes`,
    cd.`Candidate`,
    cr.`Constituency Name`
FROM constituencywise_results cr
INNER JOIN constituencywise_details cd
    ON cr.`Constituency ID` = cd.`Constituency ID`
WHERE cr.`Constituency Name` = 'AMROHA';
State-level Party Performance
SQL
SELECT
    p.Party, COUNT(cr.`Constituency ID`) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p ON cr.`Party ID` = p.`Party ID`
WHERE s.`State` = 'Uttar Pradesh'
GROUP BY p.Party
ORDER BY Seats_Won DESC;
Alliance-wise State Performance
SQL
SELECT
    s.State,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END ) AS NDA_Seat_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A.' THEN 1 ELSE 0 END ) AS INDIA_Seat_Won,
    SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END ) AS OTHER_Seat_Won
FROM constituencywise_results cr
GROUP BY s.State;
Top Candidates by Votes
SQL
SELECT
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.`Candidate`,
    cd.`EVM Votes`
FROM constituencywise_details cd
WHERE cd.`EVM Votes` =(
    SELECT MAX(cd1.`EVM Votes`) FROM constituencywise_details cd1
)
ORDER BY cd.`EVM Votes` DESC
LIMIT 10;
