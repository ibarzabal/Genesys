function ReplaceCodeWithSymbols(s, Reverse)
  -- Replaces code pattern with Genesys Dice and Dice Symbols
  local newvalue = s;

  if Reverse then
    -- perform symbol replacements
    newvalue = string.gsub(newvalue, "&#255;", "%(S%)"  );  -- #255 - (S) - Success
    newvalue = string.gsub(newvalue, "&#254;", "%(!%)"  );  -- #254 - (!) - Triumph
    newvalue = string.gsub(newvalue, "&#253;", "%(F%)"  );  -- #253 - (F) - Failure
    newvalue = string.gsub(newvalue, "&#252;", "%(T%)"  );  -- #252 - (T) - Threat
    newvalue = string.gsub(newvalue, "&#251;", "%(A+%)" ); -- #251 - (A) - Advantage
    newvalue = string.gsub(newvalue, "&#250;", "%(D%)"  );  -- #250 - (D) - Despair
    newvalue = string.gsub(newvalue, "&#249;", "%(%-%)" ); -- #249 - (-) - Darkside Force
    newvalue = string.gsub(newvalue, "&#248;", "%(%+%)" ); -- #248 - (+) - Lightside Force
    -- perform dice replacements
    newvalue = string.gsub(newvalue, "&#247;", "%[F%]"  );  -- #247 - [F] - force die
    newvalue = string.gsub(newvalue, "&#246;", "%[A%]"  );  -- #246 - [A] - ability die
    newvalue = string.gsub(newvalue, "&#245;", "%[D%]"  );  -- #245 - [D] - difficulty die
    newvalue = string.gsub(newvalue, "&#244;", "%[P%]"  );  -- #244 - [P] - proficiency die
    newvalue = string.gsub(newvalue, "&#243;", "%[C%]"  );  -- #243 - [C] - challenge
    newvalue = string.gsub(newvalue, "&#242;", "%[B%]"  );  -- #242 - [B] - boost
    newvalue = string.gsub(newvalue, "&#241;", "%[S%]"  );  -- #241 - [S] - setback
  else
    -- perform symbol replacements
    newvalue = string.gsub(newvalue, "%(S%)", "&#255;");  -- #255 - (S) - Success
    newvalue = string.gsub(newvalue, "%(!%)", "&#254;");  -- #254 - (!) - Triumph
    newvalue = string.gsub(newvalue, "%(F%)", "&#253;");  -- #253 - (F) - Failure
    newvalue = string.gsub(newvalue, "%(T%)", "&#252;");  -- #252 - (T) - Threat
    newvalue = string.gsub(newvalue, "%(A+%)", "&#251;"); -- #251 - (A) - Advantage
    newvalue = string.gsub(newvalue, "%(D%)", "&#250;");  -- #250 - (D) - Despair
    newvalue = string.gsub(newvalue, "%(%-%)", "&#249;"); -- #249 - (-) - Darkside Force
    newvalue = string.gsub(newvalue, "%(%+%)", "&#248;"); -- #248 - (+) - Lightside Force
    -- perform dice replacements
    newvalue = string.gsub(newvalue, "%[F%]", "&#247;");  -- #247 - [F] - force die
    newvalue = string.gsub(newvalue, "%[A%]", "&#246;");  -- #246 - [A] - ability die
    newvalue = string.gsub(newvalue, "%[D%]", "&#245;");  -- #245 - [D] - difficulty die
    newvalue = string.gsub(newvalue, "%[P%]", "&#244;");  -- #244 - [P] - proficiency die
    newvalue = string.gsub(newvalue, "%[C%]", "&#243;");  -- #243 - [C] - challenge
    newvalue = string.gsub(newvalue, "%[B%]", "&#242;");  -- #242 - [B] - boost
    newvalue = string.gsub(newvalue, "%[S%]", "&#241;");  -- #241 - [S] - setback
  end
	return newvalue;
end


function ReplaceCodeWithSymbolsCHR(s, Reverse)
  -- Replaces code pattern with Genesys Dice and Dice Symbols
  local newvalue = s;

  if Reverse then
    -- perform symbol replacements
    newvalue = string.gsub(newvalue, string.char(255), "%(S%)"  );  -- #255 - (S) - Success
    newvalue = string.gsub(newvalue, string.char(254), "%(!%)"  );  -- #254 - (!) - Triumph
    newvalue = string.gsub(newvalue, string.char(253), "%(F%)"  );  -- #253 - (F) - Failure
    newvalue = string.gsub(newvalue, string.char(252), "%(T%)"  );  -- #252 - (T) - Threat
    newvalue = string.gsub(newvalue, string.char(251), "%(A+%)" ); -- #251 - (A) - Advantage
    newvalue = string.gsub(newvalue, string.char(250), "%(D%)"  );  -- #250 - (D) - Despair
    newvalue = string.gsub(newvalue, string.char(249), "%(%-%)" ); -- #249 - (-) - Darkside Force
    newvalue = string.gsub(newvalue, string.char(248), "%(%+%)" ); -- #248 - (+) - Lightside Force
    -- perform dice replacements
    newvalue = string.gsub(newvalue, string.char(247), "%[F%]" );  -- #247 - [F] - force die
    newvalue = string.gsub(newvalue, string.char(246), "%[A%]" );  -- #246 - [A] - ability die
    newvalue = string.gsub(newvalue, string.char(245), "%[D%]" );  -- #245 - [D] - difficulty die
    newvalue = string.gsub(newvalue, string.char(244), "%[P%]" );  -- #244 - [P] - proficiency die
    newvalue = string.gsub(newvalue, string.char(243), "%[C%]" );  -- #243 - [C] - challenge
    newvalue = string.gsub(newvalue, string.char(242), "%[B%]" );  -- #242 - [B] - boost
    newvalue = string.gsub(newvalue, string.char(241), "%[S%]" );  -- #241 - [S] - setback
  else
    -- perform symbol replacements
    newvalue = string.gsub(newvalue, "%(S%)",  string.char(255));  -- #255 - (S) - Success
    newvalue = string.gsub(newvalue, "%(!%)",  string.char(254));  -- #254 - (!) - Triumph
    newvalue = string.gsub(newvalue, "%(F%)",  string.char(253));  -- #253 - (F) - Failure
    newvalue = string.gsub(newvalue, "%(T%)",  string.char(252));  -- #252 - (T) - Threat
    newvalue = string.gsub(newvalue, "%(A+%)", string.char(251)); -- #251 - (A) - Advantage
    newvalue = string.gsub(newvalue, "%(D%)",  string.char(250));  -- #250 - (D) - Despair
    newvalue = string.gsub(newvalue, "%(%-%)", string.char(249)); -- #249 - (-) - Darkside Force
    newvalue = string.gsub(newvalue, "%(%+%)", string.char(248)); -- #248 - (+) - Lightside Force
    -- perform dice replacements
    newvalue = string.gsub(newvalue, "%[F%]", string.char(247));  -- #247 - [F] - force die
    newvalue = string.gsub(newvalue, "%[A%]", string.char(246));  -- #246 - [A] - ability die
    newvalue = string.gsub(newvalue, "%[D%]", string.char(245));  -- #245 - [D] - difficulty die
    newvalue = string.gsub(newvalue, "%[P%]", string.char(244));  -- #244 - [P] - proficiency die
    newvalue = string.gsub(newvalue, "%[C%]", string.char(243));  -- #243 - [C] - challenge
    newvalue = string.gsub(newvalue, "%[B%]", string.char(242));  -- #242 - [B] - boost
    newvalue = string.gsub(newvalue, "%[S%]", string.char(241));  -- #241 - [S] - setback
  end

	return newvalue;
end
