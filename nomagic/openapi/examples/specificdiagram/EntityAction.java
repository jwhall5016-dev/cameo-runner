/*
 *
 * Copyright (c) 2003 NoMagic, Inc. All Rights Reserved.
 */
package com.nomagic.magicdraw.examples.specificdiagram;

import com.nomagic.magicdraw.core.Application;
import com.nomagic.magicdraw.core.Project;
import com.nomagic.magicdraw.properties.PropertyID;
import com.nomagic.magicdraw.properties.PropertyPool;
import com.nomagic.magicdraw.ui.actions.DrawShapeDiagramAction;
import com.nomagic.magicdraw.uml.symbols.PresentationElement;
import com.nomagic.ui.ScalableImageIcon;
import com.nomagic.uml2.StandardProfile;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;

import javax.swing.*;
import java.awt.event.KeyEvent;

/**
 * Action for drawing entity element.
 *
 * @author Mindaugas Ringys
 */
class EntityAction extends DrawShapeDiagramAction
{
	public static final String DRAW_ENTITY_ACTION = "DRAW_ENTITY_ACTION";

	public EntityAction()
	{
		super(DRAW_ENTITY_ACTION, "Entity", KeyStroke.getKeyStroke(KeyEvent.VK_E, 0));
		final Class clazz = getClass();
		//noinspection OverridableMethodCallDuringObjectConstruction
		setLargeIcon(new ScalableImageIcon(clazz, "" + "icons/entity.gif"));
	}

	/**
	 * Creates model element
	 *
	 * @return created model element
	 */
	@Override
	protected Element createElement()
	{
		Project project = Application.getInstance().getProject();
		//noinspection ConstantConditions
		com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class clazz = project.getElementsFactory().createClassInstance();
		StereotypesHelper.addStereotype(clazz, StandardProfile.getInstance(project).getEntity());

		return clazz;
	}

	/**
	 * Creates presentation element.
	 *
	 * @return created presentation element
	 */
	@Override
	protected PresentationElement createPresentationElement()
	{
		PresentationElement presentationElement = super.createPresentationElement();
		presentationElement.addProperty(PropertyPool.getBooleanProperty(PropertyID.SUPPRESS_CLASS_ATTRIBUTES, true, "ATTRIBUTES"));
		presentationElement.addProperty(PropertyPool.getBooleanProperty(PropertyID.SUPPRESS_CLASS_OPERATIONS, true, "OPERATIONS"));
		return presentationElement;
	}
}
