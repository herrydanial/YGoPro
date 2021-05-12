--Orichalcos Shunoros
function c700000120.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000120,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c700000120.spcon)
	e2:SetTarget(c700000120.sptg)
	e2:SetOperation(c700000120.spop)
	c:RegisterEffect(e2)
	--Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(700000120,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c700000120.tg)
	e3:SetOperation(c700000120.op)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--cannot remove
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_REMOVE)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
end

function c700000120.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and not c:IsLocation(LOCATION_DECK)
end

function c700000120.spfilter(c,e,tp)
	return c:IsCode(700000119) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end

function c700000120.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c700000120.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c700000120.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,1,tp,tp,true,true,POS_FACEUP)
	end
end

function c700000120.spfilter2(c,e,tp)
	return c:IsCode(700000125) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end

function c700000120.spfilter3(c,e,tp)
	return c:IsCode(700000124) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end

function c700000120.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end

function c700000120.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c700000120.spfilter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g1:GetCount()>0 then Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,true,true,POS_FACEUP) end
	local g2=Duel.SelectMatchingCard(tp,c700000120.spfilter3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g2:GetCount()>0 then Duel.SpecialSummonStep(g2:GetFirst(),0,tp,tp,true,true,POS_FACEUP) end
	Duel.SpecialSummonComplete()
end

