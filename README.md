****EasyVibration****

A simple module providing basic vibration feedback for connected gamepads. It does not include trigger haptics yet, because Roblox doesn't **actually** support it.

**What It Does:**

 * Checks if vibration is supported
 * Applies small or large motor vibration
 * Lets you set strength and duration
 * Provides a Stop(motor) function to manually end ongoing vibration


**Example Usage:**
```luau
local EasyVibration = require(game.ReplicatedStorage.EasyVibration)
EasyVibration.Vibrate("s", 100, 1, false)
```

**Stopping Vibrations:**
```luau
EasyVibration.Stop("s") -- Stops small motor vibration
EasyVibration.Stop("l") -- Stops large motor vibration
EasyVibration.Stop("")  -- Stops both if no motor specified
```

**Parameters:**

 * motor: “s” or “l” (for small and large)
 * strength: 0–100
 * duration: seconds
 * hold: true/false

[Roblox Model](https://create.roblox.com/store/asset/120955119967493/EasyVibration)
