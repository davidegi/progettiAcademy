-- DISCLAIMER: Il seguente contenuto del file .sql e il diagramma realizzato con draw.io si riferiscono alla sola giornata (e alla conseguente sera) del
-- 13/03/2024 e, di conseguenza, non contengono in alcun modo le migliorie e le modifiche del giorno successivo. Comportamento attuo alla sola possibilità
-- di analizzare e migliorare le mie capacità.
-- Davide.


CREATE TABLE Albergo(
	albergoID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	indirizzo VARCHAR(250) NOT NULL UNIQUE,
	valutazione INT NOT NULL CHECK (valutazione > 0 AND valutazione < 6),
);

-- INSERT INTO Albergo(nome, indirizzo, valutazione) VALUES -- primo tentativo INSERT (riscontro positivo)
-- ('Rosso', 'Via dei Gerani 23', 5);


DROP TABLE IF EXISTS Facility;
CREATE TABLE Facility(
	facilityID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(50) NOT NULL CHECK (nome IN ('palestra', 'piscina', 'spa')),
	descrizione TEXT,
	orarioApertura DATETIME NOT NULL,
	orarioChiusura DATETIME NOT NULL,
	albergoRIF INT NOT NULL,
	FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
);

-- SELECT * FROM Facility; -- primo tentativo di visualizzazione tabella (riscontro positivo)

DROP TABLE IF EXISTS Dipendente;
CREATE TABLE Dipendente(
	dipendenteID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	posizione VARCHAR(50) NOT NULL CHECK (posizione IN ('altro', 'receptionist', 'pulizia', 'manager')),
	email VARCHAR(250),
	documento VARCHAR(250) NOT NULL UNIQUE,
	albergoRIF INT NOT NULL,
	FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente(
	clienteID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250)NOT NULL,
	email VARCHAR(250),
	documento VARCHAR(250) NOT NULL UNIQUE,
	prenotazioneRIF INT NOT NULL,
	-- FOREIGN KEY (prenotazioneRIF) REFERENCES Prenotazione(prenotazioneID) ON DELETE CASCADE, eliminato al termine di un confronto con un mio collega
);

DROP TABLE IF EXISTS Prenotazione;
CREATE TABLE Prenotazione(
	prenotazioneID INT PRIMARY KEY IDENTITY (1,1),
	checkIn DATETIME NOT NULL,
	checkOut DATETIME NOT NULL,
	cameraRIF INT NOT NULL,
	clienteRIF INT NOT NULL,
	FOREIGN KEY (cameraRIF) REFERENCES Camera(cameraID) ON DELETE CASCADE,
	FOREIGN KEY (clienteRIF) REFERENCES Cliente(clienteID) ON DELETE CASCADE,
);

-- SELECT * FROM Albergo;

DROP TABLE IF EXISTS Camera;
CREATE TABLE Camera(
	cameraID INT PRIMARY KEY IDENTITY (1,1),
	numUnico INT NOT NULL UNIQUE,
	tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('singola', 'doppia', 'tripla', 'suite')),
	capMax INT NOT NULL,
	tariffa DECIMAL(10, 2) NOT NULL,
	albergoRIF INT NOT NULL,
	prenotazioneRIF INT NOT NULL,
	FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
	FOREIGN KEY (prenotazioneRIF) REFERENCES Prenotazione(prenotazioneID) ON DELETE CASCADE,
);