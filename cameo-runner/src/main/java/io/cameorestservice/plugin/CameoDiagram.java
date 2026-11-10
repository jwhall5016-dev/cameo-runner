package io.cameorestservice.plugin;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;

@JsonInclude(Include.NON_NULL)
public class CameoDiagram extends CameoElement{

    public static CameoDiagram processElement(BaseElement element)
    {    
	BaseElement parent = element.getObjectParent();

	CameoDiagram cameoElement = new CameoDiagram();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	return cameoElement;
    }
}
