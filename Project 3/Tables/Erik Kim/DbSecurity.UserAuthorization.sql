CREATE TABLE [DbSecurity].[UserAuthorization]
(
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ClassTime] [Udt].[ClassTime] NULL DEFAULT ('10:45'),
	[IndividualProject] [Udt].[IndividualProject] NULL DEFAULT('PROJECT 3'),
	[GroupMemberLastName] [Udt].[Name] NOT NULL,
	[GroupMemberFirstName] [Udt].[Name] NOT NULL,
	[GroupName] [Udt].[Name] NOT NULL DEFAULT ('GROUP 4'),
	[DateAdded] [Udt].[DateOf] NULL DEFAULT SYSDATETIME()
)

INSERT INTO [DbSecurity].[UserAuthorization]
(
    GroupMemberLastName,
    GroupMemberFirstName
)
VALUES
('Kim', 'Erik'),      --1
('Liyal', 'Harjit'),  --2
('Kong', 'Danny'),    --3
('Eng', 'Jonathan'),  --4
('Louis', 'Marlon'),  --5
('Kocacal', 'Jamil'), --6
('Liu', 'Haibo');     --7
GO