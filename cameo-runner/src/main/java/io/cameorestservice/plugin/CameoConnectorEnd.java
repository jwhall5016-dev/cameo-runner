package io.cameorestservice.plugin;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.TypedElement;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdinternalstructures.ConnectableElement;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdinternalstructures.ConnectorEnd;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.compositestructures.mdports.Port;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Profile;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;
import com.nomagic.magicdraw.core.Project;

@JsonInclude(Include.NON_NULL)
public class CameoConnectorEnd extends CameoElement{

    @JsonProperty("EndID")
    String endID;
    @JsonProperty("LocalID")
    String localID;
    @JsonProperty("BaseElementID")
    String baseElementID;
    @JsonProperty("EndName")
    String endName;
    @JsonProperty("EndType")
    String endType;
    @JsonProperty("EndText")
    String endText;
    @JsonProperty("RoleName")
    String roleName;
    @JsonProperty("RoleID")
    String roleId;
    @JsonProperty("RoleParentID")
    String roleParentId;
    @JsonProperty("RoleType")
    String roleType;
    @JsonProperty("PortDirection")
    String PortDirection;
    @JsonProperty("QualifiedName")
    String qualifiedName;
    @JsonProperty("RoleElementPropertyType")
    String roleElementPropertyType;
    @JsonProperty("RoleElementName")
    String roleElementName;
    @JsonProperty("RoleElementParentName")
    String roleElementParentName;

    public static CameoConnectorEnd processElement(BaseElement baseElement) {

	BaseElement parent = baseElement.getObjectParent();

	CameoConnectorEnd cameoElement = new CameoConnectorEnd();
	cameoElement.id = baseElement.getID();
	cameoElement.name = baseElement.getHumanName();
	cameoElement.type = baseElement.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	ConnectorEnd end = (ConnectorEnd)baseElement;

	cameoElement.endID = end.getID();
	cameoElement.localID = end.getLocalID();
	cameoElement.baseElementID = end.sGetID();
	cameoElement.endName = end.getHumanName();
	cameoElement.endType = end.getHumanType();
	cameoElement.endText = end.get_representationText();

	ConnectableElement conElement = end.getRole();
	if(conElement != null) 
	{
	    String roleID = conElement.getID();
	    cameoElement.roleName = conElement.getHumanName();
	    cameoElement.roleId = roleID;
	    cameoElement.roleType = conElement.getHumanType();
	    cameoElement.qualifiedName = conElement.getQualifiedName();
	    
	    if(conElement instanceof Port) 
	    {
		Element element = (Element)conElement;
		    
		Project proj = CameoRunner.project;
		Profile sysMLProfile = StereotypesHelper.getProfile(proj, "SysML Profile");
		Stereotype flowPortStereo = StereotypesHelper.getStereotype(proj, "FlowPort", sysMLProfile);
		Property prop = StereotypesHelper.getPropertyByName(flowPortStereo, "direction");
		List<String> values = StereotypesHelper.getStereotypePropertyValueAsString(element, flowPortStereo, prop.getName());
		
		if(values.size() > 0)
		{
		    cameoElement.PortDirection = values.get(0);
		}
	    }

	    BaseElement roleElement = CameoRunner.project.getElementByID(roleID);
	    cameoElement.roleElementName = roleElement.getHumanName();

	    if(roleElement instanceof Property)
	    {
		Property roleElementProp = (Property)roleElement;

		TypedElement typeElement = (TypedElement)roleElementProp;
		Type type = typeElement.getType();
		if(type != null)
		{
		    cameoElement.roleElementPropertyType = type.getHumanName();
		}
	    }

	    BaseElement roleElementParent = roleElement.getObjectParent();

	    if(roleElementParent != null)
	    {
		cameoElement.roleParentId = roleElementParent.getID();
		cameoElement.roleElementParentName = roleElementParent.getHumanName();
	    }

	}
	return cameoElement;
    }  
}
