/*
 * Copyright (c) 2007 NoMagic, Inc. All Rights Reserved.
 */
package com.nomagic.magicdraw.examples.dependencymatrix;

import com.nomagic.actions.ActionsCategory;
import com.nomagic.magicdraw.dependencymatrix.datamodel.ElementNode;
import com.nomagic.magicdraw.dependencymatrix.datamodel.cell.AbstractMatrixCell;
import com.nomagic.magicdraw.dependencymatrix.datamodel.cell.DependencyDirection;
import com.nomagic.magicdraw.dependencymatrix.datamodel.cell.DependencyEntry;
import com.nomagic.magicdraw.dependencymatrix.datamodel.cell.DependencyExtractor;
import com.nomagic.magicdraw.dependencymatrix.persistence.PersistenceManager;
import com.nomagic.magicdraw.uml.ClassTypes;
import com.nomagic.magicdraw.uml.ModelElementsProvider;
import com.nomagic.magicdraw.uml.actions.SelectInContainmentTreeAction;
import com.nomagic.uml2.ext.jmi.smartlistener.SmartListenerConfig;
import com.nomagic.uml2.ext.magicdraw.classes.mddependencies.Dependency;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Classifier;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.NamedElement;
import com.nomagic.uml2.impl.PropertyNames;
import org.eclipse.core.runtime.IProgressMonitor;

import javax.annotation.CheckForNull;
import javax.annotation.Nonnull;
import java.util.*;

/**
 * This sample dependency extractor creates dependencies according to logic specified by the code. If there is
 * no way to express the dependency using Expression Dependency Criteria users may create their own
 * custom logic implemented in Java language.
 * <p/>
 * Additionally, there is a possibility to provide additional navigation actions, which allow to navigate to the
 * specific dependencies, not only to row/column elements
 *
 * @author Vytautas Dagilis
 */
class SampleDependencyExtractor implements DependencyExtractor
{

    private Map<Class<? extends Element>, Collection<SmartListenerConfig>> mSmartListenerConfiguration;

    @Override
    public void init(PersistenceManager settings, @CheckForNull IProgressMonitor status)
    {
        Collection<Element> typeSet = new HashSet<>(settings.getRowSettings().getElementTypes());
        typeSet.addAll(settings.getColumnSettings().getElementTypes());
        mSmartListenerConfiguration = createSmartListenerConfiguration(typeSet);
    }

    @Nonnull
    @Override
    public Collection<DependencyEntry> getDependencies(ElementNode row, ElementNode column)
    {
        Element rowElement = row.getElement();
        Element columnElement = column.getElement();
        //Creates dependencies between elements if there is a Dependency relationship between row and column
        if (rowElement instanceof NamedElement && columnElement instanceof NamedElement)
        {
            NamedElement namedRow = (NamedElement) rowElement;
            NamedElement namedColumn = (NamedElement) columnElement;
            Collection<Dependency> clientDependency = new ArrayList<>(namedRow.getClientDependency());
            Collection<Dependency> supplierDependency = namedColumn.getSupplierDependency();
            clientDependency.retainAll(supplierDependency);
            if (clientDependency.size() > 0)
            {
                Collection<DependencyEntry> dependencies = new ArrayList<>();
                for (Dependency dependency : clientDependency)
                {
                    dependencies.add(new DependencyEntry(DependencyDirection.ROW_TO_COLUMN,
                                                         Collections.singletonList(dependency)));
                }
                return dependencies;
            }
        }
        return Collections.emptyList();
    }

    @Override
    public void createNavigationActions(PersistenceManager persistenceManager, ElementNode row, ElementNode column,
                                        AbstractMatrixCell value, ActionsCategory navigateCategory)
    {
        //Add action to select all elements which are causing dependency to occur (Dependency relationship) in the containment tree
        Collection<DependencyEntry> dependencies = value.getDependencies();
        for (final DependencyEntry dependency : dependencies)
        {
            SelectInContainmentTreeAction selectInContainmentTreeAction = new SelectInContainmentTreeAction(
                    dependency.toString(), null);
            selectInContainmentTreeAction.setElementsProvider(new ModelElementsProvider()
            {
                @Nonnull
                @Override
                public List<Element> getElements()
                {
                    return dependency.getCause();
                }
            });
            navigateCategory.addAction(selectInContainmentTreeAction);
        }
    }

    @Nonnull
    @Override
    public Map<Class<? extends Element>, Collection<SmartListenerConfig>> getListenerConfigurations()
    {
        return mSmartListenerConfiguration;

    }

    /**
     * Creates smart listener configurations for each selected row/column type
     *
     * @param configuredType row/column element type collection
     * @return new smart listener configuration
     */
    private Map<Class<? extends Element>, Collection<SmartListenerConfig>> createSmartListenerConfiguration(
            Collection<Element> configuredType)
    {
        Map<Class<? extends Element>, Collection<SmartListenerConfig>> listenerMap = new HashMap<>(
                configuredType.size());
        //Add smart listeners to update matrix dependencies when client or supplier dependencies are changed
        SmartListenerConfig config = new SmartListenerConfig();
        config.listenTo(PropertyNames.CLIENT_DEPENDENCY);
        config.listenTo(PropertyNames.SUPPLIER_DEPENDENCY);
        Collection<SmartListenerConfig> configs = Collections.singleton(config);
        for (Element selectedType : configuredType)
        {
            if (selectedType instanceof NamedElement)
            {
                NamedElement type = (Classifier) selectedType;
                listenerMap.put(ClassTypes.getClassType(type.getName()), configs);
            }
        }
        return listenerMap;
    }

    @Override
    public void elementUpdated(Collection<Element> element)
    {
    }

    @Override
    public void clear()
    {
    }
}
