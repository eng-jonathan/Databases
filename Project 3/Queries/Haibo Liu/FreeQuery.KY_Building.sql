--show all Buildings begin with letter KY
SELECT BuildingLocation,RoomLocation
FROM [Location].BuildingLocation
WHERE BuildingLocation Like 'KY'
