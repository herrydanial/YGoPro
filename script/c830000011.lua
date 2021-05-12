--キメラテック・フォートレス・ドラゴン
function c830000011.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFunRep(c,70095154,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),1,63,true,true)
	aux.AddContactFusionProcedure(c,c830000011.cfilter,LOCATION_ONFIELD,LOCATION_ONFIELD,c830000011.sprop(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c830000011.splimit)
	c:RegisterEffect(e1)
	--cannot be fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
c830000011.material_setcode=0x1093
function c830000011.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c830000011.cfilter(c,fc)
	return c:IsAbleToGraveAsCost() and (c:IsControler(fc:GetControler()) or c:IsFaceup()) and (c:IsCode(70095154) or c:IsLocation(LOCATION_MZONE))
end
function c830000011.sprop(c)
	return	function(g)
				Duel.SendtoGrave(g,REASON_COST)
				--spsummon condition
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_BASE_ATTACK)
				e1:SetReset(RESET_EVENT+0xff0000)
				e1:SetValue(g:GetCount()*1000)
				c:RegisterEffect(e1)
			end
end
