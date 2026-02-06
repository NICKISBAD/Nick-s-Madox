-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-06 15:14:21
-- Luau version 6, Types version 3
-- Time taken: 0.047523 seconds

local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Client = game:GetService("Players").LocalPlayer.PlayerScripts.Client
local CharacterController_upvr = require(Client.Controllers.CharacterController)
local CameraController_upvr = require(Client.Controllers.CameraController)
local CombatController_upvr = require(Client.Controllers.CombatController)
local SkillController_upvr = require(Client.Controllers.SkillController)
local EffectsController_upvr = require(Client.Controllers.EffectsController)
local CombatConfig_upvr = require(ReplicatedStorage_upvr.Configs.CombatConfig)
local module_upvr = {}
local Plunge_upvr_2 = ReplicatedStorage_upvr.Assets.Animations.Humanoid.Common.Combat.Plunge
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
RaycastParams_new_result1_upvr.FilterDescendantsInstances = {workspace.Map.Geometry, workspace.Map.Props}
local CommonLib_upvr = require(ReplicatedStorage_upvr.Shared.Libraries.CommonLib)
local fusion_upvr = require(ReplicatedStorage_upvr.Packages.fusion)
function module_upvr.Block_Start(arg1) -- Line 30
	--[[ Upvalues[7]:
		[1]: CombatConfig_upvr (readonly)
		[2]: SkillController_upvr (readonly)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: CommonLib_upvr (readonly)
		[5]: fusion_upvr (readonly)
		[6]: RunService_upvr (readonly)
		[7]: CameraController_upvr (readonly)
	]]
	local var16
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var16 = arg1.CharacterStates.SkillConfig.Block
		return var16
	end
	if not arg1.CharacterStates.SkillConfig or not INLINED() then
		var16 = CombatConfig_upvr.SkillData.Block
	end
	SkillController_upvr:SetActiveSkill(arg1, "Block")
	SkillController_upvr:LockCharacterFromSkillData(arg1, var16)
	arg1.CharacterStates.IsBlocking = true
	arg1.AnimationComponent:PlayAnimation(ReplicatedStorage_upvr.Assets.Animations.Humanoid.Common.Combat.Block, {
		FadeTime = 0.05;
	}, {
		FadeTime = 0.05;
	})
	CommonLib_upvr.PlaySoundAt(ReplicatedStorage_upvr.Assets.Effects.Basic.Sounds.BlockCast, arg1.ServerModel.PrimaryPart)
	local any_Value_result1_upvr_2 = fusion_upvr.Value(1)
	local any_Value_result1_upvr_3 = fusion_upvr.Value(arg1.CharacterStates.BlockMaxHealth)
	local any_Value_result1_upvr = fusion_upvr.Value(arg1.CharacterStates.BlockHealth)
	local BillboardGui = Instance.new("BillboardGui")
	BillboardGui.AlwaysOnTop = true
	BillboardGui.MaxDistance = CombatConfig_upvr.Block.IconMaxDistance
	fusion_upvr.Hydrate(BillboardGui)({
		Size = fusion_upvr.Computed(function() -- Line 66
			--[[ Upvalues[1]:
				[1]: any_Value_result1_upvr_2 (readonly)
			]]
			local any_get_result1 = any_Value_result1_upvr_2:get()
			return UDim2.fromOffset(100 * any_get_result1, 100 * any_get_result1)
		end);
	})
	fusion_upvr.New("ImageLabel")({
		Size = UDim2.fromScale(1, 1);
		BackgroundTransparency = 1;
		Image = CombatConfig_upvr.Block.Icon;
		ImageTransparency = 0.6;
		Parent = BillboardGui;
	})
	local tbl_12 = {
		Size = UDim2.fromScale(1, 1);
		BackgroundTransparency = 1;
		Image = CombatConfig_upvr.Block.Icon;
		Parent = BillboardGui;
	}
	local tbl_6 = {
		Rotation = 90;
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0), NumberSequenceKeypoint.new(1, 0)});
	}
	local any_Spring_result1_upvr = fusion_upvr.Spring(fusion_upvr.Computed(function() -- Line 55
		--[[ Upvalues[2]:
			[1]: any_Value_result1_upvr (readonly)
			[2]: any_Value_result1_upvr_3 (readonly)
		]]
		return any_Value_result1_upvr:get() / any_Value_result1_upvr_3:get()
	end), 40, 1)
	tbl_6.Offset = fusion_upvr.Computed(function() -- Line 93
		--[[ Upvalues[1]:
			[1]: any_Spring_result1_upvr (readonly)
		]]
		return Vector2.new(0, 1 - any_Spring_result1_upvr:get())
	end)
	tbl_12[fusion_upvr.Children] = fusion_upvr.New("UIGradient")(tbl_6)
	fusion_upvr.New("ImageLabel")(tbl_12)
	BillboardGui.Name = "BlockIcon"
	BillboardGui.Parent = arg1.ServerModel.PrimaryPart
	local any_Connect_result1_upvr_2 = RunService_upvr.PreRender:Connect(function() -- Line 41
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_Value_result1_upvr_2 (readonly)
			[3]: CameraController_upvr (copied, readonly)
		]]
		if arg1.IsDestroyed then
		else
			any_Value_result1_upvr_2:set(15 / (arg1.ServerModel.PrimaryPart.Position - CameraController_upvr.CameraCFrame.Position).Magnitude)
		end
	end)
	local any_Connect_result1_upvr = arg1.CharacterStateChanged:Connect(function(arg1_2, arg2) -- Line 48
		--[[ Upvalues[3]:
			[1]: any_Value_result1_upvr_3 (readonly)
			[2]: arg1 (readonly)
			[3]: any_Value_result1_upvr (readonly)
		]]
		if arg1_2 == "BlockHealth" or arg1_2 == "BlockMaxHealth" then
			any_Value_result1_upvr_3:set(arg1.CharacterStates.BlockMaxHealth)
			any_Value_result1_upvr:set(arg1.CharacterStates.BlockHealth)
		end
	end)
	BillboardGui.Destroying:Connect(function() -- Line 102
		--[[ Upvalues[2]:
			[1]: any_Connect_result1_upvr_2 (readonly)
			[2]: any_Connect_result1_upvr (readonly)
		]]
		any_Connect_result1_upvr_2:Disconnect()
		any_Connect_result1_upvr:Disconnect()
	end)
end
function module_upvr.Block_Start_Check(arg1, ...) -- Line 108
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: CombatController_upvr (readonly)
	]]
	task.defer(module_upvr.Block_Start, arg1, ...)
	CombatController_upvr:PreCooldown(arg1, "Block")
	return true
end
function module_upvr.Block_Stop(arg1) -- Line 114
	--[[ Upvalues[5]:
		[1]: CombatConfig_upvr (readonly)
		[2]: SkillController_upvr (readonly)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: CharacterController_upvr (readonly)
		[5]: CombatController_upvr (readonly)
	]]
	local var38
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var38 = arg1.CharacterStates.SkillConfig.Block
		return var38
	end
	if not arg1.CharacterStates.SkillConfig or not INLINED_2() then
		var38 = CombatConfig_upvr.SkillData.Block
	end
	SkillController_upvr:RemoveActiveSkill(arg1, "Block")
	SkillController_upvr:UnlockCharacterFromSkillData(arg1, var38)
	arg1.CharacterStates.IsBlocking = false
	arg1.AnimationComponent:StopAnimation(ReplicatedStorage_upvr.Assets.Animations.Humanoid.Common.Combat.Block)
	if arg1 == CharacterController_upvr.LocalCharacter then
		CombatController_upvr:ContinueCooldown(arg1, "Block")
	end
	local BlockIcon_2 = arg1.ServerModel.PrimaryPart:FindFirstChild("BlockIcon")
	if BlockIcon_2 then
		BlockIcon_2:Destroy()
	end
	return true
end
function module_upvr.Block_Cancel(arg1) -- Line 133
	--[[ Upvalues[4]:
		[1]: CombatConfig_upvr (readonly)
		[2]: SkillController_upvr (readonly)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: EffectsController_upvr (readonly)
	]]
	local var40
	local function INLINED_3() -- Internal function, doesn't exist in bytecode
		var40 = arg1.CharacterStates.SkillConfig.Block
		return var40
	end
	if not arg1.CharacterStates.SkillConfig or not INLINED_3() then
		var40 = CombatConfig_upvr.SkillData.Block
	end
	SkillController_upvr:UnlockCharacterFromSkillData(arg1, var40)
	arg1.CharacterStates.IsBlocking = false
	arg1.AnimationComponent:StopAnimation(ReplicatedStorage_upvr.Assets.Animations.Humanoid.Common.Combat.Block)
	EffectsController_upvr:DoEffect("BlockBreak", arg1)
	local BlockIcon = arg1.ServerModel.PrimaryPart:FindFirstChild("BlockIcon")
	if BlockIcon then
		BlockIcon:Destroy()
	end
end
function module_upvr.Punch_Start(arg1, arg2, arg3, arg4) -- Line 144
	--[[ Upvalues[5]:
		[1]: SkillController_upvr (readonly)
		[2]: CombatConfig_upvr (readonly)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: CombatController_upvr (readonly)
		[5]: EffectsController_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_SetActiveSkill_result1_3 = SkillController_upvr:SetActiveSkill(arg1, "Punch")
	local var97
	if arg1.CharacterStates.SkillConfig and arg1.CharacterStates.SkillConfig.Punch then
		var97 = arg1.CharacterStates.SkillConfig.Punch
	end
	local var98 = var97.AutoTargetMaxDistance / 2
	local var99 = arg2 * Vector3.new(1, 0, 1)
	local Unit_2 = var99.Unit
	if arg3 ~= 5 then
		local _ = false
		-- KONSTANTWARNING: Skipped task `defvar` above
	else
	end
	if true then
	else
	end
	local var102 = 0.22 / arg4
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if true then
		local _ = 0.3
	else
	end
	arg1.MovementComponent:LockMovement()
	arg1.CharacterStates.PunchLevel = arg3 + 1
	arg1.CharacterStates.LastPunchTime = os.clock()
	local CharacterStates_2 = arg1.CharacterStates
	CharacterStates_2.IsAttacking += 1
	if arg1.Inventory then
		if arg1.Inventory.FocusedItem then
			local any_GetItem_result1 = arg1.Inventory:GetItem(arg1.Inventory.FocusedItem)
			local var106
		end
	end
	if any_GetItem_result1 and var97.HitboxConfig[any_GetItem_result1.ConfigID] then
		var106 = var97.HitboxConfig[any_GetItem_result1.ConfigID]
	end
	local clone_3 = ReplicatedStorage_upvr.Assets.Models.Hitboxes.Cube:Clone()
	clone_3.Size = var106.Size
	clone_3.CFrame = arg1.ServerModel.PrimaryPart.CFrame * var106.Offset
	local tbl_10 = {
		ID = arg1.ServerModel.Name.."_Punch";
	}
	tbl_10.LocalCharacter = arg1
	tbl_10.HitTime = var102
	tbl_10.IsParryable = var97.ParryableLevels[arg3]
	local any_CreateHitbox_result1_2 = CombatController_upvr:CreateHitbox(clone_3, tbl_10)
	any_CreateHitbox_result1_2.Offset = var106.Offset
	any_SetActiveSkill_result1_3.Hitbox = any_CreateHitbox_result1_2
	EffectsController_upvr:DoEffect("PunchStart", arg1, arg3, arg4)
	task.wait(var102)
	if any_SetActiveSkill_result1_3.Cancelled then
	else
		local cframe_looking_along_2 = CFrame.lookAlong(arg1.ServerModel.PrimaryPart.Position, Unit_2)
		local any_GetCharactersInHitbox_result1_2 = CombatController_upvr:GetCharactersInHitbox(any_CreateHitbox_result1_2)
		local tbl_11 = {}
		tbl_11.LocalCharacter = arg1
		tbl_11.Origin = cframe_looking_along_2
		function tbl_11.OnCharacterHit(arg1_4) -- Line 191
			--[[ Upvalues[3]:
				[1]: EffectsController_upvr (copied, readonly)
				[2]: arg3 (readonly)
				[3]: arg1 (readonly)
			]]
			EffectsController_upvr:DoEffect("Punch_Hit", arg1_4, arg3, arg1)
		end
		CombatController_upvr:DamageCharacter(any_GetCharactersInHitbox_result1_2, CombatController_upvr:CreateDamageDataFromSkillID("Punch", tbl_11))
		CombatController_upvr:DestroyHitbox(any_CreateHitbox_result1_2)
		arg1.MovementComponent:SetFacingDirection(Unit_2, true)
		any_SetActiveSkill_result1_3.HitCharacters = any_GetCharactersInHitbox_result1_2
		any_SetActiveSkill_result1_3.Hitbox = nil
		local PunchMoveStuds = var97.PunchMoveStuds
		if 1 < var99.Magnitude then
			PunchMoveStuds = var99.Magnitude
			if var98 < PunchMoveStuds then
				PunchMoveStuds = var98
			end
		end
		local DashVelocity_3 = arg1.PhysicsConstraints.DashVelocity
		DashVelocity_3.Enabled = true
		DashVelocity_3.VectorVelocity = (Unit_2) * (PunchMoveStuds / 0.15)
		for _, v_3 in any_GetCharactersInHitbox_result1_2 do
			v_3.MovementComponent:LockMovement()
			if not v_3.CharacterStates.IsDowned and v_3.CharacterStates.CanBeKnockbacked then
				v_3.MovementComponent:SetFacingDirection(-Unit_2, true)
				local var115 = var97.PunchMoveStuds * 1.1
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if true then
					var115 = var97.HeavyKnockback - (v_3.ServerModel.PrimaryPart.Position - cframe_looking_along_2.Position).Magnitude
				end
				local DashVelocity_2 = v_3.PhysicsConstraints.DashVelocity
				DashVelocity_2.VectorVelocity = Unit_2 * var115
				DashVelocity_2.Enabled = true
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				DashVelocity_2.VectorVelocity = (Unit_2) * (var115 / 0.15)
			end
		end
		EffectsController_upvr:DoEffect("Punch", arg1, arg3, arg4)
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		task.wait(0.15)
		SkillController_upvr:RemoveActiveSkill(arg1, "Punch")
		local CharacterStates_4 = arg1.CharacterStates
		CharacterStates_4.IsAttacking -= 1
		DashVelocity_3.Enabled = false
		arg1.MovementComponent:SetFacingDirection(nil, true)
		arg1.MovementComponent:UnlockMovement()
 s	 	for _, v_4 in any_GetCharactersInHitbox_result1_2 do
			v_4.PhyicsConstraints.DashVelocity.Enabled = false
			v_4.MovementComponent:SetFacingDirection(nil, true)
			v_4.MovementComponent:UnlockMovement()
		end
	end
end
function module_upvr.Punch_Cancel(arg1) -- Line 253
	--[[ Upvalues[3]:
		[1]: SkillController_upvr (readonly)
		[2]: EffectsController_upvr (readonly)
		[3]: CombatController_upvr (readonly)
	]]
	local any_GetActiveSkill_result1_2 = SkillController_upvr:GetActiveSkill(arg1, "Punch")
	if any_GetActiveSkill_result1_2 then
		EffectsController_upvr:DoEffect("Punch_Cancel", arg1)
		if any_GetActiveSkill_result1_2.Hitbox then
			CombatController_upvr:DestroyHitbox(any_GetActiveSkill_result1_2.Hitbox)
		end
		local CharacterStates_5 = arg1.CharacterStates
		CharacterStates_5.IsAttacking -= 1
		arg1.PhysicsConstraints.DashVelocity.Enabled = false
		arg1.MovementComponent:SetFacingDirection(nil, true)
		arg1.MovementComponent:UnlockMovement()
		if any_GetActiveSkill_result1_2.HitCharacters then
			for _, v in any_GetActiveSkill_result1_2.HitCharacters do
				v.PhysicsConstraints.DashVelocity.Enabled = false
				v.MovementComponent:SetFacingDirection(nil, true)
				v.MovementComponent:UnlockMovement()
			end
		end
	end
end
function module_upvr.Punch_Start_Check(arg1, arg2, arg3) -- Line 277
	--[[ Upvalues[3]:
		[1]: CombatConfig_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: CombatController_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 41 start (CF ANALYSIS FAILED)
	local var122 = arg3
	if not var122 then
		var122 = arg1.CharacterStates.PunchLevel
	end
	if arg1.Player then
		local _ = 1
	else
	end
	if var122 ~= 5 then
		local _ = false
		-- KONSTANTWARNING: Skipped task `defvar` above
	else
	end
	-- KONSTANTERROR: [0] 1. Error Block 41 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [20] 16. Error Block 11 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [20] 16. Error Block 11 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [28] 21. Error Block 43 start (CF ANALYSIS FAILED)
	local var125
	if 5 < var125 then
		-- KONSTANTERROR: [31] 23. Error Block 14 start (CF ANALYSIS FAILED)
		var125 = 1
		-- KONSTANTERROR: [31] 23. Error Block 14 end (CF ANALYSIS FAILED)
	end
	if arg1.CharacterStates.SkillConfig and arg1.CharacterStates.SkillConfig.Punch then
	end
	task.defer(module_upvr.Punch_Start, arg1, arg2, var125, 0.5)
	if true then
		CombatController_upvr:PreCooldown(arg1, "Punch", arg1.CharacterStates.SkillConfig.Punch.EndCooldown)
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if true then
	else
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if true then
	else
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	local var127_upvr = true
	task.delay(0.22 + 0.15 / 0.5, function() -- Line 295
		--[[ Upvalues[3]:
			[1]: var127_upvr (readonly)
			[2]: CombatController_upvr (copied, readonly)
			[3]: arg1 (readonly)
		]]
		if var127_upvr then
			CombatController_upvr:ContinueCooldown(arg1, "Punch")
		end
	end)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	do
		return true, var125, 0.5
	end
	-- KONSTANTERROR: [28] 21. Error Block 43 end (CF ANALYSIS FAILED)
end
function module_upvr.Dodge_Start(arg1, arg2, arg3) -- Line 302
	--[[ Upvalues[3]:
		[1]: CombatController_upvr (readonly)
		[2]: SkillController_upvr (readonly)
		[3]: EffectsController_upvr (readonly)
	]]
	local any_GetHitbox_result1_2 = CombatController_upvr:GetHitbox(arg3)
	if any_GetHitbox_result1_2 then
		SkillController_upvr:SetActiveSkill(arg1, "Dodge")
		task.defer(EffectsController_upvr.DoEffect, EffectsController_upvr, "Dodge_Start", arg1, any_GetHitbox_result1_2)
		SkillController_upvr:RemoveActiveSkill(arg1, "Dodge")
	end
end
function module_upvr.Dodge_Start_Check(arg1, arg2, arg3) -- Line 312
	--[[ Upvalues[3]:
 r	 	[1]: CombatController_upvr (readonly)
		[2]: module_upv (readonly)
		[3]: CombatConfig_upvr (readonly)
	]]
	local any_GetHitbox_result1 = CombatController_upvr:GetHitbox(arg3)
	if any_GetHitbox_result1 then
		local var130 = any_GetHitbox_result1.HitboxOpti
			v_4.MovementComponent:UnlockMovement()
		end
	end
end
function module_upvr.Punch_Cancel(arg1) -- Line 253
	--[[ Upvalues[3]:
		[1]: SkillController_upvr (readonly)
		[2]: EffectsController_upvr (readonly)
		[3]: CombatController_upvr (readonly)
	]]
	local any_GetActiveSkill_result1_2 = SkillController_upvr:GetActiveSkill(arg1, "Punch")
	if any_GetActiveSkill_result1_2 then
		EffectsController_upvr:DoEffect("Punch_Cancel", arg1)
		if any_GetActiveSkill_result1_2.Hitbox then
			CombatController_upvr:DestroyHitbox(any_GetActiveSkill_result1_2.Hitbox)
		end
		local CharacterStates_5 = arg1.CharacterStates
		CharacterStates_5.IsAttacking -= 1
		arg1.PhysicsConstraints.DashVelocity.Enabled = false
		arg1.MovementComponent:SetFacingDirection(nil, true)
		arg1.MovementComponent:UnlockMovement()
		if any_GetActiveSkill_result1_2.HitCharacters then
			for _, v in any_GetActiveSkill_result1_2.HitCharacters do
				v.PhysicsConstraints.DashVelocity.Enabled = false
				v.MovementComponent:SetFacingDirection(nil, true)
				v.MovementComponent:UnlockMovement()
			end
		end
	end
end
function module_upvr.Punch_Start_Check(arg1, arg2, arg3) -- Line 277
	--[[ Upvalues[3]:
		[1]: CombatConfig_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: CombatController_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 41 start (CF ANALYSIS FAILED)
	local var122 = arg3
	if not var122 then
		var122 = arg1.CharacterStates.PunchLevel
	end
	if arg1.Player then
		local _ = 1
	else
	end
	if var122 ~= 5 then
		local _ = false
		-- KONSTANTWARNING: Skipped task `defvar` above
	else
	end
	-- KONSTANTERROR: [0] 1. Error Block 41 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [20] 16. Error Block 11 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [20] 16. Error Block 11 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [28] 21. Error Block 43 start (CF ANALYSIS FAILED)
	local var125
	if 5 < var125 then
		-- KONSTANTERROR: [31] 23. Error Block 14 start (CF ANALYSIS FAILED)
		var125 = 1
		-- KONSTANTERROR: [31] 23. Error Block 14 end (CF ANALYSIS FAILED)
	end
	if arg1.CharacterStates.SkillConfig and arg1.CharacterStates.SkillConfig.Punch then
	end
	task.defer(module_upvr.Punch_Start, arg1, arg2, var125, 0.5)
	if true then
		CombatController_upvr:PreCooldown(arg1, "Punch", arg1.CharacterStates.SkillConfig.Punch.EndCooldown)
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if true then
	else
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if true then
	else
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	local var127_upvr = true
	task.delay(0.22 + 0.15 / 0.5, function() -- Line 295
		--[[ Upvalues[3]:
			[1]: var127_upvr (readonly)
			[2]: CombatController_upvr (copied, readonly)
			[3]: arg1 (readonly)
		]]
		if var127_upvr then
			CombatController_upvr:ContinueCooldown(arg1, "Punch")
		end
	end)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	do
		return true, var125, 0.5
	end
	-- KONSTANTERROR: [28] 21. Error Block 43 end (CF ANALYSIS FAILED)
end
function module_upvr.Dodge_Start(arg1, arg2, arg3) -- Line 302
	--[[ Upvalues[3]:
		[1]: CombatController_upvr (readonly)
		[2]: SkillController_upvr (readonly)
		[3]: EffectsController_upvr (readonly)
	]]
