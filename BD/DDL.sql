CREATE DATABASE Senai_Vagas;
GO

USE Senai_Vagas;
GO

CREATE TABLE TipoUsuario (
	IdTipoUsuario	INT PRIMARY KEY IDENTITY
	,Titulo	VARCHAR(255) NOT NULL UNIQUE 
);
GO

CREATE TABLE Curso (
	IdCursos	INT PRIMARY KEY IDENTITY 
	,Titulo	VARCHAR(255) NOT NULL UNIQUE
);
GO

CREATE TABLE Endereco (
	IdEndereco	INT PRIMARY KEY IDENTITY 
	,Cep		CHAR(8) NOT NULL
	,Logradouro	VARCHAR(255) NOT NULL
	,Complemento	VARCHAR(255)
	,Bairro		VARCHAR(255) NOT NULL
	,Uf			VARCHAR(255) NOT NULL
	,Cidade		VARCHAR(255) NOT NULL
	,Numero		INT NOT NULL
);
GO 

CREATE TABLE PerfilComportamental (
	IdPerfilComportamental	INT PRIMARY KEY IDENTITY
	,Gato		DECIMAL NOT NULL
	,Aguia		DECIMAL NOT NULL
	,Tubarao	DECIMAL NOT NULL
	,Lobo		DECIMAL NOT NULL
);
GO 

CREATE TABLE Situacao (
	IdSituacao	INT PRIMARY KEY IDENTITY
	,Titulo	VARCHAR(255) NOT NULL UNIQUE
);
GO

CREATE TABLE Dicas (
	IdDica	INT PRIMARY KEY IDENTITY 
	,Titulo	VARCHAR(255) NOT NULL
	,Descricao	TEXT NOT NULL
	,Link	NVARCHAR(255)
);
GO

CREATE TABLE FormaContratacao (
	IdFormaContratacao	INT PRIMARY KEY IDENTITY
	,Forma	VARCHAR(255) NOT NULL UNIQUE
);
GO

CREATE TABLE Usuario (
	IdUsuario	INT PRIMARY KEY IDENTITY
	,Email		VARCHAR(255) NOT NULL UNIQUE
	,Senha		VARCHAR(255) NOT NULL
	,FkTipoUsuario	INT FOREIGN KEY REFERENCES TipoUsuario (IdTipoUsuario)
);
GO

CREATE TABLE Administrador (
	IdAdministrador	INT PRIMARY KEY IDENTITY
	,Nome			VARCHAR(255) NOT NULL
	,Cpf			CHAR(11) NOT NULL UNIQUE
	,FkUsuario		INT FOREIGN KEY REFERENCES Usuario (IdUsuario)
);
GO

CREATE TABLE Candidato (
	IdCandidato	INT PRIMARY KEY IDENTITY 
	,Nome		VARCHAR(255) NOT NULL
	,Sobrenome	VARCHAR(255) NOT NULL
	,Telefone	CHAR(11) NOT NULL 
	,LinkedIn	NVARCHAR(255) NOT NULL UNIQUE
	,GitHub		NVARCHAR(255) NOT NULL UNIQUE 
	,Apresentacao	TEXT NOT NULL 
	,CPF		CHAR(11) NOT NULL UNIQUE
	,Foto		NVARCHAR(255)
	,EmailContato	NVARCHAR(255) NOT NULL 
	,FkUsuario	INT FOREIGN KEY REFERENCES Usuario (IdUsuario)
	,FkCurso	INT FOREIGN KEY REFERENCES Curso (IdCursos)
	,FkPerfilComportamental	INT FOREIGN KEY REFERENCES PerfilComportamental (IdPerfilComportamental)
	,FkEndereco	INT FOREIGN KEY REFERENCES Endereco (IdEndereco)
	,FkSituacao INT FOREIGN KEY REFERENCES Situacao (IdSituacao) 
);
GO 

CREATE TABLE Empresa (
	IdEmpresa	INT PRIMARY KEY IDENTITY
	,StatusEmpresa	BIT NOT NULL
	,RazaoSocial	VARCHAR(255) NOT NULL 
	,Cnpj			CHAR(14) NOT NULL UNIQUE 
	,Telefone		CHAR(11) NOT NULL 
	,CNAE		VARCHAR(255) NOT NULL
	,Apresentacao	TEXT NOT NULL
	,NomeResponsavel	VARCHAR(255) NOT NULL
	,CargoExercido	VARCHAR(255) NOT NULL
	/*NumeroFuncionarios	INT NOT NULL*/
	,Logo		NVARCHAR(255) NOT NULL
	,EmailContato	NVARCHAR(255) NOT NULL 
	,FkUsuario	INT FOREIGN KEY REFERENCES Usuario (IdUsuario)
	,FkEndereco	INT FOREIGN KEY REFERENCES Endereco (IdEndereco)
);
GO

CREATE TABLE Vaga (
	IdVaga	INT PRIMARY KEY IDENTITY
	,Descricao	TEXT NOT NULL 
	,Habilidades	TEXT NOT NULL
	,PlanoEstagio BIT NOT NULL
	,AreaVaga VARCHAR(255)
	,Cargo VARCHAR(255)
	,FkEmpresa	INT FOREIGN KEY REFERENCES Empresa (IdEmpresa)
	,FkFormaContratacao	INT FOREIGN KEY REFERENCES FormaContratacao (IdFormaContratacao) 
	,FkEndereco	INT FOREIGN KEY REFERENCES Endereco (IdEndereco)
);
GO

CREATE TABLE Inscricao (
	IdInscricao	INT PRIMARY KEY IDENTITY 
	,StatusIncricao	BIT NOT NULL
	,IdVaga	INT FOREIGN KEY REFERENCES Vaga (IdVaga)
	,Fkcandidato	INT FOREIGN KEY REFERENCES Candidato (IdCandidato)
);
GO

CREATE TABLE ContratoEstagio (
	IdContratoEstagio	INT PRIMARY KEY IDENTITY
	,DataInicio	DATETIME2 NOT NULL
	,DataTermino	DATETIME2 NOT NULL
	,MotivoEvasao	VARCHAR(255) 
	,Avaliacao1	NVARCHAR(MAX) NOT NULL
	,Avaliacao2	NVARCHAR(MAX) NOT NULL
	,Avaliacao3	NVARCHAR(MAX) NOT NULL
	,Avaliacao4	NVARCHAR(MAX) NOT NULL
	,FkStatusEstagio INT FOREIGN KEY REFERENCES Situacao(IdSituacao)
	,FkCandidato	INT FOREIGN KEY REFERENCES Candidato (IdCandidato)
	,FkVaga		INT FOREIGN KEY REFERENCES Vaga (IdVaga)
);
GO