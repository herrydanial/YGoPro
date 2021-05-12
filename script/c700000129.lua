--The Seal of Orichalcos
function c700000129.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCost(c700000129.setcost)
	e1:SetTarget(c700000129.ytarget)
	c:RegisterEffect(e1)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c700000129.sdcon)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c700000129.efilter)
	c:RegisterEffect(e3)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_ONFIELD,LOCATION_OFFFIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetTarget(c700000129.bfilter)
	e4:SetValue(500)
	c:RegisterEffect(e4)
	--Def up
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_ONFIELD,LOCATION_OFFFIELD)
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	e5:SetTarget(c700000129.bfilter)
	e5:SetValue(500)
	c:RegisterEffect(e5)
	--activation
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_ACTIVATE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetValue(c700000129.dfilter)
	c:RegisterEffect(e6)
	--Moving From MZONE To SZONE
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(7093411,1))
	e7:SetCategory(CATEGORY_LEAVE_MZONE)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetRange(LOCATION_FZONE)
	e7:SetTarget(c700000129.target)
	e7:SetOperation(c700000129.Operation)
	c:RegisterEffect(e7)
	--SP.Summon From SZONE To MZONE
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(34487429,3))
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetRange(LOCATION_FZONE)
	e8:SetTarget(c700000129.sptg)
	e8:SetOperation(c700000129.spop)
	c:RegisterEffect(e8)
end
function c700000129.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 1==1 end
	Duel.RegisterFlagEffect(tp,c700000129,RESET_PHASE+PHASE_END,0,1)
end

function c700000129.efilter(e,te)
	return te:IsActiveType(TYPE_QUICKPLAY+TYPE_COUNTER+TYPE_SPELL+TYPE_TRAP+TYPE_EFFECT)
end

function c700000129.bfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT+ATTRIBUTE_WATER+ATTRIBUTE_FIRE+ATTRIBUTE_EARTH+ATTRIBUTE_WIND)
end

function c700000129.dfilter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end

function c700000129.ytarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	Duel.SetChainLimit(aux.FALSE)
end

function c700000129.vfilter(c)
	return c:IsFaceup() and c:IsCode(12395) or c:IsCode(12396) or c:IsCode(12397)
end

function c700000129.sdcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c700000129.vfilter,c:GetControler(),0,LOCATION_MZONE,1,c)
end

function c700000129.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c700000129.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c700000129.filter(chkc) end
	if chk==0 then
		if not Duel.IsExistingTarget(c700000129.filter,tp,LOCATION_MZONE,0,1,nil) then return false end
		if e:GetHandler():IsLocation(LOCATION_HAND) then
			return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		else return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft>5 then ft=5 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectTarget(tp,c700000129.filter,tp,LOCATION_MZONE,0,1,ft,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_MZONE,g,g:GetCount(),0,0)
end
function c700000129.Operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		if sg:GetCount()>ft then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
			local rg=sg:Select(tp,ft,ft,nil)
			sg=rg
		end
		local tc=sg:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=sg:GetNext()
		end
		Duel.RaiseEvent(sg,EVENT_CUSTOM+47408488,e,0,tp,0,0)
	end
end

function c700000129.filter2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c700000129.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c700000129.filter2,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c700000129.filter2,tp,LOCATION_SZONE,0,1,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c700000129.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	local ct=Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end