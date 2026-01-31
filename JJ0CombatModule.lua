-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-01-31 09:49:31
-- Luau version 6, Types version 3
-- Time taken: 0.121450 seconds

local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Client = game:GetService("Players").LocalPlayer.PlayerScripts.Client
local STATES_upvr = require(Client.STATES)
local NetworkController = require(Client.Controllers.NetworkController)
local CharacterController_upvr = require(Client.Controllers.CharacterController)
local signal = require(ReplicatedStorage_upvr.Packages.signal)
ocal CombatConfig_upvr = require(ReplicatedStorage_upvr.Configs.CombatConfig)
local module_4_upvr = {
	CooldownStarted = signal.new();
	CooldownEnded = signal.new();
	HitboxParried = signal.new();
	OnClientDamaged = signal.new();
}
local StatsConfig_upvr = require(ReplicatedStorage_upvr.Configs.StatsConfig)
local PlayerDataController_upvr = require(Client.Controllers.PlayerDataController)
local InventoryController_upvr = require(Client.Controllers.InventoryController)
function module_4_upvr.PreCooldown(arg1, arg2, arg3, arg4, arg5) -- Line 45
	--[[ Upvalues[5]:
		[1]: CombatConfig_upvr (readonly)
		[2]: CharacterController_upvr (readonly)
		[3]: StatsConfig_upvr (readonly)
local CombatConfig_upvr = require(ReplicatedStorage_upvr.Configs.CombatConfig)
local module_4_upvr = {
	CooldownStarted = signal.new();
	CooldownEnded = signal.new();
	HitboxParried = signal.new();
	OnClientDamaged = signal.new();
}
local StatsConfig_upvr = require(ReplicatedStorage_upvr.Configs.StatsConfig)
local PlayerDataController_upvr = require(Client.Controllers.PlayerDataController)
local InventoryController_upvr = require(Client.Controllers.InventoryController)
function module_4_upvr.PreCooldown(arg1, arg2, arg3, arg4, arg5) -- Line 45
	--[[ Upvalues[5]:
		[1]: CombatConfig_upvr (readonly)
		[2]: CharacterController_upvr (readonly)
		[3]: StatsConfig_upvr (readonly)
		[4]: PlayerDataController_upvr (readonly)
		[5]: InventoryController_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local CharacterStates = arg2.CharacterStates
	local var18
	if not arg4 then
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			var18 = CharacterStates.SkillConfig[arg3]
			return var18
		end
		if not CharacterStates.SkillConfig or not INLINED_3() then
			var18 = CombatConfig_upvr.SkillData[arg3]
		end
		if not var18 then return end
		if arg3 ~= "Punch" then
			local var19
			if arg2 == CharacterController_upvr.LocalCharacter then
				var19 = PlayerDataController_upvr
				local function INLINED_4() -- Internal function, doesn't exist in bytecode
					var19 = InventoryController_upvr.CurrentInventory.Items
					return var19
				end
				if not InventoryController_upvr.CurrentInventory or not INLINED_4() then
					var19 = nil
				end
			end
		end
	end
	CharacterStates.Cooldowns[arg3] = {
		TimeElapsed = 0;
		Duration = var18.Cooldown / StatsConfig_upvr.GetStatTotal("CDR%", var19.PlayerData, var19, CharacterStates) * (arg5 or 1);
		Conn = nil;
	}
end
function module_4_upvr.ContinueCooldown(arg1, arg2, arg3) -- Line 71
	--[[ Upvalues[2]:
		[1]: module_4_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	local var21_upvr = arg2.CharacterStates.Cooldowns[arg3]
	if not var21_upvr or var21_upvr.IsContinuing then
	else
		var21_upvr.IsContinuing = true
		var21_upvr.Conn = RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 76
			--[[ Upvalues[4]:
				[1]: var21_upvr (readonly)
				[2]: arg2 (readonly)
				[3]: arg3 (readonly)
				[4]: module_4_upvr (copied, readonly)
			]]
			local var23 = var21_upvr
			var23.TimeElapsed += arg1_2
			if var21_upvr.Duration <= var21_upvr.TimeElapsed then
				var21_upvr.Conn:Disconnect()
				arg2.CharacterStates.Cooldowns[arg3] = nil
				module_4_upvr.CooldownEnded:Fire(arg2, arg3)
			end
		end)
		module_4_upvr.CooldownStarted:Fire(arg2, arg3, var21_upvr)
	end
end
function module_4_upvr.Cooldown(arg1, arg2, arg3, arg4, arg5) -- Line 91
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	module_4_upvr:PreCooldown(arg2, arg3, arg4, arg5)
	module_4_upvr:ContinueCooldown(arg2, arg3)
end
function module_4_upvr.InCooldown(arg1, arg2, arg3) -- Line 96
	if arg2.CharacterStates.Cooldowns[arg3] then
		return true
	end
	return false
end
function module_4_upvr.AttemptCooldown(arg1, arg2, arg3, arg4) -- Line 104
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	if module_4_upvr:InCooldown(arg2, arg3) then
		return false
	end
	module_4_upvr:Cooldown(arg2, arg3, arg4)
	return true
end
local tbl_3_upvr = {}
STATES_upvr.ActiveHitboxes = tbl_3_upvr
module_4_upvr.HitboxParams = OverlapParams.new()
module_4_upvr.HitboxParams.FilterType = Enum.RaycastFilterType.Include
module_4_upvr.HitboxParams.FilterDescendantsInstances = {workspace.Characters, workspace.Container.Hitboxes}
function module_4_upvr.GetHitbox(arg1, arg2) -- Line 119
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	return tbl_3_upvr[arg2]
end
function module_4_upvr.GetHitboxes(arg1) -- Line 123
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	return tbl_3_upvr
end
function module_4_upvr.GetHitboxFromHitboxPart(arg1, arg2) -- Line 127
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	for _, v in module_4_upvr:GetHitboxes() do
		if v.Hitbox and v.Hitbox == arg2 then
			return v
		end
		if v.Hitboxes and table.find(v, arg2) then
			return v
		end
	end
end
function module_4_upvr.GetCharacterHitboxes(arg1, arg2) -- Line 139
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	local module = {}
	for _, v_2 in tbl_3_upvr do
		if v_2.HitboxOptions.LocalCharacter and v_2.HitboxOptions.LocalCharacter == arg2 then
			table.insert(module, v_2)
		end
	end
	if 0 < #module then
		return module
	end
	return nil
end
function module_4_upvr.CreateHitbox(arg1, arg2, arg3) -- Line 155
	--[[ Upvalues[3]:
		[1]: CombatConfig_upvr (readonly)
		[2]: ReplicatedStorage_upvr (readonly)
		[3]: tbl_3_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var58
	if arg3.CanDodge == nil then
		arg3.CanDodge = true
	end
	var58 = arg3.ID:split('_')
	local _3_2 = var58[3]
	var58 = _3_2
	if var58 then
		var58 = CombatConfig_upvr.SkillData[_3_2]
	end
	if var58 then
		if arg3.LocalCharacter and arg3.LocalCharacter.CharacterStates and arg3.LocalCharacter.CharacterStates[_3_2] then
		end
	end
	if arg3.LocalCharacter.CharacterStates[_3_2] then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		if arg3.LocalCharacter.CharacterStates[_3_2].CanParry and arg3.CanParry == nil then
			arg3.CanParry = true
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	if arg3.LocalCharacter.CharacterStates[_3_2] and arg3.LocalCharacter.CharacterStates[_3_2].IsParryable and arg3.IsParryable == nil then
		arg3.IsParryable = true
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	if arg3.LocalCharacter.CharacterStates[_3_2] and arg3.LocalCharacter.CharacterStates[_3_2].CanDodge == false and arg3.IsParryable == nil then
		arg3.CanDodge = nil
	end
	if arg3.LocalCharacter and arg3.LocalCharacter.ServerModel.Parent == workspace.Characters.Server.Players then
		arg3.IsParryable = nil
	end
	local module_3_upvr = {
		ID = arg3.ID;
		CreationTime = os.clock();
	}
	module_3_upvr.HitboxOptions = arg3
	module_3_upvr.IsDestroyed = false
	if typeof(arg2) == "table" then
		module_3_upvr.Hitboxes = arg2
		module_3_upvr.Offset = CFrame.new()
		local tbl_4 = {}
		arg3.HitboxesOffsets = tbl_4
		for i_3, v_3 in arg2 do
			tbl_4[v_3] = v_3.CFrame
			v_3.Parent = workspace.Container.Hitboxes
			local var62
		end
	else
		var62 = arg3.Size
		if var62 then
			var62 = arg3.Size
			arg2.Size = var62
		end
		var62 = workspace.Container.Hitboxes
		arg2.Parent = var62
		module_3_upvr.Hitbox = arg2
		var62 = CFrame.new()
		module_3_upvr.Offset = var62
	end
	if arg3.CanDodge then
		module_3_upvr.Dodges = {}
		local var63
		local function INLINED_13() -- Internal function, doesn't exist in bytecode
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return arg3.LocalCharacter.CharacterStates[_3_2]
		end
		local function INLINED_14() -- Internal function, doesn't exist in bytecode
			var63 = arg3.LocalCharacter.CharacterStates[_3_2].DodgeRadius
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var63
		end
		if not var63 and (not INLINED_13() or not INLINED_14()) then
			var63 = CombatConfig_upvr.DEFAULT_DODGE.DodgeRadius
		end
		arg3.DodgeRadius = var63
		var63 = arg3.DodgeTime
		local function INLINED_15() -- Internal function, doesn't exist in bytecode
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return arg3.LocalCharacter.CharacterStates[_3_2]
		end
		local function INLINED_16() -- Internal function, doesn't exist in bytecode
			var63 = arg3.LocalCharacter.CharacterStates[_3_2].DodgeTime
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var63
		end
		if not var63 and (not INLINED_15() or not INLINED_16()) then
			var63 = CombatConfig_upvr.DEFAULT_DODGE.DodgeTime
		end
		arg3.DodgeTime = var63
	end
	if arg3.IsParryable then
		local var64_upvr
		local function INLINED_17() -- Internal function, doesn't exist in bytecode
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return arg3.LocalCharacter.CharacterStates[_3_2]
		end
		local function INLINED_18() -- Internal function, doesn't exist in bytecode
			var64_upvr = arg3.LocalCharacter.CharacterStates[_3_2].ParryRadius
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var64_upvr
		end
		if not var64_upvr and (not INLINED_17() or not INLINED_18()) then
			var64_upvr = 1
		end
		arg3.ParryRadius = var64_upvr
		var64_upvr = arg3.ParryInterval
		local function INLINED_19() -- Internal function, doesn't exist in bytecode
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return arg3.LocalCharacter.CharacterStates[_3_2]
		end
		local function INLINED_20() -- Internal function, doesn't exist in bytecode
			var64_upvr = arg3.LocalCharacter.CharacterStates[_3_2].ParryInterval
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var64_upvr
		end
		if not var64_upvr and (not INLINED_19() or not INLINED_20()) then
			var64_upvr = 0.5
		end
		arg3.ParryInterval = var64_upvr
		i_3 = ReplicatedStorage_upvr
		var64_upvr = i_3.Assets.Models.Generic.ParryHitbox:Clone()
		i_3 = arg3.ParryRadius
		var64_upvr.Size = Vector3.new(1, 1, 1) * (i_3 or 1)
		module_3_upvr.ParryHitbox = var64_upvr
		if arg3.LocalCharacter then
			var64_upvr.CFrame = arg3.LocalCharacter.ServerModel:GetPivot()
			var64_upvr.Parent = workspace.Container.Hitboxes
		end
		task.delay(arg3.ParryInterval or 0.5, function() -- Line 233
			--[[ Upvalues[2]:
				[1]: module_3_upvr (readonly)
				[2]: var64_upvr (readonly)
			]]
			module_3_upvr.ParryHitbox = nil
			var64_upvr:Destroy()
		end)
	end
	tbl_3_upvr[arg3.ID] = module_3_upvr
	return module_3_upvr
end
function module_4_upvr.CloneHitbox(arg1, arg2, arg3) -- Line 244
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local clone_2 = arg2:Clone()
	local var67
	if not arg3.CFrame then
		local function INLINED_21() -- Internal function, doesn't exist in bytecode
			var67 = arg3.Parent.CFrame
			return var67
		end
		if not arg3.Parent or not INLINED_21() then
			local function INLINED_22() -- Internal function, doesn't exist in bytecode
				var67 = arg3.LocalCharacter.ServerModel.PrimaryPart.CFrame
				return var67
			end
			if not arg3.LocalCharacter or not INLINED_22() then
				var67 = arg3.Origin
			end
		end
	end
	clone_2.CFrame = var67 * clone_2.CFrame
	local any_CreateHitbox_result1 = module_4_upvr:CreateHitbox(clone_2, arg3)
	any_CreateHitbox_result1.Offset = arg2.CFrame
	return any_CreateHitbox_result1
end
function module_4_upvr.DestroyHitbox(arg1, arg2) -- Line 254
	--[[ Upvalues[2]:
		[1]: STATES_upvr (readonly)
		[2]: tbl_3_upvr (readonly)
	]]
	arg2.IsDestroyed = true
	if not STATES_upvr.EnableHitboxesDestroy:get() then
	else
		tbl_3_upvr[arg2.ID] = nil
		if arg2.Hitbox then
			arg2.Hitbox:Destroy()
		end
		if arg2.Hitboxes then
			for _, v_7 in arg2.Hitboxes do
				v_7:Destroy()
			end
		end
	end
end
function module_4_upvr.GetHitboxesInCharacter(arg1, arg2) -- Line 271
	--[[ Upvalues[2]:
		[1]: tbl_3_upvr (readonly)
		[2]: module_4_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 32 start (CF ANALYSIS FAILED)
	if arg2.ServerModel.Parent ~= workspace.Characters.Server.Players then
	else
	end
	-- KONSTANTERROR: [0] 1. Error Block 32 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [104] 65. Error Block 22 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [104] 65. Error Block 22 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [22] 15. Error Block 6 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [104.9]
	-- KONSTANTERROR: [22] 15. Error Block 6 end (CF ANALYSIS FAILED)
end
function module_4_upvr.GetHitboxesInRadiusAroundCharacter(arg1, arg2, arg3) -- Line 302
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 37 start (CF ANALYSIS FAILED)
	if typeof(arg3) ~= "number" then
	else
	end
	-- KONSTANTERROR: [0] 1. Error Block 37 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [113] 74. Error Block 28 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [113] 74. Error Block 28 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [15] 13. Error Block 6 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [113.10]
	-- KONSTANTERROR: [15] 13. Error Block 6 end (CF ANALYSIS FAILED)
end
function module_4_upvr.GetCharactersInHitbox(arg1, arg2) -- Line 343
	--[[ Upvalues[2]:
		[1]: module_4_upvr (readonly)
		[2]: CharacterController_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local LocalCharacter_2 = arg2.HitboxOptions.LocalCharacter
	if LocalCharacter_2 and (LocalCharacter_2:IsDead() or LocalCharacter_2.IsDestroyed) then
	end
	if nil then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		if nil.ServerModel.Parent ~= workspace.Characters.Server.Players then
		else
		end
	end
	if arg2.Hitbox then
		local _ = {arg2.Hitbox}
	elseif arg2.Hitboxes then
	end
	for _, v_4 in arg2.Hitboxes do
		for _, v_5 in workspace:GetPartsInPart(v_4, module_4_upvr.HitboxParams) do
			if v_5:IsA("BasePart") and v_5.Parent and v_5.Parent.Parent then
				local var93
				if var93 == workspace.Container.Hitboxes then
					local function INLINED_23() -- Internal function, doesn't exist in bytecode
						local var94 = var93
						var93 = module_4_upvr:GetHitboxFromHitboxPart(v_5)
						return var94
					end
					local function INLINED_24() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil
					end
					local function INLINED_25() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return var94.HitboxOptions.LocalCharacter ~= nil
					end
					if true and INLINED_23() and var94 ~= arg2 and v_5 == var94.ParryHitbox and (not INLINED_24() or INLINED_25()) or var94.HitboxOptions.LocalCharacter then
						-- KONSTANTWARNING: GOTO [128] #84
					end
				else
					var94 = CharacterController_upvr.FindCharacterFromWorldModel(v_5.Parent.Parent)
					local var95 = var94
					local function INLINED_26() -- Internal function, doesn't exist in bytecode
						var94 = var95:IsInvincible()
						return var94
					end
					local function INLINED_27() -- Internal function, doesn't exist in bytecode
						var94 = var95:IsDead()
						return var94
					end
					local function INLINED_28() -- Internal function, doesn't exist in bytecode
						var94 = table.find({}, var95)
						return var94
					end
					local function INLINED_29() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil
					end
					local function INLINED_30() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil ~= var95
					end
					if var95 and not INLINED_26() and not INLINED_27() and not INLINED_28() and (not INLINED_29() or INLINED_30()) then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
						local function INLINED_31() -- Internal function, doesn't exist in bytecode
							var94 = nil.CharacterStates.FriendlyFire
							return var94
						end
						local function INLINED_32() -- Internal function, doesn't exist in bytecode
							var94 = var95.CharacterStates.FriendlyFire
							return var94
						end
						local function INLINED_33() -- Internal function, doesn't exist in bytecode
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							var94 = var95.ServerModel.Parent
							return var94 ~= nil.ServerModel.Parent
						end
						local function INLINED_34() -- Internal function, doesn't exist in bytecode
							var94 = arg2.Dodges
							return var94
						end
						local function INLINED_35() -- Internal function, doesn't exist in bytecode
							var94 = arg2.Dodges[var95]
							return var94
						end
						if not nil or INLINED_31() and INLINED_32() or INLINED_33() or not INLINED_34() or not INLINED_35() then
							var94 = table.insert
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							var94({}, var95)
						end
					end
				end
			end
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
function module_4_upvr.CreateDamageDataFromSkillID(arg1, arg2, arg3, arg4) -- Line 420
	--[[ Upvalues[1]:
		[1]: CombatConfig_upvr (readonly)
	]]
	arg3.SkillID = arg2
	if arg3.LocalCharacter then
		arg3.WindowID = arg3.LocalCharacter.ServerModel.Name..'_'..arg2
	end
	local var96 = CombatConfig_upvr.SkillData[arg2]
	if var96 then
		if arg4 then
			if arg4.CharacterStates.SkillConfig and arg4.CharacterStates.SkillConfig[arg2] then
				var96 = arg4.CharacterStates.SkillConfig[arg2]
			end
		end
		var96.BaseDamage = var96.Damage
		arg3.CanParry = var96.CanParry
		arg3.Knockback = var96.Knockback
	end
	return arg3
end
module_4_upvr.LastPlayerHit = nil
module_4_upvr.LastHitPlayer = nil
local var97_upvw = 0
local lookAlong_upvr = CFrame.lookAlong
local EffectsController_upvr = require(Client.Controllers.EffectsController)
local Common_upvr = ReplicatedStorage_upvr.Assets.Animations.Humanoid.Common
local any_GetRemoteMethod_result1_upvr = NetworkController.GetRemoteMethod(NetworkController.GetNamespace("SkillService"), "ParryHitbox")
local CommonLib_upvr = require(ReplicatedStorage_upvr.Shared.Libraries.CommonLib)
local any_GetRemoteMethod_result1_upvr_2 = NetworkController.GetRemoteMethod(NetworkController.GetNamespace("CombatService"), "DamageCharacter")
function module_4_upvr.DamageCharacter(arg1, arg2, arg3) -- Line 446
	--[[ Upvalues[9]:
		[1]: lookAlong_upvr (readonly)
		[2]: EffectsController_upvr (readonly)
		[3]: Common_upvr (readonly)
		[4]: CharacterController_upvr (readonly)
		[5]: module_4_upvr (readonly)
		[6]: var97_upvw (read and write)
		[7]: any_GetRemoteMethod_result1_upvr (readonly)
		[8]: CommonLib_upvr (readonly)
		[9]: any_GetRemoteMethod_result1_upvr_2 (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var162
	if not arg2[1] then
	else
		var162 = arg3
		if var162 then
			var162 = arg3.LocalCharacter
		end
		if not var162 or var162.IsDestroyed then
		end
		local var163
		local function INLINED_37() -- Internal function, doesn't exist in bytecode
			var163 = nil.ServerModel:GetPivot()
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return var163
		end
		if var163 and (not nil or not INLINED_37()) then
			var163 = arg3.Origin
			local var164 = var163
		end
		if var164 then
		end
		for var171, var170 in arg2 do
			if var170 and not var170.IsDestroyed and not var170:IsDead() then
				var170.Springs.Position:addVelocity((var164 * lookAlong_upvr(Vector3.new(0, 0, 0), Vector3.new(-1, 0.5, -0.5))).LookVector * 1)
				if var170.CharacterStates.IsBlocking then
					EffectsController_upvr:DoEffect("HitBlock", var170)
				else
					var170.AnimationComponent:PlayAnimation(Common_upvr.Combat.Hit.Hit)
					EffectsController_upvr:DoEffect("HitBasic", var170)
					if arg3 and arg3.OnCharacterHit then
						arg3.OnCharacterHit(var170)
					end
					if CharacterController_upvr.LocalCharacter and var170.MovementComponent.ActiveComponent:Is("ChargedDashComponent") and var170 == CharacterController_upvr.LocalCharacter then
						var170.MovementComponent:GetComponent("ChargedDashComponent"):Stop()
					end
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
					if nil and nil.Player and var170.Player then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if CharacterController_upvr.LocalCharacter == nil then
							module_4_upvr.LastPlayerHit = var170
						elseif CharacterController_upvr.LocalCharacter == var170 then
							module_4_upvr.LastHitPlayer = var170
						end
						var97_upvw = os.clock()
					end
					if arg3 then
						if arg3.Knockback then
							local Direction = arg3.Knockback.Direction
							if not Direction then
								-- KONSTANTERROR: Expression was reused, decompilation is incorrect
								if nil then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									Direction = (nil.ServerModel.PrimaryPart.Position - var170.ServerModel.PrimaryPart.Position).Unit
								end
							end
							EffectsController_upvr:DoEffect("Knockback", var170, arg3.Knockback.Distance, arg3.Knockback.Duration, Direction)
						end
						if arg3.OnCharacterHit then
							arg3.OnCharacterHit(var170)
						end
						if arg3.CanParry then
							if not arg3.Parries then
								arg3.Parries = {}
							end
							local any_GetCharacterHitboxes_result1_2 = module_4_upvr:GetCharacterHitboxes(var170)
							if any_GetCharacterHitboxes_result1_2 then
								for _, v_9 in any_GetCharacterHitboxes_result1_2 do
									if v_9.HitboxOptions.LocalCharacter and v_9.HitboxOptions.IsParryable then
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										if v_9.HitboxOptions.ParryInterval > os.clock() - v_9.CreationTime then
											if arg3.Parries then
												table.insert(arg3.Parries, v_9.HitboxOptions.LocalCharacter.ServerModel)
											end
											-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
											if nil and var170.ServerModel.Parent ~= nil.ServerModel.Parent then
												any_GetRemoteMethod_result1_upvr:Call(v_9.ID)
											end
											v_9.Parried = arg3.LocalCharacter or true
											-- KONSTANTERROR: Expression was reused, decompilation is incorrect
											module_4_upvr.HitboxParried:Fire(v_9, v_9.HitboxOptions.LocalCharacter, nil)
										end
									end
								end
							end
						end
					end
					module_4_upvr.OnClientDamaged:Fire(var170)
				end
			end
		end
		if arg3 and arg3.LocalCharacter and arg3.CallServer ~= false then
			arg3.LocalCharacter = nil
			local any_CloneTable_result1 = CommonLib_upvr.CloneTable(arg3)
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			any_CloneTable_result1.LocalCharacter = nil.ServerModel
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg3.LocalCharacter = nil
			var171 = CharacterController_upvr
			if arg3.LocalCharacter == var171.LocalCharacter then
				var171 = nil
				var170 = nil
				for _, v_10 in arg2, var171, var170 do
					table.insert({}, v_10.ServerModel)
					local _
				end
				var170 = _
				function var170() -- Line 543
				end
				any_GetRemoteMethod_result1_upvr_2:Call(var170, true, any_CloneTable_result1):catch(var170)
				return
			end
			if CharacterController_upvr.LocalCharacter then
				var170 = CharacterController_upvr
				var171 = var170.LocalCharacter
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				var171 = nil.ServerModel
				if var171.ServerModel.Parent ~= var171.Parent then
					var170 = CharacterController_upvr
					var171 = var170.LocalCharacter
					if table.find(arg2, var171) then
						var171 = {}
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						var170 = nil.ServerModel
						var171[1] = var170
						var170 = false
						function var171() -- Line 546
						end
						any_GetRemoteMethod_result1_upvr_2:Call(var171, var170, any_CloneTable_result1):catch(var171)
					end
				end
			end
		end
	end
end
function module_4_upvr.GetCharactersThroughHitbox(arg1, arg2, arg3, arg4) -- Line 553
	--[[ Upvalues[2]:
		[1]: RunService_upvr (readonly)
		[2]: module_4_upvr (readonly)
	]]
	local module_6_upvr = {}
	local var174_upvw
	local tbl_7_upvr = {}
	var174_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 557
		--[[ Upvalues[7]:
			[1]: arg2 (readonly)
			[2]: var174_upvw (read and write)
			[3]: module_4_upvr (copied, readonly)
			[4]: tbl_7_upvr (readonly)
			[5]: module_6_upvr (readonly)
			[6]: arg3 (readonly)
			[7]: arg4 (readonly)
		]]
		if arg2.IsDestroyed then
			var174_upvw:Disconnect()
		else
			local any_GetCharactersInHitbox_result1_2 = module_4_upvr:GetCharactersInHitbox(arg2)
			for _, v_11 in any_GetCharactersInHitbox_result1_2 do
				if not tbl_7_upvr[v_11] then
					tbl_7_upvr[v_11] = true
					table.insert(module_6_upvr, v_11)
					if arg3 then
						arg3(v_11)
					end
				end
			end
			for i_12 in tbl_7_upvr do
				if not table.find(any_GetCharactersInHitbox_result1_2, i_12) then
					tbl_7_upvr[i_12] = nil
					local table_find_result1_2 = table.find(module_6_upvr, i_12)
					if table_find_result1_2 then
						table.remove(module_6_upvr, table_find_result1_2)
					end
					if arg4 then
						arg4(i_12)
					end
				end
			end
		end
	end)
	return module_6_upvr
end
function module_4_upvr.DamageCharactersThroughHitbox(arg1, arg2, arg3) -- Line 594
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	return module_4_upvr:GetCharactersThroughHitbox(arg2, function(arg1_3) -- Line 595
		--[[ Upvalues[2]:
			[1]: module_4_upvr (copied, readonly)
			[2]: arg3 (readonly)
		]]
		local tbl = {}
		tbl[1] = arg1_3
		module_4_upvr:DamageCharacter(tbl, arg3)
	end)
end
function module_4_upvr.DamageCharactersOvertimeThroughHitbox(arg1, arg2, arg3, arg4) -- Line 600
	--[[ Upvalues[2]:
		[1]: module_4_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	local tbl_6_upvr = {}
	local any_GetCharactersThroughHitbox_result1_upvr = module_4_upvr:GetCharactersThroughHitbox(arg2, nil, function(arg1_4) -- Line 604
		--[[ Upvalues[1]:
			[1]: tbl_6_upvr (readonly)
		]]
		tbl_6_upvr[arg1_4] = nil
	end)
	local var192_upvw
	local var193_upvw = arg3 or 1
	var192_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 609
		--[[ Upvalues[7]:
			[1]: arg2 (readonly)
			[2]: var192_upvw (read and write)
			[3]: any_GetCharactersThroughHitbox_result1_upvr (readonly)
			[4]: tbl_6_upvr (readonly)
			[5]: var193_upvw (read and write)
			[6]: module_4_upvr (copied, readonly)
			[7]: arg4 (readonly)
		]]
		if arg2.IsDestroyed then
			var192_upvw:Disconnect()
		else
			local os_clock_result1 = os.clock()
			for _, v_12 in any_GetCharactersThroughHitbox_result1_upvr do
				if not tbl_6_upvr[v_12] or var193_upvw <= os_clock_result1 - tbl_6_upvr[v_12] then
					tbl_6_upvr[v_12] = os_clock_result1
					module_4_upvr:DamageCharacter({v_12}, arg4)
				end
			end
		end
	end)
	return any_GetCharactersThroughHitbox_result1_upvr
end
local SettingsController_upvr = require(Client.Controllers.SettingsController)
local CameraController_upvr = require(Client.Controllers.CameraController)
local AIController_upvr = require(Client.Controllers.AIController)
function module_4_upvr.GetAutoTarget(arg1, arg2, arg3) -- Line 627
	--[[ Upvalues[7]:
		[1]: SettingsController_upvr (readonly)
		[2]: CharacterController_upvr (readonly)
		[3]: CameraController_upvr (readonly)
		[4]: module_4_upvr (readonly)
		[5]: var97_upvw (read and write)
		[6]: AIController_upvr (readonly)
		[7]: CombatConfig_upvr (readonly)
	]]
	local var209
	if SettingsController_upvr:GetSetting("AUTOTARGET") ~= 1 then
	else
		if not var209 then
			var209 = 10
		end
		local LocalCharacter = CharacterController_upvr.LocalCharacter
		if not LocalCharacter then return end
		if arg3 == false or LocalCharacter.CharacterStates.InCombat then
			if CameraController_upvr.LockOnTarget then
				return CameraController_upvr.LockOnTarget
			end
			local module_2 = {}
			if module_4_upvr.LastPlayerHit and not module_4_upvr.LastPlayerHit.CharacterStates.FriendlyFire or not LocalCharacter.CharacterStates.FriendlyFire then
				module_4_upvr.LastPlayerHit = nil
			elseif module_4_upvr.LastPlayerHit and os.clock() - var97_upvw <= 25 then
				table.insert(module_2, {module_4_upvr.LastPlayerHit, 99999})
			else
				module_4_upvr.LastPlayerHit = nil
			end
			for _, v_13 in CharacterController_upvr:GetCharacters() do
				if var209 > (v_13.ServerModel.PrimaryPart.Position - LocalCharacter.ServerModel.PrimaryPart.Position).Magnitude then
					local any_GetAIFromServerModel_result1 = AIController_upvr.GetAIFromServerModel(v_13.ServerModel)
					if any_GetAIFromServerModel_result1 then
						table.insert(module_2, {any_GetAIFromServerModel_result1.Character, CombatConfig_upvr.AutoTarget.GetScore(LocalCharacter, any_GetAIFromServerModel_result1, var209)})
					elseif v_13 ~= LocalCharacter and v_13 ~= module_4_upvr.LastPlayerHit and LocalCharacter.CharacterStates.FriendlyFire and v_13.CharacterStates.FriendlyFire then
						table.insert(module_2, {v_13, 9999})
					end
				end
			end
			for _, v_14 in table.clone(module_2) do
				local _, any_WorldToViewportPoint_result2 = CameraController_upvr.CurrentCamera:WorldToViewportPoint(v_14[1].ServerModel.PrimaryPart.Position)
				if not any_WorldToViewportPoint_result2 then
					table.remove(module_2, table.find(module_2, v_14))
				end
			end
			if #module_2 == 0 then return end
			table.sort(module_2, function(arg1_5, arg2_2) -- Line 670
				local var225
				if arg2_2[2] >= arg1_5[2] then
					var225 = false
				else
					var225 = true
				end
				return var225
			end)
			local _1 = module_2[1]
			if _1[2] == 0 then return end
			return _1[1], module_2
		end
	end
end
local zero_cframe_upvr = CFrame.new()
function module_4_upvr.Init(arg1) -- Line 685
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: tbl_3_upvr (readonly)
		[3]: zero_cframe_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep("HitboxUpdate", Enum.RenderPriority.Last.Value, function() -- Line 687
		--[[ Upvalues[2]:
			[1]: tbl_3_upvr (copied, readonly)
			[2]: zero_cframe_upvr (copied, readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [115] 76. Error Block 37 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [115] 76. Error Block 37 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [4] 5. Error Block 63 start (CF ANALYSIS FAILED)
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.6]
		local function INLINED_41() -- Internal function, doesn't exist in bytecode
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			return nil
		end
		if not nil or not INLINED_41() then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			if nil and nil then
			end
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.7]
			if nil then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if not nil then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if not nil then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
						if nil or nil or nil then
							-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.8]
							if not nil then
								-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.10]
								local function INLINED_42() -- Internal function, doesn't exist in bytecode
									-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.9]
									return nil
								end
								if not nil or not INLINED_42() then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
									if not nil or not nil then
									end
								end
							end
							-- KONSTANTWARNING: GOTO [115] #76
						end
						-- KONSTANTWARNING: GOTO [115] #76
					end
					-- KONSTANTWARNING: GOTO [53] #35
				end
			else
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
				if nil and not nil then
					for _, _ in nil do
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if nil then
							-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.12]
							if nil then
								-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.14]
								local function INLINED_43() -- Internal function, doesn't exist in bytecode
									-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [115.13]
									return nil
								end
								if not nil or not INLINED_43() then
								end
							end
						end
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
					end
				end
			end
		end
		-- KONSTANTERROR: [4] 5. Error Block 63 end (CF ANALYSIS FAILED)
	end)
end
return module_4_upvr
