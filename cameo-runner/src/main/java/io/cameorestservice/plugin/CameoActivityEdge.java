package io.cameorestservice.plugin;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.activities.mdbasicactivities.ActivityEdge;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.OpaqueExpression;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.ValueSpecification;

@JsonInclude(Include.NON_NULL)
public class CameoActivityEdge extends CameoRelationship{
    @JsonProperty("OpaqueExpressions")
    private List<String> opaqueExpressions;

    public static CameoActivityEdge processElement(BaseElement element)
    {

	BaseElement parent = element.getObjectParent();
	CameoActivityEdge cameoElement = new CameoActivityEdge();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	ActivityEdge activityEdge = (ActivityEdge)element;
	Element src = activityEdge.getSource();
	Element tgt = activityEdge.getTarget();
	if( null != src && null != tgt)
	{
	    ValueSpecification valueSpec = activityEdge.getGuard();
	    if( null != valueSpec && valueSpec instanceof OpaqueExpression )
	    {
		OpaqueExpression opaqueExpression = (OpaqueExpression)valueSpec;
		List<String> expr = opaqueExpression.getBody();
		cameoElement.opaqueExpressions = new ArrayList<String>();
		for( String ex: expr)
		{
		    cameoElement.opaqueExpressions.add(ex);
		}
	    }

	    cameoElement.sourceId = src.getID();
	    cameoElement.targetId = tgt.getID();
	}

	return cameoElement;
    }


}
