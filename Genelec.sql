-- Total Seats
SELECT
DISTINCT COUNT(`Parliament Constituency`) as Total_Seats
FROM constituencywise_results;
    


-- What are the total no of seats available for elections in each state?
SELECT 
s.state as state_name,
COUNT(sr.`Parliament Constituency`) as total_seats
FROM constituencywise_results cr 
INNER JOIN statewise_results sr
ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
INNER JOIN states s
ON s.`State ID` = sr.`State ID`
GROUP BY s.State;


-- Total Seats won by NDA Alliance
SELECT
	SUM(CASE WHEN PARTY IN('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
                THEN WON
            ELSE 0
		END ) NDA_Total_Seats_Won
	FROM partywise_results;

    
    
    -- Total Seats won by NDA Alliance Parties
    SELECT party as Party_Name,
					WON as Seats_Won
    FROM partywise_results
    WHERE Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
	ORDER BY Seats_Won DESC;
                
    
    -- Total Seats won by I.N.D.I.A. Alliance
    
    SELECT 
		SUM(CASE WHEN party IN(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
				)
			THEN WON
		ELSE 0
	END) as INDIA_Total_Seats_Won
    FROM
		partywise_results;
    
    
    -- Total Seats won by I.N.D.I.A. Alliance Parties
    SELECT
		party as Party_Name, Won as Seats_Won
        FROM partywise_results
        WHERE party IN(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP'
                )
   ORDER BY Seats_Won DESC;
        
    
    -- Add new column field in table party_wise results to get the Party Allianz as NDA, I.N.D.I.A. and OTHER
    
    ALTER TABLE partywise_results
    ADD party_alliance VARCHAR(50);
    
    #INDIA Alliance
    UPDATE partywise_results
    SET party_alliance = 'I.N.D.I.A.'
    WHERE party IN( 'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

#NDA Alliance

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN ('Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);


#OTHERS

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;


-- Which party alliance (NDA< INDIA, or Other) won the most seats across all the states?
SELECT 
party, Won
FROM partywise_results
WHERE party_alliance = 'NDA'
ORDER BY  2 DESC ;


-- Winning Candidates name, their party name, total votes and the margin of the victory for a specific state and constituency

SELECT 
cr.`Winning Candidate`,
pr.`Party`,
pr.party_alliance,
cr.`Total Votes`,
cr.margin,
cr.`Constituency Name`
FROM  constituencywise_results cr 
INNER JOIN partywise_results pr ON cr.`Party ID` = pr.`Party ID`
INNER JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
INNER JOIN states s ON s.`State ID` = sr.`State ID`
WHERE cr.`Constituency Name` = 'AGRA';


-- DISTRIBUTION OF EVM VOTES  v/s POSTAL VOTES FOR CANDIDATES IN A SPECIFIC CONSTITUENCY

SELECT cd.`EVM Votes`,
	   cd.`Postal Votes`,
       cd.`Total Votes`,
       cd.`Candidate`,
       cr.`Constituency Name`
FROM
constituencywise_results cr 
INNER JOIN constituencywise_details cd 
ON cr.`Constituency ID` = cd.`Constituency ID`
WHERE cr.`Constituency Name` = 'AMROHA';


-- WHICH PARTY WON THE MOST SEATS IN A STATE, AND HOW MANY SEATS DID EACH PARTY WIN?

SELECT 
p.Party, COUNT(cr.`Constituency ID`) AS Seats_Won
FROM
constituencywise_results cr 
JOIN partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN states s ON sr.`State ID` = s.`State ID`
WHERE 
	s.`State` = 'Uttar Pradesh'
GROUP BY p.Party
ORDER BY Seats_Won DESC;


-- What is the total number of seats won by each party alliance(NDA, INDIA, OTHER) in each state for the India Election 2024?

SELECT 
s.State,
SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END ) AS NDA_Seat_Won,
SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A.' THEN 1 ELSE 0 END ) AS INDIA_Seat_Won,
SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END ) AS OTHER_Seat_Won
FROM
constituencywise_results cr 
JOIN partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN states s ON sr.`State ID` = s.`State ID`
GROUP BY 1
ORDER BY s.State DESC;


-- Which candidate recieved the highest no of Votes for each Constiturncy (TOP 10)?

SELECT 
cr.`Constituency Name`,
cd.`Constituency ID`,
cd.`Candidate`,
cd.`EVM Votes`

FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE
	cd.`EVM Votes` =(
				SELECT MAX(cd1.`EVM Votes`)
                FROM constituencywise_details cd1
                WHERE cd1.`Constituency ID` = cd.`Constituency ID`
                )
	ORDER BY cd.`EVM Votes` DESC
    LIMIT 10;
    
    
-- Which candidate won and which cnadidate was the runner-up in each consistency of State for the 2024 elections`?
    
