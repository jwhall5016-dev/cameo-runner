package io.cameorestservice.plugin;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.DirectedRelationship;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;

@JsonInclude(Include.NON_NULL)
public class CameoDirectedRelationship extends CameoRelationship{

    public static CameoDirectedRelationship processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();

	CameoDirectedRelationship cameoElement = new CameoDirectedRelationship();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	DirectedRelationship dirRel = (DirectedRelationship) element;

	if( null != dirRel.getSource() && 1==dirRel.getSource().size())
	{
	    Element src = dirRel.getSource().iterator().next();
	    if(src !=  null)
	    {
		cameoElement.sourceId = src.getID();
	    }
	}
	if( null != dirRel.getTarget() && 1==dirRel.getTarget().size())
	{
	    Element tgt = dirRel.getTarget().iterator().next();
	    if(tgt != null)
	    {
		cameoElement.targetId = tgt.getID();
	    }
	}

	return cameoElement;
    } 
}
