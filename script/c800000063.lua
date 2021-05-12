--彼岸の悪鬼 ラビキャント
function c800000063.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c800000063.sdcon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(800000063,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,800000063)
	e2:SetCondition(c800000063.sscon)
	e2:SetTarget(c800000063.sstg)
	e2:SetOperation(c800000063.ssop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c800000063.synlimit)
	c:RegisterEffect(e3)
end
function c800000063.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0xb1)
end
function c800000063.sdfilter(c)
	return not c:IsFaceup() or not c:IsSetCard(0xb1)
end
function c800000063.sdcon(e)
	return Duel.IsExistingMatchingCard(c800000063.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c800000063.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c800000063.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c800000063.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c800000063.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c800000063.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
