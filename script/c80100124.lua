--霊廟の守護者
--Protector of the Shrine
function c80100124.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c80100124.condition)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100124,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e2:SetCountLimit(1,80100124)
	e2:SetCondition(c80100124.spcon)
	e2:SetTarget(c80100124.sptg)
	e2:SetOperation(c80100124.spop)
	c:RegisterEffect(e2)
end
function c80100124.condition(e,c)
	return c:IsRace(RACE_DRAGON)
end
function c80100124.cfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsPreviousPosition(POS_FACEUP) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
		and c:IsPreviousLocation(LOCATION_MZONE) and not c:IsCode(80100124)
end
function c80100124.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c80100124.cfilter,1,nil,tp)
end
function c80100124.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c80100124.cfilter1(c)
	return c:IsRace(RACE_DRAGON) and c:IsPreviousPosition(POS_FACEUP) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsType(TYPE_NORMAL)
end
function c80100124.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_NORMAL) and c:IsAbleToHand()
end
function c80100124.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 and eg:IsExists(c80100124.cfilter,1,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=Duel.SelectMatchingCard(tp,c80100124.filter,tp,LOCATION_GRAVE,0,1,1,nil)
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.SendtoHand(g,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,g)
			end
	end
end
