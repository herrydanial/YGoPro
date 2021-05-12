--True Name
function c80006103.initial_effect(c)
	--announce
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80006103,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,80006103)
	e1:SetTarget(c80006103.target)
	e1:SetOperation(c80006103.operation)
	c:RegisterEffect(e1)
end

function c80006103.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DEVINE) and (c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsAbleToHand())
end
function c80006103.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c80006103.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc:IsCode(ac) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		if Duel.IsExistingMatchingCard(c80006103.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.SelectYesNo(tp,aux.Stringid(80006103,0)) then
			local th=Duel.SelectMatchingCard(tp,c80006103.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			local ch=th:GetFirst()
			if not ch:IsCanBeSpecialSummoned(e,0,tp,false,false) or (ch:IsAbleToHand() and Duel.SelectYesNo(tp,aux.Stringid(80006103,1))) then
				Duel.SendtoHand(ch,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,ch)
			else
				Duel.SpecialSummon(ch,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	end
end