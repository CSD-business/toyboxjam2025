extends Node

var OnUI : bool
var MouseMgr : Node3D
var Pieces : Node
var Stamina : float = 0
var CurCost : int

var EnemyTowers : int
var FriendlyTowers : int

#stats for replayability 
var RoundPlaytime : float
var PlayerCasualties : int

#For menus and stuff
var GameIsGoing: bool = false

#can do levels or now
var CanDoLVL2: bool = false
var CanDoLVL3: bool = false
var CanDoLVL4: bool = false
var CanDoLVL5: bool = false
var Him: bool = false
