"
This is a version based on the port made by hernan morales of Bruce Samuelson's TreeLW implementation. An article on the Tree class hierarchy appeared in the October 1993 issue of The Smalltalk Report.

This version differs from the one of Hernan Morales in the following way. 
- Cleaning pass on class names
- Cleaning tests such as using strings instead of empty block with comments. 


'LW' suffix in class name is explained under 'Naming conventions' below.

Changes from version 1.0: Increase the flexibility of the tree inheritance hierarchy and the possibilities for subclassing it by making TreeLW an abstract class and making all instance variables optional. 

There are now more combinations of possible instance variables and therefore more subclasses. Update the test suite to relect these changes.

Copyright (c) 1993 by Bruce Samuelson. 
Released to the public domain. 
Permission is granted to place this in Smalltalk archives such as Illinois, Manchester, and ParcBench. 
This port is was done and tested with Squeak 3.9

The Monticello package includes the following material:

	13 tree classes: TreeLW and 12 subclasses
	13 testing subclasses containing test suites for the 13 tree classes	supporting methods added to Squeak classes.
	1 class adapted for working with SUnit.

The filein represents work in progress. If you use it, send bug reports, suggestions, modifications, and additions to bruce@utafll.uta.edu (uta eff ell ell) or bruce@ling.uta.edu. If you modify it, please document who wrote which part.

Naming conventions: I am using this distasteful scheme until Smalltalk supports better name space partitioning. 
	
	(2) Method names: When I add a utility method to a standard ParcPlace class such as Object or String, I add the 'LW' suffix to its name for the same reason. Exceptions are methods that need to be used polymorphically with ParcPlace methods, methods with binary selectors, and those which for aesthetic reasons would be too ugly with this suffix. 
	(3) Protocol names: When I add a utility method to a ParcPlace class, I put the method in a protocol with an 'lw' prefix (usually 'lw extensions'). This distinguishes it from ParcPlace methods. Although my browser includes tools for supporting these naming conventions, the fileout does not include the browser tools.

You'll get a list of the 'lw...' protocols when you file in the code. Keep track of this list for future reference. Next time you build a new image, you'll need to file out these protocols. The classes containing these new protocols are: Array, Character, Collection, InternalStream, Object, OrderedCollection class, OrderedCollection, PositionableStream, SequenceableCollection class, SequenceableCollection, Set, SortedCollection, String class, String.

(B) NORMAL CLASS COMMENTS

CTTree is an abstract class with no instance variables. It represents a hierarchical structure whose intermediate nodes are called branches and whose terminal nodes are called leaves.

TreeLW forms the root of an inheritance hierarchy for several tree classes. They are application neutral and are analogous to the upper levels of the Collection hierarchy. The design goal is that they be robust and flexible enough to be reusable in a range of applications, either directly or as anchors for application specific subclasses, and that they be reasonably efficient in space and time.

The strategies for achieving this goal are to (1) offer Tester classes that validate the methods in the tree classes, (2) validate selected arguments passed by clients of tree services, (3) place support for each service at the highest possible level in the inheritance hierarchy, (4) maximize polymorphic use of services, (5) minimize code duplication, (6) introduce instance variables at the lowest possible level in the hierarchy, (7) minimize direct access to instance variables, and (8) offer flexibility in the way subtrees are represented.

Most of these strategies are object oriented versions of motherhood and apple pie. However, it takes some discipline to apply them to the design of tree classes. Trees as conceived here are most naturally represented by multiple inheritance while Pharo only supports single inheritance. Let's consider each strategy in turn.

(1) Class validation suite

TreeLW and its subclasses can be validated by using the Squeak Test Tunner.

(2) Argument validation

When a tree client sends a message that creates or modifies a tree, its arguments get validated by methods in the 'private validating' protocol. These catch most errors before they can cause trouble and provide a clearer explanation of the error than would be possible if it went undetected until later in the processing. Although the performance penalty is relatively modest, application subclasses may override the validations with no-ops if they need to minimize the penalty.

(3-5) High level, polymorphic services with minimal code duplication

Most methods are defined in TreeLW itself and do not need to be redefined by subclasses. This minimizes code duplication. An example is the definition of a tree's root. If the tree maintains a superTree pointer, the root is obtained by following the pointer chain to the top node. If the tree does not maintain the pointer, it is by definition its own root node. It is not necessary to maintain one set of code for tree subclasses that define the pointer and another set for classes that do not.

Another example of services implemented at the top of the inheritance hierarchy is subTrees processing. SubTrees are accessed from a message send rather than from an instance variable. This enables support for services such as the traditional enumerating methods offered by collections. All that is required is that each tree class be able to respond to the subTrees selector.

Some instance variables, such as the superTree pointer and value variable, are introduced several times by different subclasses in the inheritance hierarchy. The only code that must be duplicated among these classes is the basic read and write methods in the 'private accessing' protocol. Other instance variables such as 'subTrees' and 'key' introduce considerable functionality and need many methods to support their semantics. The inheritance hierarchy is arranged so that each of these is introduced in only one subclass. Their supporting methods therefore do not need to be duplicated in other subclasses.

(6-7) Introduction of and access to instance variables

These are introduced into the tree classes as follows. The classes marked as concrete/abstract can/cannot be instantiated because they do/do not define how to access subtrees or how to distinguish leaves from branches.

TreeLW ()   ""abstract""
	PTreeLW ('superTree')   ""abstract""
		PVTreeLW ('value')   ""abstract""
	STreeLW ('subTrees')   ""concrete""
		SKTreeLW ('key')   ""concrete""
			SKPTreeLW ('superTree')   ""concrete""
				SKPVTreeLW ('value')   ""concrete""
			SKVTreeLW ('value')   ""concrete""
		SPTreeLW ('superTree')   ""concrete""
			SPVTreeLW ('value')   ""concrete""
		SVTreeLW ('value')   ""concrete""
	VTreeLW ('value')   ""abstract""
		BinaryTreeLW ('left' 'right')   ""concrete: defined for pedagogical purposes only""

Naming Convention

Prepend the first letter of each variable's name to TreeLW. 'P' designates superTree since 'S' is already used to designate subTrees.

SubTrees and key are introduced in one class each, superTree in three classes, and value in six classes. Each is only introduced when needed, and all possible combinations are available for defining application specific subclasses. The exception is that there are no classes defining a key without subTrees because it would make no sense. The reason will become clear below.

Nil may not be stored in these variables. It is a reserved value returned by accessor methods to indicate that an instance variable has not been defined. For example, if superTree (has/has not) been defined, its accessor method will return a (non-nil/nil) value.

Here's an explanation of the instance variables introduced by tree subclasses.

superTree

Trees that need to maintain pointers to their parent nodes do so by defining a superTree variable. Because this pointer is maintained automatically, there is no public method for setting it. Trees not needing this pointer do not define it. This saves the memory occupied by an instance variable. More significantly, when there is no superTree pointer, a single instance can be attached to and shared by several supertrees. This can save substantial memory in applications that have large numbers of trees with common substructure.

subTrees

This is a collection holding the immediate descendants of a node in the tree. Any hierarchical data structure must have a way to represent descendant nodes. In our scheme, a concrete tree class must either define subTrees as an explicit instance variable, or it must define other variables which serve the same purpose. BinaryTreeLW is an example of this alternate definition. Its class comment explains how it works. Classes not defining a subTrees variable or its equivalent are abstract. Subtrees are explained further in the next numbered section.

key, value

Data may be stored at a tree node in a key or a value. Key is used when the data is unique. It is analogous to a dictionary key in Smalltalk or to a unique key in a database. It forms the basis for traversing the tree. Value is used when the data is not unique and will not be used for traversal. A tree representing a file system is an example of a key based tree. Directories are branches and files are leaves. Within a directory, the name if each file and subdirectory is unique. These names can be used as keys. An example of a value based tree would be a parse tree representing the noun phrase 'a cold juicy apple.' The values stored in its subTrees are lexical categories (article adjective adjective noun) and are not unique. It is also possible to define a tree class with both a key and a value. In representing a file system, the key could be the file's name and the value its contents or attributes.

If an application uses trees with keys, i.e., SKTreeLW or a subclass, it is responsible for maintaining the keys' uniqueness. Although SKTreeLW could be made to enforce it, there would be a performance penalty. The next section explains different ways to store subTrees. If the application uses a sequenceable collection, it must guarantee keys' uniqueness. If it uses a set, uniqueness will be automatically guaranteed. In the comparison protocol for SKTreeLW, equality, precedence, and hash are based on the key alone. Subclasses should not redefine these to depend on other variables.

(8) Flexible representation of subtrees

Any scheme for defining a tree needs some way to represent its descendants. Two techniques are available. One may define either application specific instance variables holding the descendants or a subTrees variable holding an explicit collection. The first technique is illustrated in the BinaryTreeLW class, which is defined solely for illustrative purposes. The second technique is used in STreeLW and its subclasses.

A novel feature of STreeLW is that the client application may choose what kind of collection to use for holding subtrees. For STreeLW, some sequenceable collections are allowed. For SKTreeLW, Sets are also available. Browse implementors of validateSubTreesClass: for details. This method gives guidelines if you wish to create a new kind of collection class for holding subTrees.

In most applications, all the nodes in a tree will use the same kind of collection for storing subtrees, but this is not required. For example, it is possible for some nodes to use an ordered collection and for others to use a set. Highlight and inspect this legal code: ""| t1 t2 | t1 := SKTreeLW key: 1 subTrees: OrderedCollection. t2 := SKTreeLW key: 2 subTrees: Set. t1 add: t2. t1"".

It is also possible to mix instances of different tree classes. To be compatible they must both define a superTree pointer or both not define it. Highlight and inspect this legal code: ""| t1 t2 | t1 := STreeLW new. t2 := SKTreeLW key: 2. t1 add: t2. t1"". Highlight and evaluate this illegal code: ""| t1 t2 | t1 := SPTreeLW new. t2 := SKTreeLW key: 2. t1 add: t2. t1"".There is protocol for converting from one subtrees collection class to another and from one tree class to another.

Choosing a collection class may preclude the use of some methods in the accessing protocol. Trees built with sets cannot use atIndex: and atIndex:put:. Trees built with sorted collections cannot use atIndex:put:. Otherwise there are no restrictions. Trees built with arrays can use the adding and removing protocol even though arrays normally cannot.

By supporting a variety of collection classes for subtrees, STreeLW makes a typical Smalltalk tradeoff of increased flexibility at the expense of slightly decreased safety. This may offend the sensibilities of programmers who like strong typing.

Clients of a tree may communicate with its subtrees. For example,

	| tree subs last |
	tree := (some code defining a tree).
	subs := tree subTrees.
	last := subs last.

Two warnings must be heeded when doing this: (1) The collection must be able to understand the message. For example, <Array last> makes sense but <Set last> does not. (2) Access messages that read from the collection, such as <subs last>, are acceptable. Access messages that write to it, such as <subs add:> are not, since this would bypass TreeLW's validation and pointer management mechanisms.

TreeLW subclasses must provide a means to distinguish branch nodes from leaf nodes. STreeLW bases the distinction on the contents of the subTrees variable. Branches use a collection instance and leaves use a collection class. This technique has two advantages over representing leaves by an empty collection. It is more space efficient and it allows a branch to hold zero subtrees. This is analogous to an empty directory in a file system. The technique's advantage over defining new classes to represent leaves is that it avoids a major proliferation of the class hierarchy.

(*) Final comments and warnings
 
Trees may not be cyclic, i.e., you may not store a tree as a direct or recursive subtree of itself. Clients of TreeLW are responsible for observing this constraint. If they do not, infinite recursion will occur for many operations. It would impact performance too much for TreeLW to enforce it.

Subclasses that add instance variables to TreeLW other than those listed below may need to redefine <TreeLW basicCopy:>. This is somewhat like redefining copyEmpty: for new collection subclasses.

Class Variables
=================
several		<Signal>	There are several signals that get raised on error conditions.

Instance Variables introduced by subclasses (nil values are illegal as explained above)

subTrees	<Coll of trees		A collection instance (possibly empty) is used for a branch node.
			or Coll class>		A collection class is used for a leaf node.
superTree	<TreeLW | nontree>	A non tree value marks a root node.
key			<Object>			Unique data stored at node; used for traversing tree.
value		<Object>			Non unique data stored at node. May be used to supplement key.
"
Class {
	#name : #CTTree,
	#superclass : #Object,
	#category : #'Trees-Main'
}

{ #category : #'signal constants' }
CTTree class >> badKeySignal [
	
	^TreeLWBadKey signal:  'The key is illegal.'
]

{ #category : #'signal constants' }
CTTree class >> badPathSignal [
	
	^TreeLWBadPath signal:  'Path is inaccessable.'
]

{ #category : #'signal constants' }
CTTree class >> badSubTreesSignal [
	
	^TreeLWBadSubTrees signal: 'The subtrees specification is illegal.'
]

{ #category : #'signal constants' }
CTTree class >> badValueSignal [
	
	^TreeLWBadValue signal: 'The value is illegal.'
]

{ #category : #examples }
CTTree class >> example0 [
	"Many examples of how to use this class, and how to avoid misusing it, are in the 
	test suites located in TesterTreeLW and its sister classes."
]

{ #category : #examples }
CTTree class >> example1 [
	"Return a tree containing an organizational chart."
	
	"SKTreeLW example1"
	"SVTreeLW example1"
	"SKVTreeLW example1"

	| t1 t2 t3 t4 t5 |
	
	t1 := self key: 'president' value: 'Bill'.
	t2 := self key: 'secy of state' value: 'Warren'.
	t3 := self key: 'secy of defense' value: 'Les'.
	t4 := self key: 'under secy for Africa' value: 'Lino'.
	t5 := self key: 'under secy for Latin America' value: 'Manuel'.
	t1 add: t2; add: t3.
	t2 add: t4; add: t5.
	^t1
]

{ #category : #examples }
CTTree class >> example2 [
	"Return a tree containing a toy hierarchical database."
	"SKTreeLW example2"
	"SVTreeLW example2"
	"SKVTreeLW example2"

	| t1 t2 t3 t4 t5 t6 t7 t8 t9 |
	
	t1 := self key: 'cultures'.
	t2 := self key: 'Sudanese Arabic'.
	t3 := self key: 'lexicon' value: #('ana: 1p s' 'shy: tea').
	t4 := self key: 'grammar (hypothetical)' value: #('s = np vp' 'np = art n' 'vp = aux v' ).
	t5 := self key: 'anthropology' value: 'Sudanese Arabs like their tea very sweet.'.
	t6 := self key: 'Didinga'.
	t7 := self key: 'lexicon' value: #('theythatch: termites' 'yani: that is (loan from Arabic)' ).
	t8 := self key: 'grammar (hypothetical)' value: #('s = np vp' 'np = adj n' 'vp = mod v' ).
	t9 := self key: 'anthropology' value: 'The Didinga people live in SE Sudan.'.
	t1 add: t2; 
		add: t6.
	t2 add: t3; 
		add: t4; 
		add: t5.
	t6 add: t7; 
		add: t8; 
		add: t9.
	^t1
]

{ #category : #examples }
CTTree class >> example3: aCollectionClass [ 
	"Return a sample tree using aCollectionClass to store subtrees. This method
	is used by some methods in the test suite. Do not change it, since the test
	methods depend on the details of the tree it generates."

	"SKVTreeLW example3: OrderedCollection"
	"SKVTreeLW example3: Array"
	"SKVTreeLW example3: Set"
	"SKVTreeLW example3: SortedCollection"

	| cl t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 |
	
	cl := aCollectionClass.
	t1 := self key: 1 value: $a subTrees: cl.
	t2 := self key: 2 value: $b subTrees: cl.
	t3 := self key: 3 value: $c subTrees: cl.
	t4 := self key: 4 value: $d subTrees: cl.
	t5 := self key: 5 value: $e subTrees: cl.
	t6 := self key: 6 value: $f subTrees: cl.
	t7 := self key: 7 value: $g subTrees: cl new.	
	"An empty branch node."
	t8 := self key: 8 value: $h subTrees: cl.
	t9 := self key: 9 value: $i subTrees: cl.
	t10 := self key: 10 value: $j subTrees: cl.
	t11 := self key: 11 value: $k subTrees: cl.
	t12 := (self key: 12 value: $l subTrees: cl) makeBranch. 
	"Another way of creating an empty branch node."
	t13 := self key: 13 value: $m subTrees: cl.
	t1 add: t2; add: t6; add: t7; add: t8.
	t2 add: t3; add: t4; add: t5.
	t8 add: t9; add: t10.
	t10 add: t11; add: t13.
	t11 add: t12.
	^t1
]

{ #category : #examples }
CTTree class >> example4: aCollectionClass [ 
	"This is a pared down version of example3:. Do not change it.
	See example3: for comments."

	"SKVTreeLW example4: OrderedCollection"
	"SKVTreeLW example4: Array"
	"SKVTreeLW example4: Set"
	"SKVTreeLW example4: SortedCollection"

	| t1 t2 t3 t4 t5 t6 |

	t1 := self key: 1 value: $a subTrees: aCollectionClass.
	t2 := self key: 2 value: $b subTrees: aCollectionClass.
	t3 := self key: 3 value: $c subTrees: aCollectionClass.
	t4 := self key: 4 value: $d subTrees: aCollectionClass.
	t5 := self key: 5 value: $e subTrees: aCollectionClass.
	t6 := self key: 6 value: $f subTrees: aCollectionClass.
	t1 add: t2; add: t6.
	t2 add: t3; add: t4; add: t5.
	^t1
	
]

{ #category : #examples }
CTTree class >> example5 [
	"Return a tree (sometimes called a trie) whose paths are the characters in 
	words. Data comes from an old Unix version of /usr/dict/words. Printing 
	protocol has not been designed to display this application optimally."
	"SKTreeLW example5"
	"SKVTreeLW example5"

	| t |
	t := self key: $* subTrees: OrderedCollection.
	#('a' 'aback' 'abacus' 'abalone' 'abandon' 'abase' 'abash' 'abate' 'abater' 'abbas' 'abbe' 'abbey' 'abbot' 'abbreviate' ) do: [:word | (t addPath: word) value value: $#].
	^t
]

{ #category : #examples }
CTTree class >> example6 [
	"Return a tree illustrating how the nodes may be of various tree types and how
	the subtrees collections may be of various collection types."

	"TreeLW example6"

	| t u v |
	t := CTSubtreedTree key: 1 subTrees: Array.
	u := CTSubtreedtKeyedTree key: 2 subTrees: Set.
	v := CTUnparentedValuedTree key: 3 value: 33 subTrees: SortedCollection.
	t add: u; add: v.
	^t
]

{ #category : #examples }
CTTree class >> example7 [
	"See also the example for BinaryTreeLW."
	"BinaryTreeLW example"
]

{ #category : #'signal constants' }
CTTree class >> incompatibleTreeSignal [
	
	^TreeLWIncompatibleTree signal: 'Attempt to connect incompatible trees.'
]

{ #category : #'class initialization' }
CTTree class >> initialize [

]

{ #category : #'instance creation' }
CTTree class >> key: aKey [ 
	"Create and return a new instance whose key, if defined by the receiver, is aKey. 
	The argument may typically be any object except nil. The instance method 
	validateKey: explains this."

	^self new key: aKey
]

{ #category : #'instance creation' }
CTTree class >> key: aKey subTrees: subTreesColl [
	"Create and return a new instance whose key, if defined by the receiver, and 
	whose subTrees are as specified."

	^(self new) key: aKey; subTrees: subTreesColl
]

{ #category : #'instance creation' }
CTTree class >> key: aKey value: aValue [ 
	"Create and return a new instance whose key and value, if defined by the receiver, 
	are as specified."

	^(self new) key: aKey; value: aValue
]

{ #category : #'instance creation' }
CTTree class >> key: aKey value: aValue subTrees: subTreesColl [ 
	"Create and return a new instance whose key and value, if defined by the 
	receiver, and whose subTrees are as specified."

	^(self new) key: aKey; 
			value: aValue; 
		subTrees: subTreesColl
]

{ #category : #'signal constants' }
CTTree class >> keyNotFoundSignal [
	
	^ TreeLWKeyNotFound signal: 'Key not found.'
]

{ #category : #'instance creation' }
CTTree class >> new [
	"Return a new instance of the receiver with default values for its instance variables."

	^super new initialize
]

{ #category : #'signal constants' }
CTTree class >> notATreeSignal [
	
	^TreeLWNotATree signal: 'Expecting a tree.'
]

{ #category : #'instance creation' }
CTTree class >> subTrees: subTreesColl [ 
	"Create and return a new instance whose subTrees is subTreesColl. The instance 
	methods basicSubTrees: and validateSubTrees: explain the argument."

	^self new subTrees: subTreesColl
]

{ #category : #'signal constants' }
CTTree class >> treeNotFoundSignal [
	
	^TreeLWTreeNotFound signal: 'Tree not found.'
]

{ #category : #'instance creation' }
CTTree class >> value: aValue [
	"Create and return a new instance whose value, if defined by the receiver, is aValue.
	The argument may typically be any object except nil. The instance method 
	validateValue: explains this."

	^self new value: aValue
]

{ #category : #'instance creation' }
CTTree class >> value: aValue subTrees: subTreesColl [ 
	"Create and return a new instance whose value, if defined by the receiver, and 
	whose subTrees are as specified."

	^(self new) value: aValue; subTrees: subTreesColl
]

{ #category : #comparing }
CTTree >> = aTree [ 
	"Answer whether the receiver is equal to aTree. 
	
	This method is defined here solely to provide the following comments. 
	It is needed to support some includes: messages and, for subclasses storing 
	subTrees, some remove: messages. Consider redefining it. Subclasses storing 
	a key define it to support keyed access to their subTrees."

	^super = aTree
]

{ #category : #converting }
CTTree >> as: treeClass [ 
	"Return a recursive copy of the receiver which has been converted to be an 
	instance of treeClass and whose direct and recursive subTrees remain 
	instances of their original tree classes.

	Implementation note: We cannot use changeClassToThatOf: because the
	conversion may reduce the number of instance variables. Also, we do not
	want to change the receiver.
	
	WARNING: to convert between incompatible tree types, use recursiveAs:,
	not as:. 
	The validateTree: method tests for incompatibility."

	| newTree |

	self validateTreeClass: treeClass.
	newTree := self basicCopy: treeClass.
	self validateTree: newTree.	
	"Protects against mixing incompatible trees."
	self isBranch 
		ifTrue: [newTree fastSubTrees: (self subTrees collectLW: [:tree | tree recursiveCopy])].
	^newTree
]

{ #category : #'private misc' }
CTTree >> attachTo: aTree [ 
	"Set the superTree of the receiver, if it defines one, to aTree. Clients of this 
	method are responsible for doing integrity checking."

	self basicSuperTree: aTree
]

{ #category : #'private misc' }
CTTree >> basicCopy: treeClass [ 
	
	"Return a new instance of treeClass which shares the instance variables of the 
	receiver. If it defines a superTree pointer, make it a root node. Clients are 
	responsible for validating treeClass. This method is similar to shallowCopy. It
	cannot use changeClassToThatOf: because the new class may contain fewer
	instance variables.

	WARNING: subclasses may need to redefine this method if they add instance 
	variables other than the ones assigned below.

	Comment: subclasses that need for some instance variables to be copied
	when they build trees using this method may also redefine it."

	^(treeClass basicNew)
		basicKey: self basicKey;
		basicValue: self basicValue;
		basicSubTrees: self basicSubTrees;
		makeRoot
]

{ #category : #'private accessing' }
CTTree >> basicKey [
	
	"Return the key if it is defined or nil otherwise."

	

	^nil
]

{ #category : #'private accessing' }
CTTree >> basicKey: aKey [
	"If the receiver defines key, set it. Return the receiver."
]

{ #category : #'private accessing' }
CTTree >> basicSubTrees [
	"Return the subTrees. 

	This method must be implemented by subclasses. Those defining a subTrees 
	variable will return it, possibly after doing some processing on it. Those not 
	defining the variable will typically return an array containing those instance 
	variables which store tree nodes. For example, a binary tree with <left> and 
	<right> variables could implement it as ^<Array with: left with: right>."
	

	self subclassResponsibility
]

{ #category : #'private accessing' }
CTTree >> basicSubTrees: subTreesColl [ 
	"Set the subTrees to the argument and return the receiver. 

	This method must be implemented by subclasses. Those defining a subTrees 
	variable will set it to subTreesColl. Those not defining the variable will set those 
	instance variables that can store tree nodes to the elements of subTreesColl. 

	For example, a binary tree with <left> and <right> variables could implement it 
	roughly as self left: (subTreesColl at: 1); right: (subTreesColl at: 2). See
	implementors for details.
	
	The criteria that subTreesColl must satisfy depend on which TreeLW subclass
	implements the method:
	
	1) If the tree subclass does not define a subTrees variable, the argument must 
	be an instance of a sequenceable collection subclass whose size equals the 
	number of instance variables storing tree nodes (for branches) or zero (for
	leaves). In the example above for BinaryTreeLW, the size is two.
	
	2) If the tree subclass defines a subTrees variable but no key variable, the 
	argument must be a sequenceable collection subclass or an instance of such a 
	subclass. For example, it may be the Array class or an Array instance holding 
	three trees. 
	
	3) If the tree subclass defines both a subTrees variable and key variable, the 
	same restrictions apply as in (2) except that both sequenceable and non 
	sequenceable collections are allowed. 

	4) We do not support tree subclasses defining a key variable without a subTrees 
	variable. A key makes no sense in the absence of subTrees.
	
	5) Details of exactly which collection classes are legal in which circumstance 
	may be obtained by browsing implementors of validateSubTreesClass:."

	self subclassResponsibility
]

{ #category : #'private accessing' }
CTTree >> basicSuperTree [
	"Return the superTree if it is defined or nil otherwise."

	^nil
]

{ #category : #'private accessing' }
CTTree >> basicSuperTree: aTree [
	"If the receiver defines superTree, set it. Return the receiver."
]

{ #category : #'private accessing' }
CTTree >> basicValue [
	"Return the value if it is defined or nil otherwise."

	^nil
]

{ #category : #'private accessing' }
CTTree >> basicValue: aValue [
	
	"If the receiver defines value, set it. Return the receiver."
]

{ #category : #'testing misc' }
CTTree >> belongsTo: aTree [ 
	
	"Return a boolean indicating whether aTree is the direct parent of 
	
	the receiver."

	

	^self superTree == aTree
]

{ #category : #'private printing' }
CTTree >> branchMarker [
	"Return the character which marks a branch node when printed."

	^self separator
]

{ #category : #enumerating }
CTTree >> collectLW: aBlock [ 
	"This comment could be somewhat outdated"
	
	"Return a recursive copy of the receiver whose direct subtrees have been 
	transformed by evaluating aBlock on them. If the receiver is a leaf node, return 
	a recursive copy of it. The method is named collectLW: because the PPS 
	version 4.1 implementation of collect: is slightly flawed."

	| newTree |

	newTree := self recursiveCopy.
	self isBranch 
		ifTrue: [newTree subTrees: (newTree subTrees collectLW: aBlock)].
	^newTree
]

{ #category : #copying }
CTTree >> copy [
	"Return a copy of the receiver which shares no direct or recursive subtrees with it."

	^self recursiveCopy
]

{ #category : #'private initializing' }
CTTree >> defaultKey [
	
	"Return the default value for initializing the key."

	

	^#UndefinedKey
]

{ #category : #'private initializing' }
CTTree >> defaultSubTrees [
	"Return the default value for initializing the subTrees."

	self subclassResponsibility
]

{ #category : #'private initializing' }
CTTree >> defaultSuperTree [
	
	"Return the default value for initializing the superTree."

	

	^#none
]

{ #category : #'private initializing' }
CTTree >> defaultValue [
	
	"Return the default value for initializing the value."

	

	^#UndefinedValue
]

{ #category : #'testing simple' }
CTTree >> definesKey [
	"Does the receiver define a key?"

	^self basicKey notNil
]

{ #category : #'testing simple' }
CTTree >> definesSubTrees [
	"Does the receiver define subTrees? This method documents the requirement 
	that subclasses must implement the basicSubTrees method. There is no reason 
	for there to be any senders of definesSubTrees."

	^true
]

{ #category : #'testing simple' }
CTTree >> definesSuperTree [
	"Does the receiver define a superTree?"

	^self basicSuperTree notNil
]

{ #category : #'testing simple' }
CTTree >> definesValue [
	"Does the receiver define a value?"

	^self basicValue notNil
]

{ #category : #enumerating }
CTTree >> detectLW: aBlock [ 
	"Return the first direct subtree of the receiver for which aBlock evaluates to 
	true, or nil otherwise.The method is not named detect:, because that signals an 
	error where we want to return nil."

	^self subTrees detectLW: aBlock
]

{ #category : #enumerating }
CTTree >> do: aBlock [ 
	"Evaluate aBlock on the direct subTrees of the receiver. 
	Return the receiver."

	self subTrees do: aBlock
]

{ #category : #enumerating }
CTTree >> do: aBlock inclusive: boolean1 reOrder: boolean2 [ 
	"Evaluate aBlock on the receiver (if boolean1 is true) and on its direct subTrees. 
	In addition, if boolean2 is true, make sure the subTrees are properly ordered. 
	See TreeLW>>reOrderLW for explanation. Return the receiver."

	boolean1 
		ifTrue: [aBlock value: self].
	self do: aBlock.
	boolean2 
		ifTrue: [self reOrderLW]
]

{ #category : #'private misc' }
CTTree >> fastSubTrees: subTreesColl [ 
	"Set the subTrees of the receiver to subTreesColl and answer the receiver. This 
	method is optimized for speed by omitting some work done by the subTrees: 
	method. It avoids validation and avoids converting the old subTrees into root 
	nodes."

	self basicSubTrees: subTreesColl.
	self definesSuperTree 
		ifTrue: [self do: [:tree | tree attachTo: self]]
]

{ #category : #'accessing misc' }
CTTree >> fullPathNodes [
	"Return an array containing nodes from the root to the receiver, inclusive of 
	both. If the receiver is a root node, the array will contain the receiver as its 
	single element."

	^self isRoot
		ifTrue: [Array with: self]
		ifFalse: [self superTree fullPathNodes copyWith: self]
]

{ #category : #'testing misc' }
CTTree >> hasSubTrees [
	"Return a boolean indicating whether the receiver has at least one subtree."

	^self subTrees size > 0
]

{ #category : #'testing misc' }
CTTree >> includes: aTree [ 
	
	"Return a boolean indicating whether aTree is a direct subtree of the receiver. 
	
	Clients using this method must be satisfied with the definition of the equality 
	test (=)"

	

	^self subTrees includes: aTree
]

{ #category : #'testing misc' }
CTTree >> includesTreeSatisfying: aBlock [ 
	
	"Return a boolean indicating whether the receiver includes at least one direct 
	
	subtree satisfying aBlock."

	

	^(self detectLW: [:tree | aBlock value: tree]) notNil
]

{ #category : #enumerating }
CTTree >> inclusiveDo: aBlock [ 
	"Evaluate aBlock on the receiver and on its direct subTrees. 
	Return the receiver."

	aBlock value: self.
	self do: aBlock
]

{ #category : #'private printing' }
CTTree >> indentUnit [
	"Return a string to use for horizontally indenting tree nodes."

	^ '. . .	'
]

{ #category : #'private initializing' }
CTTree >> initialize [
	
	"Initialize and return the receiver. Nil values may not be used. They are reserved 
	
	for determining which instance variables have been defined. See the defines... 
	
	suite of messages."

	

	self basicKey: self defaultKey.
	
	self basicValue: self defaultValue.
	
	self basicSubTrees: self defaultSubTrees.
	
	self basicSuperTree: self defaultSuperTree
]

{ #category : #'testing misc' }
CTTree >> isBranch [
	
	"Return a boolean indicating whether the receiver is a branch node."

	

	^self isLeaf not
]

{ #category : #'testing misc' }
CTTree >> isLeaf [
	"Return a boolean indicating whether the receiver is a leaf node."

	self subclassResponsibility
]

{ #category : #'testing misc' }
CTTree >> isProductive [
	
	"Return a boolean indicating whether the receiver is a leaf or includes a leaf in its 
	
	direct or recursive subtrees."

	

	^self isLeaf or: [self recursiveIncludesTreeSatisfying: [:tree | tree isLeaf]]
]

{ #category : #'testing misc' }
CTTree >> isRoot [
	
	"Is the receiver a root node? In our scheme a tree is a root node if it does not 
	
	define a superTree pointer or if the pointer it defines stores a non tree object."

	

	^self superTree isTreeLW not
]

{ #category : #'testing misc' }
CTTree >> isTreeLW [
	
	"Return a boolean indicating whether the receiver is a tree. The method name 
	
	includes the LW suffix because it is also defined in Object."

	

	^true
]

{ #category : #'accessing simple' }
CTTree >> key [
	
	"Return the key if it is defined or nil otherwise."

	

	^self basicKey
]

{ #category : #'accessing simple' }
CTTree >> key: aKey [
	"Validate the argument and, if the receiver defines a key, set it. Return the receiver."

	self validateKey: aKey.
	self basicKey: aKey
]

{ #category : #'private printing' }
CTTree >> keyValueSeparator [
	"Return the separator to insert between the key and value, if any are defined, 
	when printing the receiver."

	^ ': '
]

{ #category : #'private misc' }
CTTree >> makeRoot [
	
	"Make the receiver a root node and return it. Clients of this method are 
	
	responsible for removing the receiver from its superTree if it has one."

	

	self basicSuperTree: self defaultSuperTree
]

{ #category : #'private printing' }
CTTree >> nodeName [
	"Return the default designation for a node when there is no suitable key or value 
	to print."

	^ 'node'
]

{ #category : #'private printing' }
CTTree >> nodePrintString [
	"Return a string representing a tree node. Subclasses not defining either a key or 
	a value may want to redefine this."

	| stream |

	stream := (String new: 32) writeStream.
	(self definesKey and: [self key ~= self defaultKey])
		ifTrue: [self key printSimplyOnLW: stream].
	(self definesValue and: [self value ~= self defaultValue])
		ifTrue: [stream isEmpty 
					ifFalse: [self keyValueSeparator printSimplyOnLW: stream].
				self value printSimplyOnLW: stream].
	stream isEmpty 
		ifTrue: [self nodeName printSimplyOnLW: stream].
	self isBranch 
		ifTrue: [| bm |
				stream last ~= (bm := self branchMarker) 
					ifTrue: [stream nextPut: bm]].
	^stream contents
]

{ #category : #'printing simple' }
CTTree >> printOn: aStream [ 
	"Print a hierarchical representation of the receiver on aStream."

	^self printTree: self with: String new on: aStream
	

]

{ #category : #'printing simple' }
CTTree >> printTree: aTree with: anIndent on: aStream [

	aStream cr.
	aStream nextPutAll: anIndent.
	aStream nextPutAll: (aTree nodePrintString contractTo: 75) crsToSpacesLW.
	aTree do: [:subTree | self printTree: subTree with: anIndent , self indentUnit on: aStream ].
]

{ #category : #'private misc' }
CTTree >> reOrderLW [
	
	"Restore the subTrees collection to its canonical ordering and return the 
	receiver. 
	Sets may need to be rehashed and SortedCollections may need to be 
	resorted if their 
	elements are modified. This is a noOp for subclasses not 
	
	defining a subTrees variable because it is a noOp for the collections they 
	
	synthesize. 
	
	
	This could have been called reOrder. 
	We added the LW suffix to keep it 
	analogous to <Collection reOrderLW>."

	

	self subTrees reOrderLW
]

{ #category : #converting }
CTTree >> recursiveAs: treeClass [ 
	"Return an instance of treeClass like the receiver with its direct and recursive 
	subtrees also converted to instances of treeClass. One may convert from any 
	tree class to any other tree class this way. If the classes care about the 
	number or order of their subTrees, these must be consistent. Classes with a 
	subTrees variable defined do not care. Classes with it not defined do care."

	| newTree |
	
	self validateTreeClass: treeClass.
	newTree := self basicCopy: treeClass.
	self isBranch 
		ifTrue: [newTree fastSubTrees: (self subTrees collectLW: [:tree | tree recursiveAs: treeClass])].
	^newTree
]

{ #category : #'testing misc' }
CTTree >> recursiveBelongsTo: aTree [ 
	
	"Return a boolean indicating whether aTree is the direct or recursive 
	
	parent of the receiver."

	

	^(self belongsTo: aTree) or: [self isRoot not and: [self superTree recursiveBelongsTo: aTree]]
]

{ #category : #enumerating }
CTTree >> recursiveCollect: aBlock inclusive: boolean [ 
	"Evaluate aBlock on basic copies of the recursive subtrees of the receiver, 
	forming new subTrees collections from the results. The block is also evaluated 
	on a basic copy of the receiver if boolean is true. 
	Return the resulting tree."

	| newTree |
	
	newTree := self basicCopy: self species.
	boolean 
		ifTrue: [newTree := aBlock value: newTree].
	self isBranch 
		ifTrue: [newTree subTrees: 
					(self subTrees collectLW: [:subTree | subTree recursiveCollect: aBlock inclusive: true])].
	^newTree
]

{ #category : #copying }
CTTree >> recursiveCopy [
	"Return a copy of the receiver in which its direct and recursive subTrees are 
	copied. No trees are shared between the receiver and its copy. If we were willing 
	to coerce all the subtrees to be of the same tree class, we could implement this 
	simply as 
		^self recursiveAs: self species"

	| newTree |

	newTree := self basicCopy: self species.
	self isBranch 
		ifTrue: [newTree fastSubTrees: (self subTrees collectLW: [:tree | tree recursiveCopy])].
	^newTree
]

{ #category : #enumerating }
CTTree >> recursiveDetect: aBlock inclusive: incl topDown: tD breadthFirst: bF [ 
	"Search recursively through the receiver, returning the first tree for which
	aBlock, when evaluated on the tree, returns true. Return nil if none is found. 
	
	incl	<Boolean>		true: include the receiver in the search; false: do not include it 
	tD	<Boolean>		true: traverse top down; false: traverse bottom up 
	bF	<Boolean>		true: traverse breadth first; false: traverse depth first (see caveat) 

	Caveat: our implementation of bottom up depth first searches all sub nodes
	of a node before searching the node. Programmers needing to search the
	node before completing the search of all subnodes will have to write a
	special purpose method.

	Note: A method in the test suite demonstrates the various tD bF ordering permutations.
	Browse implementors of this method."

	incl 
		ifTrue: [ tD 
				   ifTrue: [(aBlock value: self) 
								ifTrue: [^self]]].
	self isBranch
		ifTrue:
	[ | recurse break subs |
				recurse := [:subTree :inc | subTree
												recursiveDetect: aBlock
														inclusive: inc
														topDown: tD
														breadthFirst: bF].
				break := [:answer | answer isTreeLW ifTrue: [^answer]].
				subs := self subTrees.
				bF
					ifTrue: [ tD
								ifTrue: [break value: (subs detectLW: aBlock).
										subs do: [:sub | break value: (recurse value: sub value: false)]]
								ifFalse: [subs do: [:sub | break value: (recurse value: sub value: false)].
								break value: (subs detectLW: aBlock)]
					]
					ifFalse: [subs do: [:sub | break value: (recurse value: sub value: true)]]].
	incl 
		ifTrue: [tD 
					ifFalse: [(aBlock value: self) 
					ifTrue: [^self]]].
	^nil
]

{ #category : #enumerating }
CTTree >> recursiveDo: aBlock [ 
	"Evaluate aBlock recursively on the receiver using default parameters. 
	Return the receiver."

	self
		recursiveDo: aBlock
		inclusive: true
		topDown: true
		breadthFirst: true
		reOrder: true
]

{ #category : #enumerating }
CTTree >> recursiveDo: aBlock inclusive: incl topDown: tD breadthFirst: bF reOrder: reOrder [ 
	"Evaluate aBlock recursively on the receiver and return the receiver.

	incl	<Boolean>		true: include the receiver in the evaluation; false: do not include it 
	tD	<Boolean>		true: traverse top down; false: traverse bottom up 
	bF	<Boolean>		true: traverse breadth first; false: traverse depth first (see caveat)
	reOrder <Boolean>	true: reOrder all recursive subtree collections; false: do not reOrder 

	Caveat: our implementation of bottom up depth first operates on all sub nodes of a
	node before operating on the node. Programmers needing to operate on the node
	before operating on all subnodes will have to write a special purpose method.

	Note: a method in the test suite demonstrates the various tD bF ordering permutations.
	Browse implementors of this method."

	incl 
		ifTrue: [tD ifTrue: [aBlock value: self]].
	self isBranch
		ifTrue:
			[| recurse subs |
			recurse := [:subTree :inc | subTree
						recursiveDo: aBlock
						inclusive: inc
						topDown: tD
						breadthFirst: bF
						reOrder: reOrder].
			subs := self subTrees.
			bF
				ifTrue: [tD
						ifTrue: 
							[subs do: aBlock.
							subs do: [:sub | recurse value: sub value: false]]
						ifFalse: 
							[subs do: [:sub | recurse value: sub value: false].
							subs do: aBlock]]
				ifFalse: [subs do: [:sub | recurse value: sub value: true]]].
	incl ifTrue: [tD ifFalse: [aBlock value: self]].
	reOrder ifTrue: [self reOrderLW]
	
]

{ #category : #'testing misc' }
CTTree >> recursiveIncludes: aTree [ 
	
	"Return a boolean indicating whether aTree is a direct or recursive subtree of the 
	
	receiver. Clients using this method must be satisfied with the definition of the 
	equality test (=)."

	

	^self recursiveIncludesTreeSatisfying: [:tree | tree = aTree]
]

{ #category : #'testing misc' }
CTTree >> recursiveIncludesTreeSatisfying: aBlock [ 
	
	"Return a boolean indicating whether the receiver includes at least one direct 
	
	or recursive subtree satisfying aBlock."

	

	^(self
 recursiveDetect: aBlock
	
				inclusive: false
		
				topDown: true
		
				breadthFirst: true) notNil
]

{ #category : #enumerating }
CTTree >> recursiveSubTrees: inclusiveBoolean [ 
	"Return an OrderedCollection of all nodes recursively in the receiver in top 
	down, breadth first order. The receiver is included if inclusiveBoolean is true."

	| nodes |

	nodes := OrderedCollection new.
	self
		recursiveDo: [:node | nodes add: node]
		inclusive: inclusiveBoolean
		topDown: true
		breadthFirst: true
		reOrder: false.
	^nodes
]

{ #category : #'accessing misc' }
CTTree >> root [
	"Return the root of the tree to which the receiver belongs, 
	or the receiver itself if it does not have a superTree."

	^self isRoot
		ifTrue: [self]
		ifFalse: [self superTree root]
]

{ #category : #'accessing misc' }
CTTree >> rootlessPathNodes [
	"Return an array containing nodes from the root to the receiver, excluding the 
	root and including the receiver. If the receiver is a root node, the array will be 
	empty."

	| fullPath |

	fullPath := self fullPathNodes.
	^fullPath copyFrom: 2 to: fullPath size
]

{ #category : #'private printing' }
CTTree >> separator [
	"Return the filename separator character."
	
	^ FileSystem disk separator

]

{ #category : #'accessing simple' }
CTTree >> subTrees [
	"Return the subTrees. The basicSubTrees method explains the returned value."

	^self basicSubTrees
]

{ #category : #'accessing simple' }
CTTree >> subTrees: subTreesColl [ 
	"Validate the argument and set the subTrees to it. 
	Return the receiver. The basicSubTrees: method explains the argument."

	self validateSubTrees: subTreesColl.
	self definesSuperTree 
		ifTrue: [self do: [:tree | tree makeRoot]].
	self fastSubTrees: subTreesColl
]

{ #category : #'accessing simple' }
CTTree >> superTree [
	"Return the superTree if it is defined or nil otherwise."

	^self basicSuperTree
]

{ #category : #'accessing simple' }
CTTree >> superTree: aTree [ 
	"The superTree pointer, if defined by the receiver, is managed internally and is 
	not modifiable by clients."

	self shouldNotImplement
]

{ #category : #'private validating' }
CTTree >> validateKey: aKey [ 
	"Raise an exception if aKey is invalid. This method is used by subclasses that 
	store a key. A nil key would conflict with the <definesKey> method and would 
	also conflict with clients that store subTrees in a Set. Sets cannot store nil."

	aKey isNil 
		ifTrue: [ self class badKeySignal ]
]

{ #category : #'private validating' }
CTTree >> validateSubTrees: subTreesColl [ 
	
	"Raise an exception if subTreesColl cannot be used for the subTrees. The 
	
	method basicSubTrees: explains the argument."

	

	self validateSubTreesCollection: subTreesColl
]

{ #category : #'private validating' }
CTTree >> validateSubTreesClass: aClass [ 
	"Raise an exception if aClass cannot be used for the subTrees collection of the 
	receiver. This method is used by subclasses that store subTrees. 
	Another collection can be added to the list of legal collections below provided:

	(1) its class understands <new>; 
	(2) it can store trees; 
	(3) it understands <addLW:>, <removeLW:> and <remove:ifAbsentLW:>; 
	(4) it understands <do:> and other common enumeration messages; 
	(5) it is sequenceable. Note that we have enhanced Array with add/remove capability. 
	Tree subclasses that support keyed access relax condition 
	(5) and support more collection classes. See implementors of this method.
	
	Understanding <at:> and <at:put:> may be substituted for condition (3), but the 
	resulting trees will not support the adding and removing protocols. 
	
	Performance note: this test is much faster than searching a collection of classes."

	(aClass == OrderedCollection or: [aClass == Array]) "some tree subclasses support more collection classes"
		ifFalse: [ self class badSubTreesSignal ]
]

{ #category : #'private validating' }
CTTree >> validateSubTreesCollection: aCollection [ 
	
	"Raise an exception if aCollection is an invalid collection type or stores invalid 
subtrees."

	

	self validateSubTreesClass: aCollection class.
	
	aCollection do: [:tree | self validateTree: tree]
]

{ #category : #'private validating' }
CTTree >> validateTree: aTree [ 
	"Raise an exception if aTree is not a tree or cannot be mixed with the receiver. It 
	is illegal to mix trees defining superTree pointers with trees not defining them."

	aTree isTreeLW 
		ifFalse: [ self class notATreeSignal ].
	
	self definesSuperTree == aTree definesSuperTree 
		ifFalse: [ self class incompatibleTreeSignal ]
]

{ #category : #'private validating' }
CTTree >> validateTreeClass: aClass [ 
	"Raise an exception if an instance of aClass is not a tree."

	aClass basicNew isTreeLW 
		ifFalse: [ self class notATreeSignal ]
]

{ #category : #'private validating' }
CTTree >> validateValue: aValue [ 
	"Raise an exception if aValue is invalid. This method is used by subclasses that 
	store a value. A nil value would conflict with the <definesValue> method."

	aValue isNil 
		ifTrue: [ self class badValueSignal ]
]

{ #category : #'accessing simple' }
CTTree >> value [
	"Return the value if it is defined or nil otherwise."

	^self basicValue
]

{ #category : #'accessing simple' }
CTTree >> value: anObject [ 
	"Validate the argument and, if the receiver defines a value, set it. 
	Return the receiver."

	self validateValue: anObject.
	self basicValue: anObject
]

{ #category : #'accessing simple' }
CTTree >> values [
	" Answer a Collection with the subtrees values "
	
	^ self subTrees collect: #value.
]
