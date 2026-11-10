package io.cameorestservice.plugin;

import java.util.Collection;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.auxiliaryconstructs.mdinformationflows.InformationFlow;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.NamedElement;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdinternalstructures.Connector;
@JsonInclude(Include.NON_NULL)
public class CameoConnector extends CameoElement{

    @JsonProperty("Ends")
    List<CameoConnectorEnd>ends;
    @JsonProperty("FlowSourceID")
    String flowSourceId;
    @JsonProperty("FlowSourceName")
    String flowSourceName;
    @JsonProperty("FlowTargetID")
    String flowTargetId;
    @JsonProperty("FlowTargetName")
    String flowTargetName;

    public static CameoConnector processElement(BaseElement element)
    {  
	BaseElement parent = element.getObjectParent();
	CameoConnector cameoElement = new CameoConnector();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Connector con = (Connector)element;

	Collection<InformationFlow> flows = con.get_informationFlowOfInformationSource();
	flows = con.get_informationFlowOfInformationTarget();
	flows = con.get_informationFlowOfRealizingConnector();
	for(InformationFlow flow: flows)
	{
	    cameoElement.flowSourceId= "";
	    cameoElement.flowSourceName="";

	    Collection<NamedElement> sources = flow.getInformationSource();
	    for(NamedElement source: sources)
	    {
		String srcID = source.getID();
		if(!srcID.isBlank())
		{
		    cameoElement.flowSourceId.concat(srcID);
		}

		String srcName = source.getHumanName();
		if(!srcName.isBlank())
		{
		    cameoElement.flowSourceName.concat(srcName);
		}
	    }

	    cameoElement.flowTargetId="";
	    cameoElement.flowTargetName="";

	    Collection<NamedElement> targets = flow.getInformationTarget();
	    for(NamedElement target: targets)
	    {
		String tgtId = target.getID();
		if(!tgtId.isBlank())
		{
		    cameoElement.flowTargetId.concat(tgtId);
		}

		String tgtName = target.getHumanName();
		if(!tgtName.isBlank())
		{
		    cameoElement.flowTargetName.concat(target.getHumanName());
		}
	    }
	} 
	return cameoElement;
    }
}
