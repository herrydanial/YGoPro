--Mirror Resonator
function c80002019.initial_effect(c)
	
	-- Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,80002019)
	e1:SetCondition(c80002019.spcon)
	e1:SetTarget(c80002019.sptg)
	e1:SetOperation(c80002019.spop)
	c:RegisterEffect(e1)
	
	-- Lv Change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80002019,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c80002019.target)
	e2:SetOperation(c80002019.operation)
	c:RegisterEffect(e2)
end

--Special Summon
function c80002019.lefilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA
end
function c80002019.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c80002019.lefilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c80002019.lefilter,tp,0,LOCATION_MZONE,1,nil)
end
function c80002019.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c80002019.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0xfe0000)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end

--Lv Change
function c80002019.lvfilter(c)
	return c:IsFaceup() and c:GetOriginalLevel()>0
end
function c80002019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c80002019.lvfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80002019.lvfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c80002019.operation(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local lv=tc:GetOriginalLevel()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsFaceup() then
		-- Level
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SYNCHRO_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end