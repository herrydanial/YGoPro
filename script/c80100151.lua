--覇王黒竜オッドアイズ・リベリオン・ドラゴン
--Odd-Eyes Rebellion Dragon
function c80100151.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),7,2)
	c:EnableReviveLimit()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c80100151.condition)
	e1:SetTarget(c80100151.target)
	e1:SetOperation(c80100151.operation)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100151,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c80100151.con)
	e2:SetOperation(c80100151.op)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c80100151.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--tozone
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(80100151,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCondition(c80100151.con2)
	e4:SetTarget(c80100151.tg2)
	e4:SetOperation(c80100151.op2)
	c:RegisterEffect(e4)
end
c80100151.pendulum_level=7
function c80100151.condition(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)==nil
end
function c80100151.filter(c,tp)
	return c:IsType(TYPE_PENDULUM) and c:GetActivateEffect():IsActivatable(tp)
end
function c80100151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80100151.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function c80100151.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(80100151,0))
	local tc=Duel.SelectMatchingCard(tp,c80100151.filter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c80100151.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsType,1,nil,TYPE_XYZ) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c80100151.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetLabel()==1
end
function c80100151.desfilter(c) 
	return c:IsFaceup() and c:IsLevelBelow(7)
end
function c80100151.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(2)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local g=Duel.GetMatchingGroup(c80100151.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then 
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
	end
end
function c80100151.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c80100151.con2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_MZONE)
end
function c80100151.desfilter1(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c80100151.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 	
		Duel.IsExistingMatchingCard(c80100151.desfilter1,tp,LOCATION_SZONE,0,1,nil)
	end
	local dg=Duel.GetMatchingGroup(c80100151.desfilter1,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c80100151.op2(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c80100151.desfilter1,tp,LOCATION_SZONE,0,nil)
	if Duel.Destroy(dg,REASON_EFFECT)>0 then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end