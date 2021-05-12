--Assault Blackwing - Raikiri the Sudden Shower
function c80000147.initial_effect(c)
	-- synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	
	-- Tuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c80000147.tcondition)
	e1:SetOperation(c80000147.toperation)
	c:RegisterEffect(e1)
	
	-- Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80000147,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c80000147.destg)
	e2:SetOperation(c80000147.desop)
	c:RegisterEffect(e2)
end

--Tuner
function c80000147.tcondition(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c80000147.toperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterial():IsExists(Card.IsSetCard,1,nil,0x33) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+0xff0000)
		e1:SetValue(TYPE_TUNER)
		c:RegisterEffect(e1)
	end
end

--Destroy
function c80000147.descount(c)
	return c:IsSetCard(0x33) and c:IsType(TYPE_MONSTER)
end
function c80000147.desfilter(c)
	return c:IsDestructable()
end
function c80000147.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c80000147.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c80000147.descount,tp,LOCATION_MZONE,0,1,e:GetHandler())
		and Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c80000147.descount,tp,LOCATION_MZONE,0,e:GetHandler())
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,c80000147.desfilter,tp,0,LOCATION_ONFIELD,1,ct,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	end
end
function c80000147.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end