--Madolche Union
--By DeharaRules
function c16.initial_effect(c)
    c:SetUniqueOnField(1,0,16)
	c:EnableCounterPermit(0x71)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c16.counter)
	c:RegisterEffect(e2)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c16.thcon)
	e3:SetTarget(c16.target)
	e3:SetOperation(c16.operation)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(16,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,16)
	e4:SetCode(EVENT_TO_DECK)
	e4:SetCondition(c16.condition)
	e4:SetTarget(c16.target2)
	e4:SetOperation(c16.operation2)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_TO_HAND)
	c:RegisterEffect(e5)
	--atkup
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x71))
	e6:SetValue(c16.atkval)
	c:RegisterEffect(e6)
	--cannot be target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e7:SetRange(LOCATION_SZONE)
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetTargetRange(LOCATION_ONFIELD,0)
	e7:SetCondition(c16.thcon2)
	e7:SetTarget(c16.tgtg)
	e7:SetValue(aux.tgoval)
	c:RegisterEffect(e7)
end
function c16.tgtg(e,c)
	return c:IsSetCard(0x71) and c~=e:GetHandler()
end
function c16.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x71)>=6
end
function c16.atkval(e,c)
	return e:GetHandler():GetCounter(0x71)*100
end
function c16.cfilter(c)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousSetCard(0x71)
end
function c16.counter(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c16.cfilter,nil)
	if ct>0 then
		e:GetHandler():AddCounter(0x71,ct,true)
	end
end
function c16.filter(c)
	return c:IsSetCard(0x71) and c:IsAbleToDeck()
end
function c16.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x71)>=2
end
function c16.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c16.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16.filter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c16.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c16.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_HAND+LOCATION_EXTRA)
	local dg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)
	if ct>0 and dg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local rg=dg:Select(tp,1,ct,nil)
		Duel.HintSelection(rg)
		Duel.SendtoDeck(rg,nil,1,REASON_EFFECT)
	end
end
function c16.cfilter2(c,tp)
	return c:IsControler(tp) and c:GetPreviousControler()==tp
		and (c:IsPreviousLocation(LOCATION_GRAVE) or (c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)))
		and c:IsSetCard(0x71) and not c:IsLocation(LOCATION_EXTRA)
end
function c16.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x71)>=4 and bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c16.cfilter2,1,nil,tp)
end
function c16.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,LOCATION_DECK)
end
function c16.mfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x71) and c:IsRace(RACE_FAIRY)
end
function c16.filter1(c)
	return c:IsSetCard(0x71) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c16.filter2(c,e,tp)
	return c:IsSetCard(0x71) and c:IsType(TYPE_MONSTER)
		and (c:IsAbleToHand() or c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK))
end
function c16.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local b=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c16.mfilter,tp,LOCATION_MZONE,0,1,nil)
	if not b then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c16.filter1,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c16.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc then
			if not tc:IsAbleToHand() or (tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
				and Duel.SelectYesNo(tp,aux.Stringid(16,1))) then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			else
				Duel.SendtoHand(tc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,tc)
			end
		end
	end
end