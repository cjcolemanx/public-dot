local M = {}

local anime = require("ui.dashboard.ascii-art.anime").images
local characters = require("ui.dashboard.ascii-art.characters-and-other").images
local games = require("ui.dashboard.ascii-art.games").images
local logos = require("ui.dashboard.ascii-art.logos").images
local planets = require("ui.dashboard.ascii-art.planets").images
local objects = require("ui.dashboard.ascii-art.objects").images

-- NOTE: not using atm
-- local cats = require("ui.dashboard.ascii-art.cats").images
-- local dogs = require("ui.dashboard.ascii-art.dogs").images
-- local other_animals = require("ui.dashboard.ascii-art.other-animals").images

local image_list = {}
local logo_list = {}

local function ascii_table_builder(original_table, to_add)
	for _, value in ipairs(to_add) do
		table.insert(original_table, value)
	end
end

-- NOTE: change these to allow certain images
-- Add Images
ascii_table_builder(image_list, anime)
ascii_table_builder(image_list, games)
ascii_table_builder(image_list, planets)
ascii_table_builder(image_list, objects)
ascii_table_builder(image_list, characters)
-- ascii_table_builder(image_list, cats)
-- ascii_table_builder(image_list, dogs)
-- ascii_table_builder(image_list, other_animals)

-- Add Logos
ascii_table_builder(logo_list, logos)

M.text = {
	"LaSaGna",
	"Rice is Nice",
	"Buy a real sword",
	"Drain",
	"Present Day... Present Time!",
	'"What game is this?"',
	"You are entering the legandary Gamer Zone",
	"Kvlt Shvt",
	"Fast Beats to Fuck To",
	"Sonic Hedgehog",
	'"Master has given Dobby some wock"',
	"Get in the robot",
	"Gundam Mk-II",
	"ΖΖ Gundam",
	"Victory 2 Gundam",
	"God Gundam",
	"Wing Gundam Zero",
	"Gundam Double X",
	"Strike Gundam",
	"Impulse Gundam",
	"Welcome to the Playaz Circle",
	"Shrim",
	"Works Cited:",
	"Jungle Respect Zone",
	"I use Arch btw",
	"                                         ",
	"Let's Meet God",
}

local _z = require("ui.dashboard.ascii-art.pre-post-fixes")

M.fixes = _z.fixes
M.image_list = image_list
M.logo_list = logo_list

return M
