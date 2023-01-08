local M = {}

local images = {}
M.saturn_01 = {
	"                                                ",
	"                                          _.oo. ",
	"                  _.u[[/;:,.         .odMMMMMM' ",
	"               .o888UU[[[/;:-.  .o@P^    MMM^   ",
	"              oN88888UU[[[/;::-.        dP^     ",
	"             dNMMNN888UU[[[/;:--.   .o@P^       ",
	"            ,MMMMMMN888UU[[/;::-. o@^           ",
	"            NNMMMNN888UU[[[/~.o@P^              ",
	"            888888888UU[[[/o@^-..               ",
	"           oI8888UU[[[/o@P^:--..                ",
	"        .@^  YUU[[[/o@^;::---..                 ",
	"      oMP     ^/o@P^;:::---..                   ",
	"   .dMMM    .o@^ ^;::---...                     ",
	"  dMMMMMMM@^`       `^^^^                       ",
	" YMMMUP^                                        ",
	"  ^^                                            ",
	"                                                ",
}

M.saturn_02 = {
	"                                                   ",
	"                                              ___  ",
	"                                           ,o88888 ",
	"                                        ,o8888888' ",
	"                  ,:o:o:oooo.        ,8O88Pd8888'  ",
	"              ,.::.::o:ooooOoOoO. ,oO8O8Pd888''    ",
	"            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O'      ",
	"           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8'        ",
	"          , ..:.::o:ooOoOO8O888O8O,COCOO'          ",
	"         , . ..:.::o:ooOoOOOO8OOOOCOCO'            ",
	"          . ..:.::o:ooOoOoOO8O8OCCCC'o             ",
	"             . ..:.::o:ooooOoCoCCC'o:o             ",
	"             . ..:.::o:o:,cooooCo'oo:o:            ",
	"          `   . . ..:.:cocoooo''o:o:::'            ",
	"          .`   . ..::ccccoc''o:o:o:::'             ",
	"         :.:.    ,c:cccc'':.:.:.:.:.'              ",
	"       ..:.:''`::::c:''..:.:.:.:.:.'               ",
	"     ...:.'.:.::::''    . . . . .'                 ",
	"    .. . ....:.'' `   .  . . ''                    ",
	"  . . . ....''                                     ",
	"  .. . .''                                         ",
	" .                                                 ",
	"                                                   ",
}

M.earth_01 = {
	"                                ",
	"             ,,,,,,             ",
	"         o#'9MMHb':'-,o,        ",
	"      .oH':HH$' '' ' -*R&o,     ",
	"     dMMM*'''`'      .oM'HM?.   ",
	"   ,MMM'          'HLbd< ?&H    ",
	"  .:MH .'          ` MM  MM&b   ",
	" . '*H    -        &MMMMMMMMMH: ",
	" .    dboo        MMMMMMMMMMMM. ",
	" .   dMMMMMMb      *MMMMMMMMMP. ",
	" .    MMMMMMMP        *MMMMMP . ",
	"      `#MMMMM           MM6P ,  ",
	"  '    `MMMP'           HM*`,   ",
	"   '    :MM             .- ,    ",
	"    '.   `#?..  .       ..'     ",
	"       -.   .         .-        ",
	"         ''-.oo,oo.-''          ",
	"                                ",
}

-------------------------
-- => Add
-------------------------
table.insert(images, M.saturn_01)
table.insert(images, M.saturn_02)
table.insert(images, M.earth_01)

M.images = images

return M
