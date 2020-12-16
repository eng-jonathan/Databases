USE QueensClassScheduleSpring2017;

/*Table Creation*/
CREATE TABLE [Location].[RoomLocation]
( 
	[RoomLocationKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY,
	[RoomLocation] [Udt].[RoomLocation] NOT NULL DEFAULT 'AA TBA',
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL
		DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [Udt].[DateOf] NULL
		DEFAULT SYSDATETIME()
);