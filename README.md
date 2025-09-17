# siege-prep-3
The game I'm making for Hackclub's Siege - Prep Week 3 AND Godot Wild Jam #85

The idea is an autumn-themed game about producing a steady supply of candied apples to meet customer demand.

Additionally, I'll probably add a LOT to the composition framework I've been building on game by game...
Here's a list of things added for this game thus far;
- CP_Area -> Provides an Area2D for other nodes
	- All existing Area2D Components have become ACPs that work with this instead
- CP_AreaSub -> Superclass for AreaSubComponents(ACP). Provides paths from the AreaComponent's methods.
- ACP_Conveyor -> Moves bodies/areas in collision in a direction.
- ACP_Tooltip -> Shows a Control node at the mouse when the CP_Area is hovered over.
- CP_Holder -> Allows an Actor to hold another one.
- CP_Holdable -> Allows an Actor to be held by another.
- ACP_DragNDrop -> Allows a CP_Holdable to be activated by the mouse.
- ACP_ControlRotate -> Allows an Actor to be rotated when hovered over (configurable input names and degrees)
- MS_Friction -> Sets the actor's velocity to zero unless something is actively trying to move it
- Interface -> Actors but for Controls instead of Node2Ds
- Element -> Components but for Interfaces instead of Actors
- EM_Button -> Element that's literally just a button rn
- BEM_InvSlot -> A fully functional self-contained inventory slot element for actors
- CP_Slotable -> Provides an actor with an ID for inventory slots. Needed to put an actor in an inventory.
