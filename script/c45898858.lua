--ボンディング－H2O
function c45898858.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c45898858.cost)
	e1:SetTarget(c45898858.target)
	e1:SetOperation(c45898858.activate)
	c:RegisterEffect(e1)
end
function c45898858.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,2,nil,22587018)
		and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,58071123) end
	local g1=Duel.SelectReleaseGroup(tp,Card.IsCode,2,2,nil,22587018)
	local g2=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,58071123)
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
function c45898858.filter(c,e,tp)
	return c:IsCode(85066822) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c45898858.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c45898858.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c45898858.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c45898858.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
