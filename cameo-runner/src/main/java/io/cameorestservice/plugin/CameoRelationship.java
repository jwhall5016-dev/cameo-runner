package io.cameorestservice.plugin;

import java.util.Collection;
import java.util.Iterator;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.DirectedRelationship;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Relationship;

@JsonInclude(Include.NON_NULL)
public class CameoRelationship extends CameoElement {

    @JsonProperty("SourceID")
    public String sourceId;
    @JsonProperty("TargetID")
    public String targetId;

    public static CameoRelationship processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();
	CameoRelationship cameoElement = new CameoRelationship();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Relationship relationship = (Relationship) element;
	if(element instanceof DirectedRelationship )
	{
	    return CameoDirectedRelationship.processElement(element);
	}
	else
	{
	    Collection<Element> relationshipElements = relationship.getRelatedElement();
	    if( relationshipElements.size()==2)
	    {
		Iterator<Element> itr = relationshipElements.iterator();
		Element source = itr.next();
		Element target = itr.next();

		if(source != null) cameoElement.sourceId = source.getID();
		if(target != null) cameoElement.targetId = target.getID();
	    }
	}

	return cameoElement;
    }
}
