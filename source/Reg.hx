package;

import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.util.FlxSave;
import flixel.util.loaders.TexturePackerData;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var levelHint:String;
	public static var levelNum:Int = 4;
	public static var MAX_LEVEL:Int = 7;
	
	
	public static var keepSprites:Array<Entity>;
	public static var kickSprites:Array<Entity>;
	public static var keepRatio:Float;
	
	public static var BLOCK_SIZE = 30;
	private static var tex:TexturePackerData;
	
	public static var kick:Bool = false;
	
	public static var mistakes:Int = 0;
	public static var score:Int = 0;
	public static var goal:Int = 10;
	
	public static var CAPTAIN_KICK = 5;
	public static var CAPTAIN_KEEP = 3;
	
	public static var lastKick:Int = 0;
	public static var lastKeep:Int = 0;

	public static var SOUND_KICK = 6;
	public static var SOUND_KEEP = 4;
	
	public static var lastSoundKick:Int = 0;
	public static var lastSoundKeep:Int = 0;
	
	public static function getPoint(p:Int):FlxPoint {
		if (p == 0)
		return FlxPoint.weak(400,220);
		
		if (p == 1)
		return FlxPoint.weak(400, 240);
		if (p == 2)
		return FlxPoint.weak(150, 220);
		if (p == 3)
		return FlxPoint.weak(50, 220);
		return null;
		
	}
	
	
	public static function getTex() {
		if (tex == null) {
		tex = new TexturePackerData("assets/images/atlas.json", "assets/images/atlas.png");
		}
		return tex;
	}
	
	/**
	 * Prep the level number according to the value in the variable levelNum.
	 */
	public static function prepLevel() {
		keepSprites = new Array<Entity>();
		kickSprites = new Array<Entity>();
		
		
		switch (levelNum) 
		{
			case 1 :
				var s = new Entity();
				loadStartingSprite("kick1.png", true);
				loadStartingSprite("keep1.png", false);
				levelHint = "Kick the hostanges, keep the pirates.";
				levelNum = 1;
				keepRatio = .2;
				mistakes = 0;
				score = 0;
				goal = 20;
				
			case 2 :
				var s = new Entity();
				loadStartingSprite("kick1.png", true);
				loadStartingSprite("kick2.png", true);
				loadStartingSprite("keep1.png", false);
		
				levelHint = "Some pirates and hostages are dressed similar.  Be careful!";
				levelNum = 2;
				keepRatio = .3;
				mistakes = 0;
				score = 0;
				goal = 15;
				
			case 3 :
				var s = new Entity();
				loadStartingSprite("kick3.png", true);
				loadStartingSprite("kick7.png", true);
				loadStartingSprite("keep2.png", false);
		
				levelHint = "Why did we let the hostages keep the staves?";
				levelNum = 3;
				keepRatio = .35;
				mistakes = 0;
				score = 0;
				goal = 20;
			case 4 :
				var s = new Entity();
				loadStartingSprite("kick1.png", true);
				loadStartingSprite("kick2.png", true);
				loadStartingSprite("kick3.png", true);
				loadStartingSprite("keep1.png", false);
				loadStartingSprite("keep2.png", false);
				loadStartingSprite("keep3.png", false);
		
				levelHint = "There are a lot of different pirates and hostanges now, aren't there?";
				levelNum = 4;
				keepRatio = .4;
				mistakes = 0;
				score = 0;
				goal = 25;
				

			case 5 :
				var s = new Entity();
				loadStartingSprite("kick2.png", true);
				loadStartingSprite("kick7.png", true);
				loadStartingSprite("keep4.png", false);
		
				levelHint = "Aren't the hostages normally in blue?";
				levelNum = 5;
				keepRatio = .35;
				mistakes = 0;
				score = 0;
				goal = 25;
			case 6 :
				loadStartingSprite("kick8.png", true);
				loadStartingSprite("keep1.png", false);
		
				levelHint = "They look pretty similar.";
				levelNum = 6;
				keepRatio = .35;
				mistakes = 0;
				score = 0;
				goal = 30;
			case 7 :
				loadStartingSprite("kick1.png", true);
				loadStartingSprite("kick2.png", true);
				loadStartingSprite("kick3.png", true);
				loadStartingSprite("kick4.png", true);
				loadStartingSprite("kick5.png", true);
				loadStartingSprite("kick6.png", true);
				loadStartingSprite("kick7.png", true);
				loadStartingSprite("kick8.png", true);
				loadStartingSprite("keep1.png", false);
				loadStartingSprite("keep2.png", false);
				loadStartingSprite("keep3.png", false);
				loadStartingSprite("keep4.png", false);
		
				levelHint = "Good luck!";
				levelNum = 7;
				keepRatio = .5;
				mistakes = 0;
				score = 0;
				goal = 40;
				
				
			default:
				//var s = new Entity();
				loadStartingSprite("CaptiveMale.png", true);
				loadStartingSprite("Crew.png", false);
				//s.loadGraphicFromTexture(Reg.getTex(), false, "CaptiveMale.png");
				//addToKick(s);
				//s = new Entity();
				//s.loadGraphicFromTexture(Reg.getTex(), false, "Crew.png");
				//addToKeep(s);
				levelHint = "My code is screwed up so you are getting this.  I mean... Congratulations!  You found the hidden level!";
				levelNum = -1;
				keepRatio = .1;
				mistakes = 0;
				score = 0;
				goal = 10;
		}
	}
	
	public static function addToKick(s:Entity) {
		kickSprites.push(s);
		
	}
	
	public static function addToKeep(s:Entity) {
		keepSprites.push(s);
		s.walkThePlank = false;
	}
	
	public static function getKeeper():FlxSprite {
		return keepSprites[FlxRandom.intRanged(0, keepSprites.length - 1)];
	}
	public static function getKicker():FlxSprite {
		return kickSprites[FlxRandom.intRanged(0, kickSprites.length - 1)];
	}
	
	/**
	 * Should this entity be a kicker?
	 * @return True if kicker.  False if keeper.
	 */
	public static function isKicker():Bool {
		if (FlxRandom.floatRanged(0, 1) >= keepRatio)
		return true;
		return false;
		
	}
	
	private static function loadStartingSprite(name:String, kick:Bool) {
		var s = new Entity();
		s.loadGraphicFromTexture(Reg.getTex(), true, name);
		if(kick)
		addToKick(s);
		else
		addToKeep(s);

	}
	
	public static function captainKick():String {
		lastKick = FlxRandom.intRanged(1, CAPTAIN_KICK, [lastKick]);
		return "kick" + lastKick;
	}
	public static function captainKeep():String {
		lastKeep = FlxRandom.intRanged(1, CAPTAIN_KEEP, [lastKeep]);
		return "keep" + lastKeep;
	}
	public static function soundKick():String {
		lastSoundKick = FlxRandom.intRanged(1, SOUND_KICK, [lastSoundKick]);
		return "assets/sounds/hit" + lastKick + ".wav";
	}
	public static function soundKeep():String {
		lastSoundKeep = FlxRandom.intRanged(1, SOUND_KEEP, [lastSoundKeep]);
		return "assets/sounds/hit" + lastSoundKeep + ".wav";
	}
	
}