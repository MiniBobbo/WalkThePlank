package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import inputhelper.InputHelper;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var captain:FlxSprite;
	var bg:FlxSprite;
	var ship:FlxSprite;
	
	var lineup:Array<Entity>;
	
	var kickSprites:FlxTypedGroup<Entity>;
	
	var lineupCount:Int = 100;
	
	var gameState:GameState = GameState.MENU;
	
	var timer:Float = 9.9;
	var timerText:FlxText;
	
	var scoreText:FlxText;
	
	var mute:FlxButton;
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		lineup = new Array<Entity>();
	
		kickSprites = new FlxTypedGroup<Entity>();
		for (i in 0...50) {
			var s = new Entity();
			s.kill();
			kickSprites.add(s);
			add(s);
		}
		
		bg = new FlxSprite();
		bg.loadGraphicFromTexture(Reg.getTex(), false, "bg.png");
		
		ship = new FlxSprite();
		ship.loadGraphicFromTexture(Reg.getTex(), false, "ship.png");
		
		captain = new FlxSprite(300, 240);
		captain.loadGraphicFromTexture(Reg.getTex(), false, "captain.png");
		captain.animation.addByNames("stand", ["captain.png"]); 
		captain.animation.addByNames("keep1", ["captainkeep1.png"]); 
		captain.animation.addByNames("keep2", ["captainkeep2.png"]); 
		captain.animation.addByNames("keep3", ["captainkeep3.png"]); 
		captain.animation.addByNames("kick1", ["captainkick1.png"]); 
		captain.animation.addByNames("kick2", ["captainkick2.png"]); 
		captain.animation.addByNames("kick3", ["captainkick3.png"]); 
		captain.animation.addByNames("kick4", ["captainkick4.png"]); 
		captain.animation.addByNames("kick5", ["captainkick5.png"]); 
		captain.animation.play("stand");
		
		add(bg);
		add(ship);
		
		add(captain);
		add(kickSprites);
		
		timerText = new FlxText(380, 10, 0, Math.floor(timer) + "", 80);
		add(timerText);
		
		scoreText = new FlxText(0, 0, 0, "Score: " + Reg.score + "\nMistake: " + Reg.mistakes + "\nGoal: " + Reg.goal, 40 );
		add(scoreText);
		
		mute = new FlxButton(700, 500, "Mute", toggleMusic);
		add(mute);
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (gameState == GameState.PLAY) {
			changeMusic();
			timer -= FlxG.elapsed;
			if (timer < 0 || Reg.mistakes >= 3) {
				timer = 0;
				for (e in kickSprites)
				e.kill();
				gameState = GameState.RESULTS;
			} else
				timerText.text =  Math.ceil(timer) + "";
			InputHelper.updateKeys();
			if (InputHelper.isButtonJustPressed("kick")) {
				//Kick the sprite.
				captain.animation.play(Reg.captainKick());
				FlxG.sound.play(Reg.soundKick());
				var s = kickSprites.getFirstAvailable();
				if(s != null) {
				s.makeKickSprite(lineup[0]);
				s.kicked = true;
				s.elapsed = 0;
				s.angle = 0;
				if (lineup[0].walkThePlank)
				Reg.score++;
				else
				Reg.mistakes++;
				advanceLintup();
				}
			
			} else if ( InputHelper.isButtonJustPressed("keep")) {
				captain.animation.play(Reg.captainKeep());
				FlxG.sound.play(Reg.soundKeep());
				var s = kickSprites.getFirstAvailable();
				if(s != null) {
				s.makeKickSprite(lineup[0]);
				s.kicked = true;
				s.elapsed = 0;
				s.angle = 0;
				s.velocity.x *= -2;
				if (!lineup[0].walkThePlank)
				Reg.score++;
				else
				Reg.mistakes++;
				advanceLintup();
				}
			}
			updateScores();
		} else if (gameState == GameState.START) {
			setLevel();
		} else if (gameState == GameState.RESULTS) {
			gameState = GameState.START;
			var rs = new ResultState();
			openSubState(rs);
		} else if (gameState == GameState.MENU) {
			gameState = GameState.START;
			var ms = new MainMenuState();
			openSubState(ms);
		}
		
	}	
	
	
	public function fillLineup() {
		var e:Entity;
		for (i in 0...4) {
			e = new Entity();	
			lineup.push(e);
			if (Reg.isKicker()) {
				e.buildSprite(true, Reg.getKicker() );
			} else {
				e.buildSprite(false, Reg.getKeeper());
			}			
		add(e);
		}
		
		for (i in 0...lineup.length) {
			lineup[i].advance(Reg.getPoint(i + 1));
		}
		
	}
	
	public function emptyLineup() {
		for (i in 0...lineup.length) {
			var e = lineup.shift();
			e.kill();
			e = null;
		}
		
	}
	
	public function refillLineup() {
		for (i in 0...4)
		advanceLintup();
	}
	public function advanceLintup() {
		var e = lineup.shift();
		var k = Reg.isKicker();
		if (k)
		e.buildSprite(k, Reg.getKicker());
		else
		e.buildSprite(k, Reg.getKeeper());
		lineup.push(e);
		for (i in 0...lineup.length) {
			lineup[i].advance(Reg.getPoint(i + 1));
		}
	}
	
	private function setLevel() {
		Reg.prepLevel();
		changeMusic(false);
		gameState = GameState.PLAY;
		captain.animation.play("stand");
		emptyLineup();
		fillLineup();
		timer = 9.99;
		
		var subState:StartState = new StartState();
		this.openSubState(subState);
		
	}
	
	public function updateScores() {
		scoreText.text = "Score: " + Reg.score + "\nMistakes: " + Reg.mistakes+ "\nGoal: " + Reg.goal;
	}
	
	var fast:Bool = false;
	
	public function changeMusic(makeFast:Bool = true ) {
		if (makeFast && !fast) {
			FlxG.sound.playMusic("assets/music/mainThemeFast.wav");
			fast = true;
		}
		if (makeFast == false) {
			fast = false;
			FlxG.sound.playMusic("assets/music/mainTheme.wav");
		}
		
		
	}
	
	var muteMusic:Bool = false;
	public function toggleMusic() {
		if (!muteMusic) {
			muteMusic = true;
			FlxG.sound.volume = 0;
		} else {
			muteMusic = false;
			FlxG.sound.volume = 1;
		}
	}
}