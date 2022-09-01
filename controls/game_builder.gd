class_name GameBuilder

func _init():
	pass

func create(difficult: int):
	var melee = AttackRange.new("melee", 1)
	var single = AttackArea.new("single", 1)
	var wide = AttackArea.new("wide", 3, true)
	var physical = AttackType.new("physical")
	
	var at_s_m_1 = Power.new(1, physical, melee, single)
	var at_s_m_2 = Power.new(2, physical, melee, single)
	var at_s_m_3 = Power.new(3, physical, melee, single)
	var at_s_m_4 = Power.new(1, physical, melee, wide)
	var at_s_m_5 = Power.new(2, physical, melee, wide)
	var at_s_m_6 = Power.new(3, physical, melee, wide)
	
	var dice = Dice.new([at_s_m_1, at_s_m_2, at_s_m_3, at_s_m_4, at_s_m_5, at_s_m_6])
	
	var eric = Player.new("Eric", 5, 0, dice)
	var marcela = Player.new("Snow", 6, 0, dice)
	var snow = Player.new("Marcela", 4, 0, dice)
	var rock = Player.new("Rock", 8, 0, dice)
	
	var e1 = Enemy.new("Goblin 1", 5, 0, dice)
	var e2 = Enemy.new("Goblin 2", 5, 0, dice)
	
	return GamePhase.new([eric, marcela, snow, rock], [e1, e2], difficult)
	
	
