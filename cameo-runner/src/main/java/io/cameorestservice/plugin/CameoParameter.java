package io.cameorestservice.plugin;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Parameter;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;

@JsonInclude(Include.NON_NULL)
public class CameoParameter extends CameoElement{

    @JsonProperty("Reference")
    public String reference;

    public static CameoParameter processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();

	CameoParameter cameoElement = new CameoParameter();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Parameter parameter = (Parameter) element;

	Type theType = parameter.getType();
	if( null != theType)
	{
	    cameoElement.reference = theType.getID();
	}

	return cameoElement;
    }
}
