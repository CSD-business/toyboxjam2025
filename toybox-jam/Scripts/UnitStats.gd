extends Resource
class_name Unit_Stats

##The name of the unit.
@export var Unit_Name : String

##The damage type of the unit. Should be Attack, Defense, or Ranged.
@export var Unit_Type : String

##How much the unit costs to summon
@export var Unit_Cost : int

##How much damage the unit deals on each attack.
@export var Unit_Damage : int

##How much health the unit has.
@export var Unit_Max_Health : int

##How far away the unit can attack its target from.
@export var Unit_Range : float

##How often the unit attacks.
@export var Unit_Attack_Speed : float

##How quick the unit can locomote.
@export var Unit_Movement_Speed : float
