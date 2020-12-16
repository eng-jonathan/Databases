
CREATE TABLE [Location].[BuildingLocation](
	[BuildingKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY,
	[BuildingLocation] [Udt].[Location] NOT NULL,
	[RoomLocationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[RoomLocation] [Udt].[Location] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME()
);




