local M = {}

M.bg = "#000000"
M.fg = "#ffffff"

---@param c  string
local function rgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, alpha, background)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = rgb(background)
	local fg = rgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.blend_bg(hex, amount, bg)
	return M.blend(hex, amount, bg or M.bg)
end
M.darken = M.blend_bg

function M.blend_fg(hex, amount, fg)
	return M.blend(hex, amount, fg or M.fg)
end
M.lighten = M.blend_fg

---@param color string|trop.Palette
function M.invert(color)
	if type(color) == "table" then
		for key, value in pairs(color) do
			color[key] = M.invert(value)
		end
	elseif type(color) == "string" then
		local hsluv = require("colorscheme.hsluv")
		if color ~= "NONE" then
			local hsl = hsluv.hex_to_hsluv(color)
			hsl[3] = 100 - hsl[3]
			if hsl[3] < 40 then
				hsl[3] = hsl[3] + (100 - hsl[3]) * M.day_brightness
			end
			return hsluv.hsluv_to_hex(hsl)
		end
	end
	return color
end

---@param color string  -- The hex color string to be adjusted
---@param lightness_amount number? -- The amount to increase lightness by (optional, default: 0.1)
---@param saturation_amount number? -- The amount to increase saturation by (optional, default: 0.15)
function M.brighten(color, lightness_amount, saturation_amount)
	lightness_amount = lightness_amount or 0.05
	saturation_amount = saturation_amount or 0.2
	local hsluv = require("colorscheme.hsluv")

	-- Convert the hex color to HSLuv
	local hsl = hsluv.hex_to_hsluv(color)

	-- Increase lightness slightly
	hsl[3] = math.min(hsl[3] + (lightness_amount * 100), 100)

	-- Increase saturation a bit more to make the color more vivid
	hsl[2] = math.min(hsl[2] + (saturation_amount * 100), 100)

	-- Convert the HSLuv back to hex and return
	return hsluv.hsluv_to_hex(hsl)
end

function M.round(x, p)
	local power = 10 ^ (p or 0)
	return (x * power + 0.5 - (x * power + 0.5) % 1) / power
end

function M.clamp(val, min, max)
	return math.min(math.max(val, min), max)
end

function M.contains(obj, value)
	for _, v in pairs(obj) do
		if v == value then
			return true
		end
	end

	return false
end

function M.deepcopy(orig, copies)
	copies = copies or {}
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		if copies[orig] then
			copy = copies[orig]
		else
			copy = {}
			copies[orig] = copy
			for orig_key, orig_value in next, orig, nil do
				copy[M.deepcopy(orig_key, copies)] = M.deepcopy(orig_value, copies)
			end
			setmetatable(copy, M.deepcopy(getmetatable(orig), copies))
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function M.template(tpl, sch)
	return (
		tpl:gsub("($%b{})", function(w)
			local k = w:sub(3, -2)
			if k == "theme" then
				return sch.theme or w
			end

			return sch.palette[w:sub(3, -2)] or w
		end)
	)
end

function M.remove_hashtag_from_schema(sch)
	local _sch = M.deepcopy(sch)
	local pal = _sch.palette
	for k, v in pairs(pal) do
		if type(v) == "string" then
			pal[k] = v:gsub("^#", "")
		end
	end
	return _sch
end

function M.cwd(file)
	local chr = os.tmpname():sub(1, 1)
	if chr == "/" then
		-- linux
		chr = "/[^/]*$"
	else
		-- windows
		chr = "\\[^\\]*$"
	end
	return arg[0]:sub(1, arg[0]:find(chr)) .. (file or "")
end

return M
