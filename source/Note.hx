package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var noteType:Int = 0;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var burning:Bool = false; //fire
	public var halo:Bool = false;    //halo/death
	public var warning:Bool = false; //warning sign

	public var noteScore:Float = 1;
	public static var mania:Int = 0;

	public static var noteyOff1:Array<Float> = [4, 0, 0, 0, 0, 0];
	public static var noteyOff2:Array<Float> = [0, 0, 0, 0, 0, 0];
	public static var noteyOff3:Array<Float> = [0, 0, 0, 0, 0, 0];

	public static var swagWidth:Float;
	public static var noteScale:Float;
	public static var pixelnoteScale:Float;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	public static var tooMuch:Float = 30;
	public var rating:String = "shit";


	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0, ?_mustPress:Bool = false, ?inCharter:Bool = false)
	{
		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		pixelnoteScale = 1;
		mania = 0;
		if (PlayState.SONG.mania == 1)
		{
			swagWidth = 120 * 0.7;
			noteScale = 0.6;
			pixelnoteScale = 0.83;
			mania = 1;
		}
		else if (PlayState.SONG.mania == 2)
		{
			swagWidth = 95 * 0.7;
			noteScale = 0.5;
			pixelnoteScale = 0.7;
			mania = 2;
		}
		else if (PlayState.SONG.mania == 3)
			{
				swagWidth = 130 * 0.7;
				noteScale = 0.65;
				pixelnoteScale = 0.9;
				mania = 3;
			}
		else if (PlayState.SONG.mania == 4)
			{
				swagWidth = 110 * 0.7;
				noteScale = 0.58;
				pixelnoteScale = 0.78;
				mania = 4;
			}
		else if (PlayState.SONG.mania == 5)
			{
				swagWidth = 100 * 0.7;
				noteScale = 0.55;
				pixelnoteScale = 0.74;
				mania = 5;
			}

		else if (PlayState.SONG.mania == 6)
			{
				swagWidth = 200 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 6;
			}
		else if (PlayState.SONG.mania == 7)
			{
				swagWidth = 180 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 7;
			}
		else if (PlayState.SONG.mania == 8)
			{
				swagWidth = 170 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 8;
			}
		super();

		if (prevNote == null)
			prevNote = this;
		this.noteType = noteType;
		this.prevNote = prevNote; 
		isSustainNote = sustainNote;

		x += 50;
		if (PlayState.SONG.mania == 2)
			{
				x -= tooMuch;
			}
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		if (Main.editor)
			this.strumTime = strumTime;
		else 
			this.strumTime = Math.round(strumTime);

		if (this.strumTime < 0 )
			this.strumTime = 0;

		this.noteData = noteData % 9;

		var daStage:String = PlayState.curStage;

		//defaults if no noteStyle was found in chart
		var noteTypeCheck:String = 'normal';

		if (PlayState.SONG.noteStyle == null) {
			switch(PlayState.storyWeek) {case 6: noteTypeCheck = 'pixel';}
		} else {noteTypeCheck = PlayState.SONG.noteStyle;}

		switch (noteTypeCheck)
		{
			case 'pixel':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels','week6'), true, 17, 17);

				animation.add('greenScroll', [11]);
				animation.add('redScroll', [12]);
				animation.add('blueScroll', [10]);
				animation.add('purpleScroll', [9]);

				animation.add('whiteScroll', [13]);
				animation.add('yellowScroll', [14]);
				animation.add('violetScroll', [15]);
				animation.add('blackScroll', [16]);
				animation.add('darkScroll', [17]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds','week6'), true, 7, 6);

					animation.add('purpleholdend', [9]);
					animation.add('greenholdend', [11]);
					animation.add('redholdend', [12]);
					animation.add('blueholdend', [10]);

					animation.add('whiteholdend', [13]);
					animation.add('yellowholdend', [14]);
					animation.add('violetholdend', [15]);
					animation.add('blackholdend', [16]);
					animation.add('darkholdend', [17]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);

					animation.add('whitehold', [4]);
					animation.add('yellowhold', [5]);
					animation.add('violethold', [6]);
					animation.add('blackhold', [7]);
					animation.add('darkhold', [8]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom * pixelnoteScale));
				updateHitbox();
			default:
				frames = Paths.getSparrowAtlas('noteassets/shaggy/NOTE_assets');
				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');
				animation.addByPrefix('whiteScroll', 'white0');
				animation.addByPrefix('yellowScroll', 'yellow0');
				animation.addByPrefix('violetScroll', 'violet0');
				animation.addByPrefix('blackScroll', 'black0');
				animation.addByPrefix('darkScroll', 'dark0');


				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');
				animation.addByPrefix('whiteholdend', 'white hold end');
				animation.addByPrefix('yellowholdend', 'yellow hold end');
				animation.addByPrefix('violetholdend', 'violet hold end');
				animation.addByPrefix('blackholdend', 'black hold end');
				animation.addByPrefix('darkholdend', 'dark hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
				animation.addByPrefix('whitehold', 'white hold piece');
				animation.addByPrefix('yellowhold', 'yellow hold piece');
				animation.addByPrefix('violethold', 'violet hold piece');
				animation.addByPrefix('blackhold', 'black hold piece');
				animation.addByPrefix('darkhold', 'dark hold piece');

				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing = true;
			if (noteType == 1)
				{
					//add fire note assets here //zzz
				}
			else if (noteType == 2)
				{
					//add halo note assets here //zzz
				}
			else if (noteType == 3)
				{
					//add warning note assets here //zzz
				}
		}
		var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
		switch (mania)
		{
			case 1: 
				frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
			case 2: 
				frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
			case 3: 
				frameN = ['purple', 'blue', 'white', 'green', 'red'];
			case 4: 
				frameN = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
			case 5: 
				frameN = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', 'black', 'dark'];
			case 6: 
				frameN = ['white'];
			case 7: 
				frameN = ['purple', 'red'];
			case 8: 
				frameN = ['purple', 'white', 'red'];

		}

		x += swagWidth * noteData;
		animation.play(frameN[noteData] + 'Scroll');

		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			animation.play(frameN[noteData] + 'holdend');

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
					//nada
				}
				prevNote.animation.play(frameN[prevNote.noteData] + 'hold');
				//prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed * (0.7 / noteScale);


				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed * (0.7 / noteScale);
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed * (0.7 / noteScale);
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
		{
			// ass
			if (isSustainNote)
			{
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + Conductor.safeZoneOffset)
					canBeHit = true;
				else
					canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}