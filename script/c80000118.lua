--Assault Blackwing - Kunai the Drizzle
function c80000118.initial_effect(c)
	-- Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c80000118.spcon)
	e1:SetOperation(c80000118.spop)
	c:RegisterEffect(e1)
	
	-- Level Change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80000118,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c80000118.lvtarget)
	e2:SetOperation(c80000118.lvop)
	c:RegisterEffect(e2)
end

--Special Summon
function c80000118.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),Card.IsSetCard,1,nil,0x33)
end
function c80000118.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),Card.IsSetCard,1,1,nil,0x33)
	Duel.Release(g,REASON_COST)
	-- Tuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetValue(TYPE_TUNER)
	c:RegisterEffect(e1)
end

--Level Change
function c80000118.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c80000118.lvtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80000118.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80000118.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectTarget(tp,c80000118.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local t={}
	local i=1
	local p=1
	local lv=tc:GetFirst():GetLevel()
	for i=1,8 do 
		if lv~=i then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(80000118,0))
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
end
function c80000118.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end