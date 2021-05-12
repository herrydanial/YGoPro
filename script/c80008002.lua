--Ties of the Brethren
function c80008002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c80008002.cost)
	e1:SetTarget(c80008002.target)
	e1:SetOperation(c80008002.activate)
	c:RegisterEffect(e1)
end

function c80008002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c80008002.chkfilter(c,ct,ca,cl,cn,e,tp)
	return c:GetRace()==ct and c:GetAttribute()==ca and c:GetLevel()==cl and c:GetCode()~=cn and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c80008002.ctffilter,tp,LOCATION_DECK,0,1,nil,c:GetRace(),c:GetAttribute(),c:GetLevel(),c:GetCode(),e,tp)
end
function c80008002.ctffilter(c,ct,ca,cl,cn,e,tp)
	return c:GetRace()==ct and c:GetAttribute()==ca and c:GetLevel()==cl and c:GetCode()~=cn and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80008002.ctfilter(c,e,tp)
	local ct=c:GetRace()
	local ca=c:GetAttribute()
	local cl=c:GetLevel()
	local cn=c:GetCode()
	return Duel.IsExistingMatchingCard(c80008002.chkfilter,tp,LOCATION_DECK,0,1,nil,ct,ca,cl,cn,e,tp) and c:IsFaceup() and c:IsLevelBelow(4)
end
function c80008002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c80008002.ctfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c80008002.ctfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80008002.ctfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c80008002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local sc=Duel.GetMatchingGroup(c80008002.ctffilter,tp,LOCATION_DECK,0,nil,tc:GetRace(),tc:GetAttribute(),tc:GetLevel(),tc:GetCode(),e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp1=sc:Select(tp,1,1,nil)
	sc:Remove(Card.IsCode,nil,sp1:GetFirst():GetCode())
	local sp2=sc:Select(tp,1,1,nil)
	sp1:Merge(sp2)
	if sp1:GetCount()>1 then
		Duel.SpecialSummon(sp1,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c80008002.sstg)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c80008002.sstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return true
end