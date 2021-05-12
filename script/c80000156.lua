--Supreme Warrior Ritual
function c80000156.initial_effect(c)
	aux.AddRitualProcEqual2(c,c80000156.ritual_filter)
	
	-- SS rit BLS ignoring conditions
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,80000156)
	e1:SetCondition(c80000156.condition)
	e1:SetCost(c80000156.cost)
	e1:SetTarget(c80000156.target)
	e1:SetOperation(c80000156.operation)
	c:RegisterEffect(e1)
end

-- Ritual BLS Filter
function c80000156.ritual_filter(c)
	return c:IsSetCard(0xcf) and bit.band(c:GetType(),0x81)==0x81
end

--SS rit BLS ignoring conditions
function c80000156.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetHandler():GetTurnID()
end
function c80000156.costfilter(c,att)
	return c:IsAbleToRemoveAsCost() and c:IsAttribute(att)
end
function c80000156.ssfilter(c,e,tp)
	return c:IsSetCard(0xcf) and bit.band(c:GetType(),0x81)==0x81 and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c80000156.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c80000156.costfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_LIGHT)
		and Duel.IsExistingMatchingCard(c80000156.costfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_DARK) end
	local tc1=Duel.SelectMatchingCard(tp,c80000156.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_LIGHT)
	local tc2=Duel.SelectMatchingCard(tp,c80000156.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_DARK)
	tc1:Merge(tc2)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.Remove(tc1,POS_FACEUP,REASON_COST)
end
function c80000156.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c80000156.ssfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c80000156.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c80000156.ssfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end