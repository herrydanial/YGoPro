--時空超越
--Spacetime Transcendence
--Scripted by dest
function c100217033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c100217033.cost)
	e1:SetTarget(c100217033.target)
	e1:SetOperation(c100217033.activate)
	c:RegisterEffect(e1)
end
function c100217033.filter(c,e,tp)
	local rg=Duel.GetMatchingGroup(c100217033.cfilter,tp,LOCATION_GRAVE,0,c)
	local lv=c:GetLevel()
	return lv>0 and c:IsRace(RACE_DINOSAUR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and rg:CheckWithSumEqual(Card.GetLevel,lv,2,99)
end
function c100217033.cfilter(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsAbleToRemoveAsCost()
end
function c100217033.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c100217033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c100217033.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(c100217033.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
	local lvt={}
	local pc=1
	for i=2,12 do
		if g:IsExists(c100217033.spfilter,1,nil,e,tp,i) then lvt[pc]=i pc=pc+1 end
	end
	lvt[pc]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100217033,0))
	local lv=Duel.AnnounceNumber(tp,table.unpack(lvt))
	local rg=Duel.GetMatchingGroup(c100217033.cfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=rg:SelectWithSumEqual(tp,Card.GetLevel,lv,2,99)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	e:SetLabel(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c100217033.spfilter(c,e,tp,lv)
	return c:GetLevel()==lv and c:IsRace(RACE_DINOSAUR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100217033.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100217033.spfilter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp,e:GetLabel())
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
