--Super Quantum Fairy Alphan
function c80002033.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80002033,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c80002033.lvtarget)
	e1:SetOperation(c80002033.lvoperation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80002033,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,80002033)
	e2:SetCost(c80002033.cost)
	e2:SetTarget(c80002033.target)
	e2:SetOperation(c80002033.operation)
	c:RegisterEffect(e2)
end

function c80002033.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0xdb)
end
function c80002033.cfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_XYZ)
end
function c80002033.lvtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c80002033.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80002033.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80002033.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=Duel.GetMatchingGroup(c80002033.cfilter,tp,LOCATION_MZONE,0,nil)
	local lv=g:GetFirst():GetLevel()
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_LVCHANGE,tc,lv,0,0)
end
function c80002033.lvoperation(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(c80002033.cfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end

function c80002033.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c80002033.spfilter(c,e,tp)
	return c:IsSetCard(0xdb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80002033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c80002033.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and g:GetClassCount(Card.GetCode)>2
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c80002033.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c80002033.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local tg=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
		tg:Merge(sg)
	end
	Duel.ConfirmCards(1-tp,tg)
	local cg=tg:RandomSelect(1-tp,1)
	Duel.ConfirmCards(tp,cg)
	local tc=cg:GetFirst()
	if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		tg:Sub(cg)
		Duel.SendtoGrave(tg,REASON_EFFECT)
	end
end
