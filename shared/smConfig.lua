SMConfig = {
    data = {
        -- If false then use smodsk_shellBuilder_job to create public shells where you can choose 
        -- For the sake of your server it might be better not to allow normal players to create custom shells
        allowPlayerModifications = true,
        shellSizes = {
            { name = "Mini One", size = {5, 1} },
            { name = "Mini Two", size = {5, 2} },
            { name = "Mini Three", size = {5, 3} },
            
            { name = "Medium One", size = {7, 1} },
            { name = "Medium Two", size = {7, 2} },
            { name = "Medium Three", size = {7, 2} },
            
            { name = "Large One", size = {9, 1} },
            { name = "Large Two", size = {9, 2} },
            { name = "Large Three", size = {9, 2} },
        },

        stash = {
            maxweight = 1000000,
            slots = 30,
        }
    },
    functions = {
        getPublicShells = function()
            return exports["smodsk_shellBuilder"]:GetPublicIds()
        end
    }
}

if not IsDuplicityVersion() then
    exports('GetSMConfig', function()
        return SMConfig
    end)
end