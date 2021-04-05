    --TEAM 11

set search_path to 'unicorsi';

--INTERROGAZIONI SU SINGOLA RELAZIONE
--1
SELECT Matricola
FROM Studenti
WHERE Nome='Mario' AND Cognome='Rossi' AND Iscrizione='2009';

--2
SELECT DISTINCT Residenza 
FROM Studenti
WHERE Residenza!='Genova'
ORDER BY Residenza ASC;

--3
SELECT DISTINCT Matricola, Nome, Cognome 
FROM Studenti
WHERE Iscrizione<2007 AND Relatore IS NULL;

--4
SELECT DISTINCT Studente
FROM Esami
WHERE Data > '2009-02-02';

--5
SELECT Id
FROM Professori
WHERE Stipendio BETWEEN 12500 AND 16000 AND Nome LIKE '%te%';

--6
SELECT Denominazione, Facolta
FROM CorsiDiLaurea
WHERE Attivazione < '2006/2007' OR Attivazione > '2009/2010'
ORDER BY Facolta, Denominazione ;

--7
SELECT Matricola, Nome, Cognome
FROM Studenti
WHERE Residenza IN ('Genova', 'La Spezia', 'Savona') OR Cognome NOT IN ('Serra', 'Melogno', 'Giunchi')
ORDER BY Matricola DESC;

--INTERROGAZIONI CHE COINVOLGONO PIU' RELAZIONI
--1
SELECT Matricola
FROM Studenti JOIN CorsiDiLaurea ON CorsoDiLaurea=id
WHERE Laurea<'2009-11-01' AND Denominazione='Informatica';
--2
SELECT Cognome, Nome, Denominazione, Corsi.id
FROM Corsi JOIN Professori ON Corsi.Professore=Professori.id
ORDER BY Corsi.id DESC ;
--3
SELECT Corsi.Denominazione, Corsi.CorsoDiLaurea, Professori.Cognome
FROM Corsi JOIN Professori ON Professore=Professori.id
WHERE Attivato=TRUE
ORDER BY Corsi.CorsoDiLaurea, Corsi.Denominazione;

--4
SELECT Studenti.Nome, Studenti.Cognome, Professori.Cognome AS Relatore
FROM Studenti JOIN Professori ON Studenti.Relatore=Professori.id
ORDER BY Studenti.Cognome;

--5
SELECT *
FROM Corsi JOIN CorsiDiLaurea ON Corsi.CorsoDiLaurea=CorsiDiLaurea.Id
WHERE Attivato=TRUE
    AND CorsiDiLaurea.Denominazione='Informatica'
    AND Corsi.Denominazione LIKE '__s%';

--6
SELECT Esami.Studente
FROM Corsi 
JOIN Esami ON Esami.Corso=Corsi.id
JOIN CorsiDiLaurea ON Corsi.CorsoDiLaurea=CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione='Matematica'
    AND Corsi.Denominazione='Informatica Generale'
    AND Esami.Voto >= 18
    AND Esami.Data='2012-02-15';
    
--7

SELECT DISTINCT Studenti.Cognome, Studenti.Nome
FROM Studenti
JOIN PianiDiStudio
ON Studenti.Matricola=PianiDiStudio.Studente
JOIN CorsiDiLaurea
ON Studenti.CorsoDiLaurea=CorsiDiLaurea.id
WHERE PianiDiStudio.Anno=5
    AND CorsiDiLaurea.Denominazione='Informatica'
    AND Studenti.Relatore IS NOT NULL
    AND PianiDiStudio.AnnoAccademico = '2011'
ORDER BY Studenti.Cognome DESC;

--OPERAZIONI INSIEMISTICHE
--1
SELECT Nome, Cognome FROM Studenti
UNION
SELECT Nome, Cognome FROM Professori;

--2
SELECT Nome, Cognome, 'studente' FROM Studenti
UNION
SELECT Nome, Cognome, 'professore' FROM Professori;

--3
SELECT Nome, Cognome FROM Studenti
INTERSECT
SELECT Nome, Cognome FROM Professori;

--4
SELECT Nome, Cognome FROM Studenti
EXCEPT
SELECT Nome, Cognome FROM Professori;

--5
SELECT Esami.Studente
FROM Corsi
JOIN Esami
ON Corsi.id=Esami.Corso
JOIN CorsiDiLaurea
ON Corsi.CorsoDiLaurea=CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione='Informatica'
    AND Corsi.Denominazione='Basi Di Dati 1'
    AND Esami.voto >=18
    AND Esami.Data BETWEEN '2010-06-01' AND '2010-06-30'

EXCEPT

SELECT Esami.Studente
FROM Corsi
JOIN Esami
ON Corsi.id=Esami.Corso
JOIN CorsiDiLaurea
ON Corsi.CorsoDiLaurea=CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione='Informatica'
    AND Corsi.Denominazione='Interfacce Grafiche'
    AND Esami.voto >= 18
    AND Esami.Data BETWEEN '2010-06-01' AND '2010-06-30';

--6

SELECT Esami.Studente
FROM Corsi
JOIN Esami
ON Corsi.id=Esami.Corso
JOIN CorsiDiLaurea
ON Corsi.CorsoDiLaurea=CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione='Informatica'
    AND Corsi.Denominazione='Basi Di Dati 1'
    AND Esami.voto >=18
    AND Esami.Data BETWEEN '2010-06-01' AND '2010-06-30'

INTERSECT

SELECT Esami.Studente
FROM Corsi
JOIN Esami
ON Corsi.id=Esami.Corso
JOIN CorsiDiLaurea
ON Corsi.CorsoDiLaurea=CorsiDiLaurea.id
WHERE CorsiDiLaurea.Denominazione='Informatica'
    AND Corsi.Denominazione='Interfacce Grafiche'
    AND Esami.voto >= 18
    AND Esami.Data BETWEEN '2010-06-01' AND '2010-06-30';


-----------------------------------------------> Durante ore Laboratorio: 3 per ogni categoria
Firme: Davide Romano, Camilla Simonini, Matteo Mannai, Santiago Laverde Vardabasso