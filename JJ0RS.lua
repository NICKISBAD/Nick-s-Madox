-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-01-31 10:11:03
-- Luau version 6, Types version 3
-- Time taken: 0.006269 seconds

local Theme = require(game:GetService("ReplicatedStorage").Assets.Interface.Theme)
local module_upvr = {
	SkillCancelCooldownPercent = 0.2;
	SkillCancelStunDuration = 1;
	BaseCERegenPercent = 0.05;
	MomentumCarriedOver = 0.3;
	MomentumDecay = 0.4;
	PvPDamageReduction = 0.01;
	Dash = {
		StaminaCost = 0.5;
		Cooldown = 0.3;
		DashForce = 55;
		DashDuration = 0.3;
		ConsecutiveDashTime = 1.35;
		ConsecutiveDashMultiplier = 1.1;
	};
	ChargedDash = {
		StaminaCost = 1;
		DashForce = 110;
		DashDuration = 0.4285714285714286;
	};
	Block = {
		Icon = "rbxassetid://117376457796578";
		IconMaxDistance = 100;
		RegenRate = 0.25;
		RegenTime = 2.5;
	};
	Parry = {
		ToughnessHealthPercent = 0.25;
	};
	DEFAULT_DODGE = {
		DodgeTime = 0.5;
		DodgeRadius = 20;
	};
	MaxLockOnDistance = 75;
	AutoTarget = require(script.AutoTarget);
	Toughness = require(script.Toughness);
	StatusEffects = require(script.StatusEffects);
	BasicSkills = {"Punch", "Block", "Dodge", "Plunge"};
	SkillData = {};
	ItemData = {};
	SkinData = {};
	DamageIndicator = {
		MaxDistance = 200;
		DefaultSize = 1.9;
		ThresholdSize = 2.5;
		ThresholdDamage = 100000;
		Duration = 0.65;
		DigitAppearSize = 2;
		DigitDisappearSize = 1.25;
		DigitSpeed = 0.15;
		DigitInterval = 0.05;
		Style = {
			Text = {
				TextColor3 = Color3.fromRGB(255, 42, 42);
				FontFace = Theme.Fonts.SemiBold;
			};
			Stroke = {
				Color = Color3.fromRGB(62, 0, 0);
				Thickness = 1;
				Transparency = 0.55;
			};
		};
		CritStyle = {
			Text = {
				TextColor3 = Color3.fromRGB(255, 79, 79);
				FontFace = Theme.Fonts.Bold;
			};
			Stroke = {
				Color = Color3.fromRGB(94, 0, 0);
				Thickness = 1;
				Transparency = 0.55;
			};
		};
		CritSize = 1.4;
	};
}
for _, v in script.Skills:GetChildren() do
	for i_2, v_2 in require(v) do
		if not v_2.Name then
			v_2.Name = i_2
		end
		module_upvr.SkillData[i_2] = v_2
		if v_2.DodgeTime == nil or v_2.DodgeRadius == nil then
			v_2.DodgeTime = module_upvr.DEFAULT_DODGE.DodgeTime
			v_2.DodgeRadius = module_upvr.DEFAULT_DODGE.DodgeRadius
		end
	end
end
local function GetitemData_upvr(arg1) -- Line 118, Named "GetitemData"
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: GetitemData_upvr (readonly)
	]]
	for _, v_3 in arg1:GetChildren() do
		if v_3:IsA("ModuleScript") then
			for i_4, v_4 in require(v_3) do
				if not v_4.Name then
					v_4.Name = i_4
				end
				module_upvr.ItemData[i_4] = v_4
			end
		else
			GetitemData_upvr(v_3)
		end
	end
end
GetitemData_upvr(script.Items)
local function GetSkinData_upvr(arg1) -- Line 132, Named "GetSkinData"
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: GetSkinData_upvr (readonly)
	]]
	for _, v_5 in arg1:GetChildren() do
		if v_5:IsA("ModuleScript") then
			local v_5_2 = require(v_5)
			for _, v_6 in v_5_2 do
				v_6.Skin = v_5.Name
			end
			module_upvr.SkinData[v_5.Parent.Name..'_'..v_5.Name] = v_5_2
		else
			GetSkinData_upvr(v_5)
		end
	end
end
GetSkinData_upvr(script.SkillSkins)
return module_upvr
