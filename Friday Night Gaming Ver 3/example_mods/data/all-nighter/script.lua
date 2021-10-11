local countDownsToBlock = 1;
function onStartCountdown()
    if countDownsToBlock > 0 and isStoryMode and not seenCutscene then --Block the first 2 countdowns
        setProperty('inCutscene', true);
        if countDownsToBlock == 2 then
            startVideo('cutscene1');
            seenCutscene = false;
        elseif countDownsToBlock == 1 then
            runTimer('startDialogue', 0.8);
            seenCutscene = true;
        end
        countDownsToBlock = countDownsToBlock - 1;
        return Function_Stop;
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then
        print("Trying to start dialogue...");
        startDialogue('all-nighter', 'all-nighter');
        print("dialogue ended");
    end
end