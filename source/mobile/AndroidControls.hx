package mobile;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;
import mobile.FlxVirtualPad;
import mobile.FlxHitbox;

class AndroidControls extends FlxSpriteGroup {
	public var mode:ControlsGroup = HITBOX;

	public var hbox:FlxHitbox;
	public var vpad:FlxVirtualPad;

	public function new() {
		super();

		mode = getModeFromNumber(0);

		switch (mode) {
			case HITBOX:
				initControler(0);
		}
	}

	function initControler(vpadMode:Int) {
		switch (vpadMode) {		
			default:
				hbox = new FlxHitbox();
				add(hbox);							
		}
	}

	public static function getModeFromNumber(modeNum:Int):ControlsGroup {
		return switch (modeNum) {
			default:	
				HITBOX;
		}
	}
}

enum ControlsGroup {
	HITBOX;
}
