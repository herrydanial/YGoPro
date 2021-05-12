--Frightfur March
function c80000193.initial_effect(c)
	-- Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c80000193.discon)
	e1:SetTarget(c80000193.distg)
	e1:SetOperation(c80000193.disop)
	c:RegisterEffect(e1)
end

--Negate
function c80000193.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsFaceup() and (c:IsSetCard(0xad) or c:IsHasEffect(36693940))
end
function c80000193.ffilter(c,e,tp)
	return c:GetLevel()>=8 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsType(TYPE_FUSION) and c:IsSetCard(0xad)
end
function c80000193.discon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or ep==tp then return end
	if not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c80000193.cfilter,1,nil) and Duel.IsChainNegatable(ev)
end
function c80000193.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c80000193.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if tg:IsExists(c80000193.cfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c80000193.ffilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(80000193,0)) then
			Duel.BreakEffect()
			local g=tg:Select(tp,1,1,nil)
			if g then
				Duel.SendtoGrave(g,REASON_EFFECT)
				if g:GetFirst():IsLocation(LOCATION_GRAVE) then
					local ssff=Duel.SelectMatchingCard(tp,c80000193.ffilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
					Duel.SpecialSummon(ssff,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
					-- Banish
					ssff:GetFirst():RegisterFlagEffect(80000193,RESET_EVENT+0x1fe0000,0,1)
					local de=Effect.CreateEffect(e:GetHandler())
					de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
					de:SetCode(EVENT_PHASE+PHASE_END)
					de:SetCountLimit(1)
					de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
					de:SetLabelObject(ssff:GetFirst())
					de:SetCondition(c80000193.bancon)
					de:SetOperation(c80000193.banop)
					if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END then
						de:SetLabel(Duel.GetTurnCount())
						de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
					else
						de:SetLabel(0)
						de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
					end
					Duel.RegisterEffect(de,tp)
				end
			end
		end
	end
end

--Banish
function c80000193.bancon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(80000193)~=0
end
function c80000193.banop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end