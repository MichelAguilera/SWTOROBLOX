local ServerScriptService = game:GetService("ServerScriptService")
s = {}

-- DIRECTORIES
s.sss = game:GetService("ServerScriptService")
s.rs = game:GetService("ReplicatedStorage")
s.ss = game:GetService("ServerStorage")
s.w = game:GetService("Workspace")

-- SERVICES
s.plrs = game:GetService("Players")
s.dss = game:GetService("DataStoreService") -- LEGACY
s.chat = game:GetService("Chat")

-- MODULES
s.ds2 = s.rs.Common:WaitForChild('RojoModules'):WaitForChild('DataStore2') -- PLANNED

return s