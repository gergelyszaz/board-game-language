package com.github.gergelyszaz.bgl.manager;

import com.google.inject.Injector;
import com.github.gergelyszaz.bgl.BoardGameLanguageStandaloneSetup;
import com.github.gergelyszaz.bgl.bgl.Model;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.resource.XtextResourceSet;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class ModelManager {
	private static XtextResourceSet resourceSet;

	public ModelManager() {
		new org.eclipse.emf.mwe.utils.StandaloneSetup().setPlatformUri("../");
		Injector injector =
				new BoardGameLanguageStandaloneSetup().createInjectorAndDoEMFRegistration();
		resourceSet = injector.getInstance(XtextResourceSet.class);
		resourceSet.addLoadOption(XtextResource.OPTION_RESOLVE_ALL, Boolean.TRUE);
	}

	private int numberOfGames = 0;
	private Hashtable<String, Model> models = new Hashtable<String, Model>();

	public List<String> AvailableModels() {
		List<String> availableModels = new ArrayList<String>();
		for (Model m : models.values()) {
			availableModels.add(m.getName());
		}
		return availableModels;
	}

	public Model LoadModel(String gameString) throws Exception {
		InputStream in = new ByteArrayInputStream(gameString.getBytes());
		return LoadModel(in);
	}

	public Model LoadModel(InputStream stream) throws Exception {
		Resource resource =
				resourceSet.createResource(URI.createURI("dummy:/" + numberOfGames++ + ".bgl"));
		resource.load(stream, resourceSet.getLoadOptions());
		Model model = (Model) resource.getContents().get(0);
		if (models.contains(model.getName()))
			throw new Exception("Language with this name already loaded.");
		models.put(model.getName(), model);
		return model;
	}

	public Model Get(String name) throws Exception {
		Model m = models.get(name);
		if (m == null)
			throw new Exception("Game " + name + " not found!");
		return m;

	}

}
