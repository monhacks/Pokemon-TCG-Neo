AIActionTable_FirstStrike:
	dw .do_turn ; unused
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize

.do_turn
	call AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .store_list_pointers
	call SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.ko_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.take_prize
	call AIPickPrizeCards
	ret

.list_arena
	db HITMONTOP
	db MURKROW
	db HITMONLEE
	db HITMONCHAN
	db STANTLER
	db MILTANK
	db TEDDIURSA
	db $00

.list_bench
	db STANTLER
	db MILTANK
	db TEDDIURSA
	db HITMONTOP
	db MURKROW
	db HITMONLEE
	db HITMONCHAN
	db $00

.list_retreat
	ai_retreat HITMONTOP,  -1
	ai_retreat MILTANK, -1
	ai_retreat MURKROW,  -2
	db $00

.list_energy
	ai_energy HITMONLEE,     3, +1
	ai_energy HITMONCHAN,    3, +1
	ai_energy HITMONTOP,    3, +3
	ai_energy TEDDIURSA , 3, +0
	ai_energy URSARING,  4, +3
	ai_energy STANTLER,     3, +0
	ai_energy MILTANK,   3, +0
	ai_energy MURKROW,   2, +1
	db $00

.list_prize
	db DOUBLE_COLORLESS_ENERGY
	db HITMONTOP
	db $00

.store_list_pointers
	store_list_pointer wAICardListAvoidPrize, .list_prize
	store_list_pointer wAICardListArenaPriority, .list_arena
	store_list_pointer wAICardListBenchPriority, .list_bench
	store_list_pointer wAICardListPlayFromHandPriority, .list_bench
	; missing store_list_pointer wAICardListRetreatBonus, .list_retreat
	store_list_pointer wAICardListEnergyBonus, .list_energy
	ret
