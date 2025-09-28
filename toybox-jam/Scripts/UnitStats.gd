extends Node
class_name Unit_Stats

##The name of the unit.
@export var Unit_Name : String

##Which side this Unit is on. 0 is for Ally, 1 is for Enemy.
@export var Unit_Side : int

##The damage type of the unit. Attack, Defense, Ranged, or Tower.
@export var Unit_Type : String

##How much the unit costs to summon
@export var Unit_Cost : int

##How much damage the unit deals on each attack.
@export var Unit_Strength : int
##How much incoming damage is reduced.
@export var Unit_Defense : int

##The maximum health the unit has.
@export var Unit_Max_Health : int
##The current health the unit has.
var Unit_Cur_Health : int

##How far away the unit can attack its target from.
@export var Unit_Range : float

##How often the unit attacks.
@export var Unit_Attack_Speed : float

##The speed at which this Unit will move at.
@export var Unit_Movement_Speed : float
