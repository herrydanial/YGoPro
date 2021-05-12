--磁石の戦士マグネット·バルキリオン
function c700000047.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c700000047.spcon)
	e1:SetOperation(c700000047.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000047,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c700000047.cost)
	e2:SetTarget(c700000047.target)
	e2:SetOperation(c700000047.operation)
	c:RegisterEffect(e2)
end
function c700000047.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,700000045)
		and Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,700000042)
		and Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,700000043)
end
function c700000047.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,700000045)
	local g2=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,700000042)
	local g3=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,700000043)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Release(g1,REASON_COST)
end
function c700000047.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c700000047.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c700000047.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingTarget(c700000047.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,700000045)
		and Duel.IsExistingTarget(c700000047.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,700000042)
		and Duel.IsExistingTarget(c700000047.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,700000043) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c700000047.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,700000045)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c700000047.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,700000042)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c700000047.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,700000043)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c700000047.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
