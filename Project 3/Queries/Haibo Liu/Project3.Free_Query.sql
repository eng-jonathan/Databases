SELECT DISTINCT BuildingLocation, RoomLocation
FROM [Location].[BuildingLocation]
group by BuildingLocation,RoomLocation
order by BuildingLocation Desc