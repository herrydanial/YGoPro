--Elemental HERO Nebula Neos
function c100244001.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,89943723,43237273,80344569,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100244001.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c100244001.spcon)
	e2:SetOperation(c100244001.spop)
	c:RegisterEffect(e2)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100244001,0))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c100244001.retcon1)
	e3:SetTarget(c100244001.rettg)
	e3:SetOperation(c100244001.retop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(0)
	e4:SetCondition(c100244001.retcon2)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(100244001,0))
	e5:SetCategory(CATEGORY_DRAW+CATEGORY_DISABLE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCountLimit(1,100244001)
	e5:SetCondition(c100244001.drcon)
	e5:SetTarget(c100244001.drtg)
	e5:SetOperation(c100244001.drop)
	c:RegisterEffect(e5)
end
c100244001.listed_names={89943723,43237273,80344569}
c100244001.material_setcode={0x8,0x3008,0x9,0x1f}
function c100244001.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c100244001.cfilter(c)
	return c:IsFusionCode(89943723,43237273,80344569) and c:IsAbleToDeckOrExtraAsCost()
end
function c100244001.fcheck(c,sg,g,code,...)
	if not c:IsFusionCode(code) then return false end
	if ... then
		g:AddCard(c)
		local res=sg:IsExists(c100244001.fcheck,1,g,sg,g,...)
		g:RemoveCard(c)
		return res
	else return true end
end
function c100244001.fselect(c,tp,mg,sg,...)
	sg:AddCard(c)
	local res=false
	if sg:GetCount()<3 then
		res=mg:IsExists(c100244001.fselect,1,sg,tp,mg,sg,...)
	elseif Duel.GetLocationCountFromEx(tp,tp,sg)>0 then
		local g=Group.CreateGroup()
		res=sg:IsExists(c100244001.fcheck,1,nil,sg,g,...)
	end
	sg:RemoveCard(c)
	return res
end
function c100244001.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c100244001.cfilter,tp,LOCATION_ONFIELD,0,nil)
	local sg=Group.CreateGroup()
	return mg:IsExists(c100244001.fselect,1,nil,tp,mg,sg,89943723,43237273,80344569)
end
function c100244001.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c100244001.cfilter,tp,LOCATION_ONFIELD,0,nil)
	local sg=Group.CreateGroup()
	while sg:GetCount()<3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=mg:FilterSelect(tp,c100244001.fselect,1,1,sg,tp,mg,sg,89943723,43237273,80344569)
		sg:Merge(g)
	end
	local cg=sg:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(sg,nil,2,REASON_COST)
end
function c100244001.retcon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsHasEffect(42015635)
end
function c100244001.retcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(42015635)
end
function c100244001.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100244001.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	if c:IsLocation(LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
	end
end
function c100244001.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c100244001.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c100244001.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	local g=Duel.GetMatchingGroup(aux.disfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 and #g>0 then
		Duel.BreakEffect()
		local sg=g:Select(tp,1,1,nil)
		local tc=sg:GetFirst()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
	end
end
