package io.cameorestservice.plugin;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.DataType;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.TypedElement;

@JsonInclude(Include.NON_NULL)
public class CameoProperty extends CameoParameter{

    @JsonProperty("DataTypeName")
    String dataTypeName;
    @JsonProperty("PropertyType")
    String propertyType;

    public static CameoProperty processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();

	CameoProperty cameoElement = new CameoProperty();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Property property = (Property)element;
	DataType dataType = property.getDatatype();
	if(dataType != null)
	{
	    cameoElement.dataTypeName = dataType.getName();
	}

	TypedElement typeElement = (TypedElement)property;
	Type type = typeElement.getType();
	if(type != null)
	{
	    cameoElement.propertyType = type.getHumanName();
	}

	return cameoElement;
    }
}
