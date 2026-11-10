package io.cameorestservice.plugin;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Classifier;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Feature;

@JsonInclude(Include.NON_NULL)
public class CameoFeature extends CameoParameter{


    public static CameoFeature processElement(BaseElement element) {

	BaseElement parent = element.getObjectParent();
	CameoFeature cameoElement = new CameoFeature();
	cameoElement.id = element.getID();
	cameoElement.name = element.getHumanName();
	cameoElement.type = element.getHumanType();

	if(parent != null)
	{
	    cameoElement.parentID = parent.getID();
	    cameoElement.parentName = parent.getHumanName();
	}

	Feature feature = (Feature)element;
	Classifier classifier = feature.getFeaturingClassifier();
	if( null != classifier)
	{
	    cameoElement.reference = classifier.getID();
	}

	return cameoElement;
    }
}
