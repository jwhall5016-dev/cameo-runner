package io.cameorestservice.plugin;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.actions.mdbasicactions.CallBehaviorAction;
import com.nomagic.uml2.ext.magicdraw.activities.mdbasicactivities.ActivityEdge;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Diagram;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Feature;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Parameter;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Relationship;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdinternalstructures.Connector;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdinternalstructures.ConnectorEnd;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdports.Port;

@JsonInclude(Include.NON_NULL)
public class CameoElement {

    @JsonProperty("ID")
    public String id;
    @JsonProperty("CandidateElementID")
    public int candidateElementID;
    @JsonProperty("ParentID")
    public String parentID;
    @JsonProperty("ModelID")
    private int modelID;
    @JsonProperty("ElementName")
    private int elementName;
    @JsonProperty("ElementDescription")
    private String elementDescription;
    @JsonProperty("Type")
    public String type;
    @JsonProperty("Name")
    public String name;
    @JsonProperty("ParentName")
    public String parentName;
    @JsonProperty("Notes")
    public String notes;
    @JsonProperty("Children")
    public List<CameoElement> children;
    //@JsonProperty("FlowDirection")
    //public String flowDirection;

    public static CameoElement processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();
	CameoElement cameoElement = new CameoElement();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();
	
	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}
	if(element instanceof Port)
	{
	    return CameoProxyPort.processElement(element);
	}
	if(element instanceof Connector)
	{
	    return CameoConnector.processElement(element);
	}
	if(element instanceof ConnectorEnd)
	{
	    return CameoConnectorEnd.processElement(element);
	}
	if(element instanceof Property)
	{
	    return CameoProperty.processElement(element);
	}
	else if(element instanceof Relationship ) 
	{
	    return CameoRelationship.processElement(element);
	}
	else if(element instanceof Parameter)
	{
	    return CameoParameter.processElement(element);  
	}
	else if(element instanceof Feature)
	{
	    return CameoFeature.processElement(element);  
	}
	else if(element instanceof Diagram)
	{
	    return CameoDiagram.processElement(element);  
	}
	else if(element instanceof CallBehaviorAction)
	{
	    return CameoCallBehaviorAction.processElement(element);  
	}
	else if(element instanceof ActivityEdge)
	{
	    return CameoActivityEdge.processElement(element);  
	}

	return cameoElement;
    }
}
