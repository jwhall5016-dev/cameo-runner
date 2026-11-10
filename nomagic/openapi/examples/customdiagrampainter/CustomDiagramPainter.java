/*
 * Copyright (c) 2002 No Magic, Inc. All Rights Reserved.
 */

package com.nomagic.magicdraw.examples.customdiagrampainter;

import com.nomagic.magicdraw.core.Application;
import com.nomagic.magicdraw.core.Project;
import com.nomagic.magicdraw.core.project.ProjectEventListenerAdapter;
import com.nomagic.magicdraw.plugins.Plugin;
import com.nomagic.magicdraw.ui.DiagramSurfacePainter;
import com.nomagic.magicdraw.uml.symbols.DiagramPresentationElement;
import com.nomagic.magicdraw.uml.symbols.DiagramSurface;
import com.nomagic.magicdraw.uml.symbols.PresentationElement;
import com.nomagic.magicdraw.uml.symbols.shapes.ShapeElement;

import java.awt.*;
import java.beans.PropertyChangeEvent;

/**
 * Plugin for doing some custom diagram painting. This sample shows how to do shapes highlighting the diagram.
 *
 * @author Mindaugas Ringys
 */
public class CustomDiagramPainter extends Plugin
{
	/**
	 * Initializing the plugin.
	 */
	@Override
	public void init()
	{
		//add listener for getting events about opened project
		Application.getInstance().addProjectEventListener(new ProjectEventListenerAdapter()
		{
			@Override
			public void projectOpened(Project project)
			{ //add listener for getting events about opened diagram
				project.addPropertyChangeListener(this::registerCustomDiagramPainter);
			}

			private void registerCustomDiagramPainter(PropertyChangeEvent evt)
			{
				//check event name in order to filter diagram_opened events
				if (evt.getPropertyName().equals(Project.DIAGRAM_OPENED))
				{
					//take active diagram - this will be the opened one
					Project project = Application.getInstance().getProject();
					if (project != null)
					{
						DiagramPresentationElement activeDiagram = project.getActiveDiagram();
						if (activeDiagram != null)
						{
							//register custom painter for painting blue rectangles around every Shape in the diagram
							DiagramSurface diagramSurface = activeDiagram.getDiagramSurface();
							if (diagramSurface != null)
							{
								addPainter(diagramSurface);
							}
						}
					}
				}
			}

			private void addPainter(DiagramSurface diagramSurface)
			{
				diagramSurface.addPainter(new DiagramSurfacePainter()
				{
					@Override
					public void paint(Graphics g, DiagramPresentationElement diagram)
					{
						g.setColor(Color.BLUE);
						//traverse all symbols in the diagram
						java.util.List symbols = diagram.getPresentationElements();
						for (Object symbol : symbols)
						{
							PresentationElement o = (PresentationElement) symbol;
							//do painting just around Shapes
							if (o instanceof ShapeElement)
							{
								Rectangle bounds = o.getBounds();
								bounds.grow(5, 5);
								((Graphics2D) g).draw(bounds);
							}
						}
					}
				});
			}
		});
	}

	/**
	 * Return true always, because this plugin does not have any close specific actions.
	 */
	@Override
	public boolean close()
	{
		return true;
	}

	/**
	 * @see com.nomagic.magicdraw.plugins.Plugin#isSupported()
	 */
	@Override
	public boolean isSupported()
	{
		return true;
	}
}
