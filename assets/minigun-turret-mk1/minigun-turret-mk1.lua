--------------
--- ENTITY ---
--------------
-- Deep copy base data and create new one with custom parametres
local l_minigun_turret_mk1 = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
l_minigun_turret_mk1.name = "minigun-turret-mk1"
-- Flags
l_minigun_turret_mk1.flags = 
{
	"player-creation",				-- Can draw enemies
	"placeable-off-grid", 
	"not-on-map",					-- Do not show on minimap
	"not-repairable", 
	"not-deconstructable", 
	"not-blueprintable"
}
l_minigun_turret_mk1.minable = nil
-- HP 
l_minigun_turret_mk1.max_health = 1000			-- Same as platform hp (Critical component or will be destroyed using old script)
-- Resistance copy
local l_base_wagon_copy_param = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"]["resistances"])			
l_minigun_turret_mk1.resistances = l_base_wagon_copy_param			-- Prevent faster damage from turret
-- Collision
l_minigun_turret_mk1.collision_box = {{-1, -1 }, {1, 1}}
l_minigun_turret_mk1.collision_mask = { "object-layer" }				-- Fix player stuck inside wagon forever
l_minigun_turret_mk1.selection_box = {{-1.25, -1.25 }, {1.25, 1.25}}
-- Rotation speed
local l_base_tank_copy_param = util.table.deepcopy(data.raw["car"]["tank"]["turret_rotation_speed"])	
l_minigun_turret_mk1.rotation_speed = l_base_tank_copy_param * 2	
-- Inventory	
l_minigun_turret_mk1.inventory_size = 3
-- Ammo count copy
local l_base_ammo_copy_param = util.table.deepcopy(data.raw["ammo"]["firearm-magazine"]["stack_size"])			
l_minigun_turret_mk1.automated_ammo_count = l_base_ammo_copy_param * 2			
-- Attack speed 
l_minigun_turret_mk1.attacking_speed = l_minigun_turret_mk1.attacking_speed

-- Animation functions
l_minigun_turret_mk1.gun_animation_render_layer = "higher-object-under"
local function minigun_turret_extension(inputs)
return
{
	filename = "__Armored-train-renai__/assets/minigun-turret-mk1/sprites/minigun-turret-raising.png",
	priority = "medium",
	width = 130,
	height = 126,
	direction_count = 4,
	frame_count = inputs.frame_count or 5,
	line_length = inputs.line_length or 0,
	run_mode = inputs.run_mode or "forward",
	shift = util.by_pixel(0, -40),						-- Sprite offset in world
	scale = 0.5,											-- Sprite scale
	axially_symmetrical = false
	-- hr version missingewde
}
end
function minigun_turret_attack(inputs)
return
{
	layers =
	{
		{
			width = 132,
			height = 130,
			frame_count = inputs.frame_count or 2,
			axially_symmetrical = false,
			direction_count = 64,
			shift = util.by_pixel(0, -40),
			scale = 0.5,
			stripes =
			{
				{
					filename = "__Armored-train-renai__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-1.png",
					width_in_frames = inputs.frame_count or 2,
					height_in_frames = 16
				},
				{
					filename = "__Armored-train-renai__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-2.png",
					width_in_frames = inputs.frame_count or 2,
					height_in_frames = 16
				},
				{
					filename = "__Armored-train-renai__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-3.png",
					width_in_frames = inputs.frame_count or 2,
					height_in_frames = 16
				},
				{
					filename = "__Armored-train-renai__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-4.png",
					width_in_frames = inputs.frame_count or 2,
					height_in_frames = 16
				}
			}
			-- hr version missing and mask and shadow
		}
	}
}
end
-- Animation calls
l_minigun_turret_mk1.folded_animation =
{
	layers =
	{
		minigun_turret_extension{frame_count=1, line_length = 1},
		--gun_turret_extension_mask{frame_count=1, line_length = 1},
		--gun_turret_extension_shadow{frame_count=1, line_length = 1}
	}
}
l_minigun_turret_mk1.preparing_animation =
{
	layers =
	{
		minigun_turret_extension{},
		--gun_turret_extension_mask{},
		--gun_turret_extension_shadow{}
	}
}
l_minigun_turret_mk1.prepared_animation = minigun_turret_attack{frame_count=1}
l_minigun_turret_mk1.attacking_animation = minigun_turret_attack{}
l_minigun_turret_mk1.folding_animation =
{
	layers =
	{
		minigun_turret_extension{run_mode = "backward"},
		--gun_turret_extension_mask{run_mode = "backward"},
		--gun_turret_extension_shadow{run_mode = "backward"}
	}
}
-- Base picture
local blank_layers = 
{
	layers = 
	{
		{
			filename = 	"__Armored-train-renai__/assets/minigun-turret-mk1/fakeTransparent.png",
			direction_count = 1,
			height = 16,
			width = 16
		}
	}
}
l_minigun_turret_mk1.base_picture = blank_layers

-- Attack parameters
local l_base_gun_copy = util.table.deepcopy(data.raw["gun"]["tank-machine-gun"])
l_minigun_turret_mk1.attack_parameters = l_base_gun_copy.attack_parameters
l_minigun_turret_mk1.attack_parameters.projectile_center = {-0.15625, -0.07812 * 7}			-- Overwrite parameter
-- Range

-- Write result
data:extend
({
	l_minigun_turret_mk1
})
