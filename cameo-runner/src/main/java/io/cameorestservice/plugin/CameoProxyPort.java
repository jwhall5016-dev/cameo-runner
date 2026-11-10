package io.cameorestservice.plugin;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdports.Port;

@JsonInclude(Include.NON_NULL)
public class CameoProxyPort extends CameoParameter{

    @JsonProperty("proxyAssociationTypeInterfaceID")
    String proxyAssociationTypeInterfaceID;
    @JsonProperty("proxyAssociationtype")
    String proxyAssociationTypeInterface;

    public static CameoProxyPort processElement(BaseElement baseElement) {

	BaseElement parent = baseElement.getObjectParent();

	CameoProxyPort cameoElement = new CameoProxyPort();
	cameoElement.id = baseElement.getID();
	cameoElement.name = baseElement.getHumanName();
	cameoElement.type = baseElement.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Port portElement = (Port) baseElement;
	Type type = portElement.getType();
	if(type != null) 
	{
	    cameoElement.proxyAssociationTypeInterface = type.getHumanName();
	    cameoElement.proxyAssociationTypeInterfaceID = type.getID();
	}

	return cameoElement;
    }
}
