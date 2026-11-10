importPackage (javax.swing)
importClass (java.lang.StringBuffer)

/**
 * Get a qualified package name of element. If given element does not have a qualified name, the method returns the default name argument.
 * @param element the MagicDraw element
 * @param a default name
 */
var qualifiedName;
function packageQualifiedName(element, defaultName)
{
	qualifiedName = "";
	packageName(element);
	return qualifiedName==""?defaultName:qualifiedName;
}
/**
 * Recursive method to collect a qualified name from package.
 */
function packageName(element)
{
	var parent = element.owner;
	if (parent.classType.simpleName == 'Package' || parent.classType.simpleName == 'SmartPackage') {
		if (qualifiedName == "")
			qualifiedName = parent.name;
		else
			qualifiedName = parent.name + '.' + qualifiedName;
		packageName(parent);
	}
}

/**
 * Print all packages name in selected scope to MagicDraw console view
 */
function printPackageNames() {
   var packages = $array.createArray();
   try
   {
   		$array.addCollection(packages, $Package);
   }
   catch(error)
   {
  	
   }
   try
   {
     	$array.addCollection(packages, $SmartPackage);
   }
   catch(error)
   {
	
   }
   var sortedPackage = $sorter.sort(packages);
   for (var i=0; i<sortedPackage.size(); i++) {
	   var pack = sortedPackage.get(i);
	   out.write(pack.getName());
	}
}

/**
 * Display a hello message using String JOptionPane.
 * @param name a name to says hello
 */
function saysHello(name) {
   var buffer = new StringBuffer();
	buffer.append("Hello ").append(name);
	JOptionPane.showMessageDialog(null, buffer.toString());
}