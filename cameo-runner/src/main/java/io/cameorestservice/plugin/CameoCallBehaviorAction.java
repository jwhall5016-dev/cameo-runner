package io.cameorestservice.plugin;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.actions.mdbasicactions.CallBehaviorAction;
import com.nomagic.uml2.ext.magicdraw.commonbehaviors.mdbasicbehaviors.Behavior;

@JsonInclude(Include.NON_NULL)
public class CameoCallBehaviorAction extends CameoParameter {
  
  
  public static CameoCallBehaviorAction processElement(BaseElement element)
  {
	  BaseElement parent = element.getObjectParent();
	  CameoCallBehaviorAction cameoElement = new CameoCallBehaviorAction();
	  cameoElement.id = element.getID();
	  cameoElement.name = element.getHumanName();
	  cameoElement.type = element.getHumanType();
	  
	  if(parent != null)
	  {
		  cameoElement.parentID = parent.getID();
		  cameoElement.parentName = parent.getHumanName();
	  }
	  
	  CallBehaviorAction callBehaviorAction = (CallBehaviorAction)element;
	  Behavior behavior = callBehaviorAction.getBehavior();
	  if( behavior != null)
	  {
		cameoElement.reference = behavior.getID();
	  }
	  
	  return cameoElement;
  }
}
