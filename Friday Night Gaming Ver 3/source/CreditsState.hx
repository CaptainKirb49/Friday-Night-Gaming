package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['Vs Loki Team'], 
		['Moloki', '3', 'Director ,Charter, Offsetter, Dialogue Maker, Story Writer', 'https://www.youtube.com/channel/UCrt8nzuIS4jJIwDray8qfxw', 0xFF4494E6],
		['Nurf', '7', 'Charter For Week 2  3rd and 4th song', 'https://twitter.com/PeculiarNurf?t=685PGtL_fh0ggIrKKJVdqQ&s=09', 0xFFF73838],
		['InukoExo', '5', 'Icon maker, BF and GF Sprites', 'https://youtube.com/channel/UCgtVkexvKBmJpgrg4cRO3nA', 0xFF6475F3],
		['ABrickToTheHead', '2', 'Artist for Week 2, 3 Backgrounds and UI', 'https://twitter.com/ABrickToTheHead', 0xFFFFBB1B],
		['CaptainKirb', '4', 'Main coder', 'https://twitter.com/kirb_captain', 0xFFFFFFFF],
		['E-', '6', 'Some Art In Art Gallery', 'https://twitter.com/Ink_sus', 0xFF61536A],
		['zYield', '9', 'Main Musician', 'https://gamebanana.com/members/1863298', 0xFFFFBB1B],
		['Jewel', '19', 'Charting Help', 'https://www.twitch.tv/thejewelman_', 0xFF4494E6],
		['Ash', '8', 'ORIGINAL Coder', 'https://twitter.com/ash__i_guess_', 0xFF6475F3],
		['JonnyTest', '10', 'Animator for dony', 'https://www.youtube.com/channel/UCELAphr-jUDlWh9jCp4GzEg', 0xFFFFDD33],
		['Nozomy', '11', 'Artist for Dony', 'https://twitter.com/NozomyNikonight', 0xFF4494E6],
		['Bepixel', '12', 'Artist for Luke', 'https://twitter.com/bepixel_owo', 0xFF61536A],
		['Ray', '13', 'Voice Actor for Loki', 'https://gamebanana.com/members/1837141', 0xFFFF9300],
		['OrcaCola', '14', 'Trailer Maker', 'https://www.youtube.com/channel/UCJIK9ajHldNnAbVJe352CiA', 0xFFFFDD33],
		['Nebula', '15', 'OG Coder', 'https://twitter.com/Nebula_Zorua', 0xFFFF9300],
		['AboAlrok', '16', 'Artist For Loki', 'https://twitter.com/AboAlrokArt', 0xFF53E52C],
		['Rebecca Doodles', '17', 'Background Artist For Week 1', 'https://twitter.com/rebecca_doodles', 0xFFFFFFFF],
		['Millie', '18', 'Art in Art Gallery', 'https://gamebanana.com/members/2017822', 0xFFFFFFFF],
		['Scooter', '20', 'Thumbnails and Cameos in Week 2', 'https://twitter.com/CoolGuyScoot', 0xFFD10616],
		['Composer Monke', '21', 'Instrumental for The Hello Song', 'https://twitter.com/GGilbenson', 0xFF4494E6],
		['Musical Sleep', '23', 'Musician For Week 2', 'https://www.youtube.com/channel/UCOFQScfWYz6CeStzFoYcVpg', 0xFFD10616],
		['ChromaCee', '22', 'Trailer for Loki Week', 'https://twitter.com/ChromaCee', 0xFFF73838],
		['ChrisLad', 'clad', 'UI help + Background help', 'https://twitter.com/ChrisLahd', 0xFFFF00FF],
		['Psych Engine Team'],
		['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		[''],
		['Engine Contributors'],
		['shubs',				'shubs',			'New Input System Programmer',						'https://twitter.com/yoshubs',			0xFF4494E6],
		['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		['gedehari',			'gedehari',			'Chart Editor\'s Sound Waveform base',				'https://twitter.com/gedehari',			0xFFFF9300],
		['Keoiki',				'keoiki',			'Note Splash Animations',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['SandPlanet',			'sandplanet',		'Psych Engine Preacher\nAlso cool guy lol',			'https://twitter.com/SandPlanetNG',		0xFFD10616],
		['bubba',				'bubba',		'Guest Composer for "Hot Dilf"',	'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw',	0xFF61536A],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
