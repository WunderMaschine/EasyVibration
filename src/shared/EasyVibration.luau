local EasyVibration = {}
local Plrs = game:GetService("Players")
local HapticService = game:GetService("HapticService")
local UserInputService = game:GetService("UserInputService")
local GAMEPAD_TYPE = Enum.UserInputType.Gamepad1
local function UpdateGamepadAttributes(plr)
	local gpEnabled = UserInputService.GamepadEnabled
	plr:SetAttribute("GamepadEnabled", gpEnabled)
	if gpEnabled then
		local largeSupported = HapticService:IsMotorSupported(GAMEPAD_TYPE, Enum.VibrationMotor.Large)
		local smallSupported = HapticService:IsMotorSupported(GAMEPAD_TYPE, Enum.VibrationMotor.Small)
		plr:SetAttribute("LargeSupported", largeSupported)
		plr:SetAttribute("SmallSupported", smallSupported)
		plr:SetAttribute("VibrationEnabled", (largeSupported or smallSupported) == true)
	else
		plr:SetAttribute("LargeSupported", false)
		plr:SetAttribute("SmallSupported", false)
		plr:SetAttribute("VibrationEnabled", false)
	end
end
local function EnsureSettings()
	local plr = Plrs.LocalPlayer
	if plr:GetAttribute("GamepadEnabled") == nil then
		UpdateGamepadAttributes(plr)
	end
end
local function ApplyVibration(motorType, strength, duration, hold)
	HapticService:SetMotor(GAMEPAD_TYPE, motorType, strength)
	if not hold then
		task.wait(duration)
		HapticService:SetMotor(GAMEPAD_TYPE, motorType, 0)
	end
end
function EasyVibration.Vibrate(motor, strength, second, hold)
	local plr = Plrs.LocalPlayer
	EnsureSettings()
	if not plr:GetAttribute("GamepadEnabled") or not plr:GetAttribute("VibrationEnabled") then
		return
	end
	local newStrength = strength / 100
	local largeSupported = plr:GetAttribute("LargeSupported")
	local smallSupported = plr:GetAttribute("SmallSupported")
	if not (largeSupported or smallSupported) then
		return
	end
	local m = motor:lower()
	if m == "s" and smallSupported then
		ApplyVibration(Enum.VibrationMotor.Small, newStrength, second, hold)
	elseif m == "l" and largeSupported then
		ApplyVibration(Enum.VibrationMotor.Large, newStrength, second, hold)
	else
		if smallSupported then
			ApplyVibration(Enum.VibrationMotor.Small, newStrength, second, hold)
		elseif largeSupported then
			ApplyVibration(Enum.VibrationMotor.Large, newStrength, second, hold)
		end
	end
end
return EasyVibration