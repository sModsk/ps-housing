function SpawnSMShell(id, coords, property)
    local self = {
        property = property,
        doorPosition = nil,
        garageDoorPosition = nil
    }


    self.RegisterDoorZone = function(offset)
        local function leave()
            self.property:LeaveShell()
        end
    
        local function checkDoor()
            self.property:OpenDoorbellMenu()
        end
    
        local size = vector3(1.0, 1.5, 3.0)
        self.property.exitTarget = Framework[Config.Target].AddDoorZoneInside(vec3(offset.x, offset.y, offset.z + 1), size, offset.w, leave, checkDoor)
    end

    self.DoorPositionChanged = function(door, position)
        Framework[Config.Target].RemoveTargetZone(self.property.exitTarget)

        if door == "door" then
           self.doorPosition = position
        elseif door == "garage" then
            self.garageDoorPosition = position
        end

        if self.doorPosition then
            self.RegisterDoorZone(self.doorPosition)
        else
            self.RegisterDoorZone(self.garageDoorPosition)
        end
    end

    self.DespawnShell = function()
        exports["smodsk_shellBuilder"]:DespawnShell()
    end

    self.Init = function()
        self.success, self.doorPosition, self.garageDoorPosition =  exports["smodsk_shellBuilder"]:SpawnShell(
        {
            id = id,
            position = coords,
            doorPositionChanged = function(door, position)
                self.DoorPositionChanged(door, position)
            end,
            canOpenMenu = function()
                return SMConfig.data.allowPlayerModifications and property.owner
            end,
            canTogglePublic = function()
                return false
            end,
            canBuild = function()
                return SMConfig.data.allowPlayerModifications and property.owner 
            end,
            canPaint = function()
                return SMConfig.data.allowPlayerModifications and property.owner 
            end
        })
        
        if self.doorPosition then
            self.RegisterDoorZone(self.doorPosition)
        else
            self.RegisterDoorZone(self.garageDoorPosition)
        end

        if self.doorPosition then
            SetEntityCoordsNoOffset(cache.ped, self.doorPosition.x, self.doorPosition.y, self.doorPosition.z + 1, false, false, true)
            SetEntityHeading(cache.ped, self.doorPosition.w)
        else
            SetEntityCoordsNoOffset(cache.ped, self.garageDoorPosition.x, self.garageDoorPosition.y, self.garageDoorPosition.z + 1, false, false, true)
            SetEntityHeading(cache.ped, self.garageDoorPosition.w)
        end
    end


    self.Init()
    
    return self
end
