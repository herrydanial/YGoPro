--Ultimitl Bishbalkin the Ultimate Legendary God
function c80007006.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c80007006.sprcon)
	e2:SetOperation(c80007006.sprop)
	c:RegisterEffect(e2)
	--indestructable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c80007006.atkval)
	c:RegisterEffect(e4)
	--token
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(80007006,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e5:SetCountLimit(1)
	e5:SetCondition(c80007006.tkcon)
	e5:SetTarget(c80007006.tktg)
	e5:SetOperation(c80007006.tkop)
	c:RegisterEffect(e5)
end

function c80007006.sprfilter1(c,tp)
	local lv=c:GetLevel()
	return lv>7 and c:IsFaceup() and c:IsType(TYPE_TUNER) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c80007006.sprfilter2,tp,LOCATION_MZONE,0,1,nil,lv)
end
function c80007006.sprfilter2(c,lv)
	return c:IsFaceup() and c:GetLevel()==lv and not c:IsType(TYPE_TUNER) and c:IsAbleToGraveAsCost()
end
function c80007006.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c80007006.sprfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c80007006.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c80007006.sprfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c80007006.sprfilter2,tp,LOCATION_MZONE,0,1,1,nil,g1:GetFirst():GetLevel())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c80007006.atkval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,LOCATION_MZONE)*1000
end

function c80007006.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c80007006.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,80107006,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_DEFENCE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c80007006.tkop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,80107006,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_DEFENCE) then return end
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft1<=0 or ft2<=0 then return end
	if ft1>ft2 then ft1=ft2 end
	if ft1<ft2 then ft2=ft1 end
	while ft1~=0 do
		local token=Duel.CreateToken(tp,80107006)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
		ft1=ft1-1
	end
	while ft2~=0 do
		local token=Duel.CreateToken(tp,80107006)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENCE)
		ft2=ft2-1
	end
	Duel.SpecialSummonComplete()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end