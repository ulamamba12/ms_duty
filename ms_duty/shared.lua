Config = {}

Config.Jobs = {
    ["police"] = true,
    ["ambulance"] = true,
    ["mechanic"] = true,
    -- You can add more job here
}

-- Location Toggle Duty (Can add multiple coords for 1 job)
Config.DutyLocations = {
    ["police"] = {
        { coords = vector3(441.99, -979.41, 31.54),   heading = 0.0,  name = "MRPD Duty" },
    --  { coords = vector3(123.45, -678.90, 98.76),   heading = 0.0,  name = "Your_duty_place" }, you can add more coords for this job  
    },
    ["ambulance"] = {
        { coords = vector3(300.0, -600.0, 43.0), heading = 0.0, name = "Pillbox Duty" },
    },
    ["mechanic"] = {
        { coords = vector3(-200.0, -1300.0, 31.0), heading = 180.0, name = "LS Customs Duty" },
    },
}

Config.CommandName = "aduty"
Config.CommandHelp = "Toggle On/Off Duty"