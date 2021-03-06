--DDD死謳王バイス・レクイエム

--Scripted by nekrozar
function c100259037.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100259037,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,100259037)
	e1:SetTarget(c100259037.sptg)
	e1:SetOperation(c100259037.spop)
	c:RegisterEffect(e1)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c100259037.splimit)
	c:RegisterEffect(e2)
	--effect gain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCondition(c100259037.effcon)
	e3:SetOperation(c100259037.effop)
	c:RegisterEffect(e3)
end
function c100259037.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xae)
end
function c100259037.desfilter2(c,e)
	return c100259037.desfilter(c) and c:IsCanBeEffectTarget(e)
end
function c100259037.fselect(g,tp)
	return Duel.GetMZoneCount(tp,g)>0
end
function c100259037.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c100259037.desfilter(chkc) end
	local g=Duel.GetMatchingGroup(c100259037.desfilter2,tp,LOCATION_ONFIELD,0,nil,e)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and g:CheckSubGroup(c100259037.fselect,1,g:GetCount(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:SelectSubGroup(tp,c100259037.fselect,false,1,g:GetCount(),tp)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100259037.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct~=0 then
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local res=0
			if c:GetLevel()==1 then
				res=Duel.SelectOption(tp,aux.Stringid(100259037,2),aux.Stringid(100259037,3))
			else
				res=Duel.SelectOption(tp,aux.Stringid(100259037,2),aux.Stringid(100259037,3),aux.Stringid(100259037,4))
			end
			if res>0 then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UPDATE_LEVEL)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				if res==1 then
					e1:SetValue(ct)
				else
					e1:SetValue(-ct)
				end
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				c:RegisterEffect(e1)
			end
		end
	end
end
function c100259037.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x10af)
end
function c100259037.effcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_FUSION+REASON_SYNCHRO+REASON_XYZ+REASON_LINK)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():GetReasonCard():IsSetCard(0x10af)
end
function c100259037.effop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(ep,100259037)~=0 then return end
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(100259037,1))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DESTROY+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c100259037.destg)
	e1:SetOperation(c100259037.desop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e2,true)
	end
	rc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(100259037,5))
	Duel.RegisterFlagEffect(ep,100259037,RESET_PHASE+PHASE_END,0,1)
end
function c100259037.desfilter3(c,tp)
	return Duel.IsExistingMatchingCard(c100259037.tdfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,c)
end
function c100259037.tdfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsSetCard(0xae) and c:IsAbleToDeck()
end
function c100259037.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c100259037.desfilter3(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c100259037.desfilter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100259037.desfilter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_ONFIELD+LOCATION_GRAVE)
end
function c100259037.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local exc=nil
	if tc:IsRelateToEffect(e) then exc=tc end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100259037.tdfilter),tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,exc)
	if g:GetCount()>0 and Duel.SendtoDeck(g,nil,2,REASON_EFFECT)~=0
		and g:GetFirst():IsLocation(LOCATION_DECK+LOCATION_EXTRA) and tc:IsRelateToEffect(e) then
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.BreakEffect()
			Duel.Recover(tp,1000,REASON_EFFECT)
		end
	end
end
