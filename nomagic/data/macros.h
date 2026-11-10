//This file contains a list of explicit macros to be expanded before reverse engineering
#define ODBCXX_EXPORT
#define __EXPORT

//Type Casting of MFC Class Objects
#define DYNAMIC_DOWNCAST( class, pointer )
#define STATIC_DOWNCAST( class_name, pobject )

//Run-Time Object Model Services
#define DECLARE_DYNAMIC( class_name )
#define DECLARE_DYNCREATE( class_name )
#define DECLARE_SERIAL( class_name )
#define IMPLEMENT_DYNAMIC( class_name, base_class_name )
#define IMPLEMENT_DYNCREATE( class_name, base_class_name )
#define IMPLEMENT_SERIAL( class_name, base_class_name, wSchema )
#define RUNTIME_CLASS( class_name )
#define DECLARE_OLECREATE( class_name )
#define IMPLEMENT_OLECREATE( class_name, external_name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 )

//Diagnostic Services
#define ASSERT( booleanExpression )
#define ASSERT_KINDOF( classname, pobject )
#define ASSERT_VALID( pObject )
#define TRACE( exp )
#define TRACE0( exp )
#define TRACE1( exp, param1 )
#define TRACE2( exp, param1, param2 )
#define TRACE3( exp, param1, param2, param3 )
#define VERIFY( booleanExpression )

//Exception processing
#define TRY
#define CATCH( exception_class, exception_object_pointer_name )
#define CATCH_ALL( exception_object_pointer_name )
#define AND_CATCH( exception_class, exception_object_pointer_name )
#define AND_CATCH_ALL( exception_object_pointer_name )
#define END_CATCH
#define END_CATCH_ALL
#define THROW( exception_object_pointer )
#define THROW_LAST( )

//Message Map Macros
#define DECLARE_MESSAGE_MAP( )
#define BEGIN_MESSAGE_MAP( theClass, baseClass )
#define END_MESSAGE_MAP( )
#define ON_COMMAND( id, memberFxn )
#define ON_CONTROL( wNotifyCode, id, memberFxn )
#define ON_MESSAGE( message, memberFxn )
#define ON_OLECMD( pguid, olecmdid, id )
#define ON_REGISTERED_MESSAGE( nMessageVariable, memberFxn )
#define ON_REGISTERED_THREAD_MESSAGE( nMessageVariable, memberFxn )
#define ON_THREAD_MESSAGE( message, memberFxn )
#define ON_UPDATE_COMMAND_UI( id, memberFxn )
#define ON_COMMAND_RANGE( id1, id2, memberFxn )
#define ON_UPDATE_COMMAND_UI_RANGE( id1, id2, memberFxn )
#define ON_CONTROL_RANGE( wNotifyCode, id1, id2, memberFxn )
#define ON_WM_CREATE( )
#define ON_WM_DESTROY( )
#define ON_NOTIFY( wNotifyCode, id, memberFxn )
#define ON_WM_TIMER( )
#define ON_WM_SYSCOMMAND( )
#define ON_BN_CLICKED( id, memberFxn )
#define ON_WM_PAINT( )
#define ON_WM_QUERYDRAGICON( )
#define ON_WM_SIZE( )

//Application information and management
BOOL AFXAPI AfxWinInit( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow )

//Database Macros and Globals
#define AFX_ODBC_CALL( SQLFunc )
#define AFX_SQL_ASYNC( prs, SQLFunc )
#define AFX_SQL_SYNC( SQLFunc )

//Internet Server API (ISAPI) Parse Maps
#define BEGIN_PARSE_MAP( theClass, baseClass )
#define ON_PARSE_COMMAND( FnName, mapClass, Args )
#define ON_PARSE_COMMAND_PARAMS( Params )
#define DEFAULT_PARSE_COMMAND( FnName, mapClass )
#define END_PARSE_MAP( theClass )

//Internet Server API (ISAPI) Diagnostic Macros
#define ISAPIASSERT( booleanExpression )
#define ISAPITRACE( exp )
#define ISAPITRACE0( exp )
#define ISAPITRACE1( exp, param1 )
#define ISAPITRACE2( exp, param1, param2 )
#define ISAPITRACE3( exp, param1, param2, param3 )
#define ISAPIVERIFY( booleanExpression )


// OLE Dispatch Maps
#define DECLARE_DISPATCH_MAP( )
#define BEGIN_DISPATCH_MAP( theClass, baseClass )
#define END_DISPATCH_MAP( )
#define DISP_FUNCTION( theClass, pszName, pfnMember, vtRetVal, vtsParams )
#define DISP_PROPERTY( theClass, pszName, memberName, vtPropType )
#define DISP_PROPERTY_EX( theClass, pszName, memberGet, memberSet, vtPropType )
#define DISP_PROPERTY_NOTIFY( theClass, szExternalName, memberName, pfnAfterSet, vtPropType )
#define DISP_PROPERTY_NOTIFY( theClass, pszExternalName, pfnGet, pfnSet, vtPropType, vtsParams )
#define DISP_DEFVALUE( theClass, pszName )

// OLE Type Library Access
#define DECLARE_OLETYPELIB( class_name )
#define IMPLEMENT_OLETYPELIB( class_name, tlid, wVerMajor, wVerMinor )

// OLE Property Pages
#define BEGIN_PROPPAGEIDS( class_name, count )
#define END_PROPPAGEIDS( class_name )
#define PROPPAGEID( clsid )

// OLE Event Maps
#define DECLARE_EVENT_MAP( )
#define BEGIN_EVENT_MAP( theClass, baseClass )
#define END_EVENT_MAP( )
#define EVENT_CUSTOM( pszName, pfnFire, vtsParams )
#define EVENT_CUSTOM_ID( pszName, dispid, pfnFire, vtsParams )
#define ON_OLEVERB( idsVerbName, memberFxn )
#define ON_STDOLEVERB( iVerb, memberFxn )

// OLE Event Sink Maps
#define BEGIN_EVENTSINK_MAP( theClass, baseClass )
#define DECLARE_EVENTSINK_MAP( )
#define END_EVENTSINK_MAP( )
#define ON_EVENT( theClass, id, dispid, pfnHandler, vtsParams )
#define ON_EVENT_RANGE( theClass, idFirst, idLast, dispid, pfnHandler, vtsParams )
#define ON_EVENT_REFLECT( theClass, dispid, pfnHandler, vtsParams )
#define ON_PROPNOTIFY( theClass, id, dispid, pfnRequest, pfnChanged )
#define ON_PROPNOTIFY_RANGE( theClass, idFirst, idLast, dispid, pfnRequest, pfnChanged )
#define ON_PROPNOTIFY_REFLECT( theClass, dispid, pfnRequest, pfnChanged )

// OLE Connection Maps
#define BEGIN_CONNECTION_PART( theClass, localClass )
#define END_CONNECTION_PART( localClass )
#define CONNECTION_IID( iid )
#define DECLARE_CONNECTION_MAP( )
#define BEGIN_CONNECTION_MAP( theClass, theBase )
#define END_CONNECTION_MAP( )
#define CONNECTION_PART( theClass, iid, localClass )

// OLE Registering OLE Controls
BOOL AFXAPI AfxOleRegisterPropertyPageClass( HINSTANCE hInstance, REFCLSID clsid, UINT idTypeName, int nRegFlags )

// OLE Class Factories and Licensing
#define DECLARE_OLECREATE_EX( class_name )
#define IMPLEMENT_OLECREATE_EX( class_name, external_name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 )
#define BEGIN_OLEFACTORY( class_name )
#define END_OLEFACTORY( class_name )

//ATL
#define DECLARE_AGGREGATABLE( x )
#define DECLARE_CLASSFACTORY( )
#define DECLARE_CLASSFACTORY_EX( cf )
#define DECLARE_CLASSFACTORY2( lic )
#define DECLARE_CLASSFACTORY_AUTO_THREAD( )
#define DECLARE_CLASSFACTORY_SINGLETON( obj )
#define DECLARE_GET_CONTROLLING_UNKNOWN( )
#define DECLARE_NOT_AGGREGATABLE( x )
#define DECLARE_ONLY_AGGREGATABLE( x )
#define DECLARE_POLY_AGGREGATABLE( x )
#define DECLARE_PROTECT_FINAL_CONSTRUCT( )
#define BEGIN_CATEGORY_MAP( theClass )
#define END_CATEGORY_MAP( )
#define IMPLEMENTED_CATEGORY( catID )
#define REQUIRED_CATEGORY( catID )
#define BEGIN_COM_MAP( x )
#define COM_INTERFACE_ENTRY( x )
#define COM_INTERFACE_ENTRY_IID( iid, x )
#define COM_INTERFACE_ENTRY2( x, x2 )
#define COM_INTERFACE_ENTRY2_IID( iid, x, x2 )
#define COM_INTERFACE_ENTRY_FUNC( iid, dw, func )
#define COM_INTERFACE_ENTRY_FUNC_BLIND( dw, func )
#define COM_INTERFACE_ENTRY_TEAR_OFF( iid, x )
#define COM_INTERFACE_ENTRY_CACHED_TEAR_OFF( iid, x, punk )
#define COM_INTERFACE_ENTRY_AGGREGATE( iid, punk )
#define COM_INTERFACE_ENTRY_AGGREGATE_BLIND( punk )
#define COM_INTERFACE_ENTRY_AUTOAGGREGATE( iid, punk, clsid )
#define COM_INTERFACE_ENTRY_AUTOAGGREGATE_BLIND( punk, clsid )
#define COM_INTERFACE_ENTRY_CHAIN( classname )
#define COM_INTERFACE_ENTRY_BREAK( x )
#define COM_INTERFACE_ENTRY_NOINTERFACE( x )
#define END_COM_MAP( )

#define BEGIN_SINK_MAP( _class )
#define END_SINK_MAP( )
#define SINK_ENTRY( id, dispid, fn )
#define SINK_ENTRY_EX( id, iid, dispid, fn )
#define SINK_ENTRY_INFO( id, iid, dispid, fn, info)
#define BEGIN_CONNECTION_POINT_MAP( x )
#define CONNECTION_POINT_ENTRY( iid )
#define END_CONNECTION_POINT_MAP( )
#define BEGIN_EXTENSION_SNAPIN_NODEINFO_MAP( classname )
#define BEGIN_SNAPINTOOLBARID_MAP( _class )
#define END_EXTENSION_SNAPIN_NODEINFO_MAP( )
#define END_SNAPINTOOLBARID_MAP( _class )
#define EXTENSION_SNAPIN_DATACLASS( dataClass )
#define EXTENSION_SNAPIN_NODEINFO_ENTRY( dataClass )
#define SNAPINMENUID( id )
#define SNAPINTOOLBARID_ENTRY( id )
#define ATLTRACE( exp )
#define ATLTRACENOTIMPL( funcname )
#define ATLTRACE2( DWORD category, UINT level, LPCSTR lpszFormat, ... )
#define BEGIN_MSG_MAP( theClass )
#define MESSAGE_HANDLER( msg, func )
#define MESSAGE_RANGE_HANDLER( msgFirst, msgLast, func )
#define COMMAND_HANDLER( id, code, func )
#define COMMAND_ID_HANDLER( id, func )
#define COMMAND_RANGE_HANDLER( idFirst, idLast, func )
#define NOTIFY_HANDLER( id, cd, func )
#define NOTIFY_ID_HANDLER( id, func )
#define NOTIFY_CODE_HANDLER( cd, func )
#define NOTIFY_RANGE_HANDLER( idFirst, idLast, func )
#define CHAIN_MSG_MAP( theChainClass )
#define CHAIN_MSG_MAP_MEMBER( theChainMember )
#define CHAIN_MSG_MAP_ALT( theChainClass, msgMapID )
#define CHAIN_MSG_MAP_ALT_MEMBER( theChainMember, msgMapID )
#define CHAIN_MSG_MAP_DYNAMIC( dynaChainID )
#define END_MSG_MAP( )
#define ALT_MSG_MAP( msgMapID )
#define DECLARE_EMPTY_MSG_MAP( )
#define COMMAND_CODE_HANDLER( code, func )
#define REFLECT_NOTIFICATIONS( )
#define DEFAULT_REFLECTION_HANDLER( )
#define BEGIN_OBJECT_MAP( x )
#define OBJECT_ENTRY( clsid, class )
#define OBJECT_ENTRY_NON_CREATEABLE( class )
#define END_OBJECT_MAP( )
#define DECLARE_OBJECT_DESCRIPTION( x )
#define BEGIN_PROP_MAP( theClass )
#define PROP_DATA_ENTRY( szDesc, member, vt )
#define PROP_ENTRY( szDesc, dispid, clsid )
#define PROP_ENTRY_EX( szDesc, dispid, clsid, iidDispatch )
#define PROP_PAGE( clsid )
#define END_PROPERTY_MAP( )
#define DECLARE_NO_REGISTRY( )
#define DECLARE_REGISTRY( class, pid, vpid, nid, flags )
#define DECLARE_REGISTRY_RESOURCE( x )
#define DECLARE_REGISTRY_RESOURCEID( x )
#define BEGIN_SERVICE_MAP( theClass )
#define END_SERVICE_MAP( )
#define SERVICE_ENTRY( SID )
#define SERVICE_ENTRY_CHAIN( punk )
#define IMPLEMENT_BOOL_STOCKPROP( fname, pname, dispid )
#define IMPLEMENT_BSTR_STOCKPROP( fname, pname, dispid )
#define IMPLEMENT_STOCKPROP( type, fname, pname, dispid )
#define A2BSTR(lpa)
#define OLE2A(lpa)
#define T2A(lpa)
#define W2A(lpa)
#define A2COLE(lpa)
#define OLE2BSTR(lpa)
#define T2BSTR(lpa)
#define W2BSTR(lpa)
#define A2CT(lpa)
#define OLE2CA(lpa)
#define T2CA(lpa)
#define W2CA(lpa)
#define A2CW(lpa)
#define OLE2CT(lpa)
#define T2COLE(lpa)
#define W2COLE(lpa)
#define A2OLE(lpa)
#define OLE2CW(lpa)
#define T2CW(lpa)
#define W2CT(lpa)
#define A2T(lpa)
#define OLE2T(lpa)
#define T2OLE(lpa)
#define W2OLE(lpa)
#define A2W(lpa)
#define OLE2W(lpa)
#define T2W(lpa)
#define W2T(lpa)
#define DEVMODEA2W(lpa)
#define TEXTMETRICA2W(lpa)
#define DEVMODEOLE2T(lpa)
#define TEXTMETRICOLE2T(lpa)
#define DEVMODET2OLE(lpa)
#define TEXTMETRICT2OLE(lpa)
#define DEVMODEW2A(lpa)
#define TEXTMETRICW2A(lpa)
#define DECLARE_WND_CLASS( WndClassName )
#define DECLARE_WND_SUPERCLASS( WndClassName, OrigWndClassName )
#define DECLARE_WND_CLASS_EX( WndClassName, style, bkgnd )

// OLE DB
#define BEGIN_ACCESSOR( num, bAuto )
#define BEGIN_ACCESSOR_MAP( x, num )
#define END_ACCESSOR( )
#define END_ACCESSOR_MAP( )
#define BEGIN_COLUMN_MAP( x )
#define BOOKMARK_ENTRY( variable )
#define COLUMN_ENTRY( nOrdinal, data )
#define COLUMN_ENTRY_TYPE ( nOrdinal, wType, data )
#define COLUMN_ENTRY_TYPE_SIZE( nOrdinal, wType, nLength, data )
#define BLOB _ENTRY( nOrdinal, IID, flags, data )
#define COLUMN_ENTRY_EX( nOrdinal, wType, nLength, nPrecision, nScale, data, length, status )
#define COLUMN_ENTRY_LENGTH( nOrdinal, data, length )
#define COLUMN_ENTRY_LENGTH_STATUS( nOrdinal, data, length, status )
#define COLUMN_ENTRY_PS( nOrdinal, nPrecision, nScale, data ) 
#define COLUMN_ENTRY_PS_LENGTH( nOrdinal, nPrecision, nScale, data, length )
#define COLUMN_ENTRY_PS_STATUS( nOrdinal, nPrecision, nScale, data, status )
#define COLUMN_ENTRY_PS_LENGTH_STATUS( nOrdinal, nPrecision, nScale, data, length, status )
#define COLUMN_ENTRY_STATUS( nOrdinal, data, status )
#define END_COLUMN_MAP( )
#define DEFINE_COMMAND( x, szCommand )
#define BEGIN_PARAM_MAP( x )
#define END_PARAM_MAP( )
#define SET_PARAM_TYPE( type )
#define BEGIN_PROPERTY_SET( pguid )
#define BEGIN_PROPERTY_SET(pguid, flags)
#define BEGIN_PROPSET_MAP( Class )
#define CHAIN_PROPERTY_SET( ChainClass )
#define END_PROPERTY_SET( guid )
#define END_PROPSET_MAP( )
#define PROPERTY_INFO_ENTRY( dwPropID )
#define PROPERTY_INFO_ENTRY( dwPropID, vt, dwFlags, value, options)
#define PROPERTY_INFO_ENTRY( dwPropID, value )
#define BEGIN_PROVIDER_COLUMN_MAP( theClass ) 
#define END_PROVIDER_COLUMN_MAP( )
#define PROVIDER_COLUMN_ENTRY_GN ( name, ordinal, flags, colSize, dbtype, precision, scale, guid )
#define PROVIDER_COLUMN_ENTRY_FIXED( name, ordinal, dbtype, member )
#define PROVIDER_COLUMN_ENTRY_LENGTH( name, ordinal, size, member )
#define PROVIDER_COLUMN_ENTRY_STR( name, ordinal, member )
#define PROVIDER_COLUMN_ENTRY_WSTR( name, ordinal, member )

// PARSE
#define BEGIN_PARSE_MAP( theClass, baseClass )
#define ON_PARSE_COMMAND( FnName, mapClass, Args )
#define ON_PARSE_COMMAND_PARAMS( Params )
#define DEFAULT_PARSE_COMMAND( FnName, mapClass )
#define END_PARSE_MAP( theClass )
#define END_PROPERTY_SET( guid )
#define BEGIN_PROPSET_MAP( Class )
#define PROPERTY_INFO_ENTRY( dwPropID )
#define END_PROPSET_MAP( )

#define MAKELPARAM(low, high)
#define MAKELRESULT(low, high)
#define MAKELP(sel, off) 
#define SELECTOROF(lp) 
#define OFFSETOF(lp) 
#define FIELDOFFSET(type, field)
#define afx_msg
#define ACE_ALLOC_HOOK_DECLARE

// xerces
#define XERCES_CPP_NAMESPACE_BEGIN namespace xerces {
#define XERCES_CPP_NAMESPACE_END }
#define XERCES_CPP_NAMESPACE_USE using namespace XERCES_CPP_NAMESPACE;
#define XERCES_CPP_NAMESPACE_QUALIFIER XERCES_CPP_NAMESPACE::
#define CDOM_EXPORT
#define ATL_NO_VTABLE
#define PLATFORM_IMPORT
#define PARSERS_EXPORT

// QT
#define Q_AUTOTEST_EXPORT
#define Q_CLASSINFO(name, value)
#define Q_COMPAT_EXPORT
#define Q_CORE_EXPORT
#define Q_CORE_EXPORT_INLINE inline
#define Q_D(Class)
#define Q_DECL_IMPORT
#define Q_DECLARE_ASSOCIATIVE_ITERATOR(map)
#define Q_DECLARE_BUILTIN_METATYPE(TYPE, NAME)
#define Q_DECLARE_EXTENSION_INTERFACE(IFace, IId)
#define Q_DECLARE_FLAGS(Flags, enum)
#define Q_DECLARE_INTERFACE(IFace, IId)
#define Q_DECLARE_METATYPE(txt)
#define Q_DECLARE_MUTABLE_SEQUENTIAL_ITERATOR(c)
#define Q_DECLARE_MUTABLE_ASSOCIATIVE_ITERATOR(c)
#define Q_DECLARE_OPERATORS_FOR_FLAGS(Flags)
#define Q_DECLARE_PRIVATE(Class)
#define Q_DECLARE_PUBLIC(Class)
#define Q_DECLARE_SEQUENTIAL_ITERATOR(name)
#define Q_DECLARE_SHARED(name)
#define Q_DECLARE_TYPEINFO(TYPE, FLAGS)
#define Q_DECL_DEPRECATED
#define Q_DISABLE_COPY(Class)
#define Q_DUMMY_COMPARISON_OPERATOR(c)
#define Q_ENUMS(x)
#define Q_FLAGS(x)
#define Q_GADGET
#define Q_GUI_EXPORT
#define Q_GUI_EXPORT_INLINE inline
#define Q_INLINE_TEMPLATE
#define Q_INTERFACES(x)
#define Q_NETWORK_EXPORT
#define Q_NOREPLY
#define Q_OBJECT
#define Q_OPENGL_EXPORT
#define Q_OUTOFLINE_TEMPLATE inline
#define Q_OVERRIDE(text)
#define Q_PRIVATE_SLOT(d, signature)
#define Q_PROPERTY(text)
#define Q_Q(Class)
#define Q_REQUIRED_RESULT
#define Q_SCRIPTABLE
#define Q_SIGNALS protected
#define Q_SLOTS
#define Q_SQL_EXPORT
#define Q_SVG_EXPORT
#define Q_TESTLIB_EXPORT
#define Q_TYPENAME typename
#define Q_XML_EXPORT

#define QDBUS_EXPORT
#define QDESIGNER_COMPONENTS_EXPORT
#define QDESIGNER_EXTENSION_EXPORT
#define QDESIGNER_SDK_EXPORT
#define QDESIGNER_SHARED_EXPORT
#define QDESIGNER_UILIB_EXPORT
#define QDESIGNER_WIDGET_EXPORT
#define QDOC_PROPERTY(text)

#define QT_ASCII_CAST_WARN
#define QT_ASCII_CAST_WARN_CONSTRUCTOR
#define QT_ASSISTANT_CLIENT_EXPORT
#define QT_BEGIN_HEADER
#define QT_DEPRECATED
#define QT_DEPRECATED_VARIABLE
#define QT_DEPRECATED_CONSTRUCTOR
#define QT_END_HEADER
#define QT_FASTCALL
#define QT_FT_BEGIN_HEADER
#define QT_FT_END_HEADER
#define QT_MOC_COMPAT
#define QT_MODULE(name)
#define QT_STATIC_CONST static const
#define QT_STATIC_CONST_IMPL const
#define QT_TR_NOOP(x)
#define QT_TRANSLATE_NOOP(scope, x)

#define slots
#define signals protected


// Microsoft extension
#define CALLBACK
#define LRESULT void
#define _ENTRY(p1, p2, p3, p4) p1

#define CFX_EXPORT

// GCC
#define __extension__

// Symbian macro
#define _L(string) TPtrC((const TText*) string)
#define _LIT(name,s) const static TListC<sizeof(s)> name = {sizeof(s) -1,s}
#define _LIT8(name,s) const static TListC<sizeof(s)> name = {sizeof(s) -1,s}

#define IMPORT_C /*__declspec(dllimport)*/
#define EXPORT_C /*__declspec(dllexport)*/

#define NONSHARABLE_CLASS(x) class x
#define NONSHARABLE_STRUCT(x) struct x

#define GLREF_D extern
#define GLDEF_D
#define LOCAL_D static
#define GLREF_C extern
#define GLDEF_C
#define LOCAL_C static
