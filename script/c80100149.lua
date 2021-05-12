--インフェルノイド・ティエラ
--Infernoid Tierra
function c80100149.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c80100149.fscon)
	e1:SetOperation(c80100149.fsop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c80100149.con)
	e2:SetTarget(c80100149.tg)
	e2:SetOperation(c80100149.op)
	c:RegisterEffect(e2)
end
c80100149.material_count=2
c80100149.material={14799437,23440231}
function c80100149.mfilter(c,code,mg)
	return (c:IsCode(code) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)) and mg:IsExists(Card.IsSetCard,1,c,0xbb)
end
function c80100149.mfilter1(c,code1,code2,mg)
	return (c:IsCode(code1) or c:IsCode(code2)) and mg:IsExists(Card.IsSetCard,1,c,0xbb)
end
function c80100149.mfilter2(c,mg)
	local g=mg:Clone()
	g:RemoveCard(c)
	if c:IsCode(14799437) then return g:IsExists(c80100149.mfilter,1,nil,23440231,g)
	else return g:IsExists(c80100149.mfilter,1,nil,14799437,g)
	end
end
function c80100149.fscon(e,mg,gc)
	if mg==nil then return false end
	local g=mg:Clone()
	if gc then
		g:RemoveCard(gc)
		if gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) then
			return g:IsExists(c80100149.mfilter1,1,nil,14799437,23440231,g)
		elseif gc:IsCode(14799437) then
			return g:IsExists(c80100149.mfilter,1,nil,23440231,g)
		elseif gc:IsCode(23440231) then
			return g:IsExists(c80100149.mfilter,1,nil,14799437,g)
		else
			return false
		end
	end	
	return g:IsExists(c80100149.mfilter2,1,nil,g)
end
function c80100149.matfilter(c)
	return c:IsCode(14799437) or c:IsCode(23440231)
end
function c80100149.fsop(e,tp,eg,ep,ev,re,r,rp,gc)
	if gc then
		local g0=Group.CreateGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		if gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) then
			g0=eg:FilterSelect(tp,c80100149.matfilter,1,1,nil)
		elseif gc:IsCode(14799437) then
			g0=eg:FilterSelect(tp,Card.IsCode,1,1,nil,23440231)
		elseif gc:IsCode(23440231) then
			g0=eg:FilterSelect(tp,Card.IsCode,1,1,nil,14799437)
		end
		eg:Sub(g0)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=eg:FilterSelect(tp,Card.IsSetCard,1,63,nil,0xa9)
		g1:Merge(g0)
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c80100149.matfilter,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local code=23440231
	if g1:GetFirst():GetCode()==23440231 then code=14799437 end
	local g2=eg:FilterSelect(tp,c80100149.mfilter,1,1,nil,code,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	eg:Sub(g2)
	local g3=eg:FilterSelect(tp,Card.IsSetCard,1,63,g1:GetFirst(),0xbb)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetFusionMaterial(g1)
end
function c80100149.con(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
	and mg:GetClassCount(Card.GetCode)>2
end
function c80100149.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)	
	local count=e:GetHandler():GetMaterial():GetClassCount(Card.GetCode)
	if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,3,PLAYER_ALL,LOCATION_EXTRA)
	if count>4 then 
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,3,PLAYER_ALL,LOCATION_DECK)
	end
	if count>7 then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,0)
	end
	if count>9 then
		Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,1,PLAYER_ALL,1)
	end
end
function c80100149.op(e,tp,eg,ep,ev,re,r,rp)
	local count=e:GetHandler():GetMaterial():GetClassCount(Card.GetCode)
	local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_EXTRA,0,3,3,nil)
	local g2=Duel.SelectMatchingCard(1-tp,nil,tp,0,LOCATION_EXTRA,3,3,nil)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_EFFECT)
	
	if count> 4 then
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,3,REASON_EFFECT)
		Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
	end
	
	if count>7 then
		Duel.BreakEffect()
		local sg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_REMOVED,0,3,3,nil)
		local sg1=Duel.SelectMatchingCard(1-tp,nil,tp,LOCATION_REMOVED,0,3,3,nil)
		sg:Merge(sg1)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
	
	if count>9 then
		Duel.BreakEffect()
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end