prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>2100361412142254
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'HR'
);
end;
/
 
prompt APPLICATION 102 - DS Plugins
--
-- Application Export:
--   Application:     102
--   Name:            DS Plugins
--   Date and Time:   14:01 Sunday December 6, 2020
--   Exported By:     ADMIN
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 5900241086117690
--   Manifest End
--   Version:         20.2.0.00.20
--   Instance ID:     300177295433990
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/com_djogicslavko_apexinitials
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(5900241086117690)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.DJOGICSLAVKO.APEXINITIALS'
,p_display_name=>'APEX Initials'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE render_initials (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result',
')',
'IS',
'    l_attr_01 p_item.attribute_01%TYPE := p_item.attribute_01;',
'    l_attr_02 p_item.attribute_02%TYPE := p_item.attribute_02;',
'    l_attr_03 p_item.attribute_03%TYPE := p_item.attribute_03;',
'    l_attr_04 p_item.attribute_04%TYPE := p_item.attribute_04;',
'    l_result  apex_plugin.t_page_item_render_result;',
'  ',
'    l_params          VARCHAR2(4000);',
'    l_escaped_value   VARCHAR2(4000);',
'    l_html_string     VARCHAR2(2000);',
'    l_element_item_id VARCHAR2(200);',
'BEGIN',
'    IF p_param.is_printer_friendly THEN',
'        apex_plugin_util.print_display_only(',
'            p_item_name        => p_item.name,',
'            p_display_value    => p_param.value,',
'            p_show_line_breaks => FALSE,',
'            p_escape           => TRUE,',
'            p_attributes       => p_item.element_attributes',
'        );',
'    ELSIF p_param.is_readonly THEN',
'        apex_plugin_util.print_hidden_if_readonly (',
'            p_item_name           => p_item.name,',
'            p_value               => p_param.value,',
'            p_is_readonly         => p_param.is_readonly,',
'            p_is_printer_friendly => p_param.is_printer_friendly',
'        );',
'    ELSE',
'        l_element_item_id := p_item.name;',
'        l_escaped_value   := apex_escape.html(p_param.value);',
'',
'        l_html_string := ''<img data-initials="'' || l_escaped_value || ''" id="'' || l_element_item_id || ''">'';',
'',
'        apex_javascript.add_library (',
'            p_name      => ''apex_initials.min'',',
'            p_directory => p_plugin.file_prefix,',
'            p_version   => null',
'        );',
'',
'        IF l_attr_04 IS NOT NULL THEN',
'            l_params := ''{ radius: "'' || l_attr_01 || ''", size: '' || l_attr_02 || '', fontSize: "'' || l_attr_03 || ''", color: "'' || l_attr_04 || ''" }'';',
'        ELSE',
'            l_params := ''{ radius: "'' || l_attr_01 || ''", size: '' || l_attr_02 || '', fontSize: "'' || l_attr_03 || ''" }'';',
'        END IF;',
'        apex_javascript.add_onload_code(p_code => ''Initials.init("'' || l_element_item_id || ''", '' || l_params || '')'');',
'',
'        htp.p(l_html_string);',
'    END IF;',
'  ',
'    l_result.is_navigable := TRUE;',
'',
'    p_result := l_result;',
'END render_initials;'))
,p_api_version=>2
,p_render_function=>'render_initials'
,p_standard_attributes=>'SOURCE:ELEMENT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/djoga98/apex-plugin-initials'
,p_files_version=>3
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6701390268581601)
,p_plugin_id=>wwv_flow_api.id(5900241086117690)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Radius'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'15px'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6703189559586578)
,p_plugin_id=>wwv_flow_api.id(5900241086117690)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Size'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'100'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6704980980588210)
,p_plugin_id=>wwv_flow_api.id(5900241086117690)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Font size'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'48px'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(6706737724591487)
,p_plugin_id=>wwv_flow_api.id(5900241086117690)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '6C657420496E697469616C733D66756E6374696F6E28297B6C657420743D5B2223316162633963222C2223313661303835222C2223663163343066222C2223663339633132222C2223326563633731222C2223323761653630222C222365363765323222';
wwv_flow_api.g_varchar2_table(2) := '2C2223643335343030222C2223333439386462222C2223323938306239222C2223653734633363222C2223633033393262222C2223396235396236222C2223386534346164222C2223626463336337222C2223333434393565222C222332633365353022';
wwv_flow_api.g_varchar2_table(3) := '2C2223393561356136222C2223376638633864222C2223656338376266222C2223643837306164222C2223663639373835222C2223396261333765222C2223623439323535222C2223623439323535222C2223613934313336225D2C653D743D3E7B6C65';
wwv_flow_api.g_varchar2_table(4) := '7420653D742E73706C697428222022293B72657475726E28655B305D5B305D2B28655B315D3F655B315D5B305D3A655B305D5B315D29292E746F55707065724361736528297D2C693D28692C72293D3E7B6C6574206E3D7B7261646975733A722E726164';
wwv_flow_api.g_varchar2_table(5) := '6975737C7C2231357078222C73697A653A722E73697A657C7C3130302C666F6E7453697A653A722E666F6E7453697A657C7C2234387078222C636F6C6F723A722E636F6C6F727C7C745B7328302C742E6C656E677468295D7D2C6F3D646F63756D656E74';
wwv_flow_api.g_varchar2_table(6) := '2E676574456C656D656E74427949642869293B6F2E7374796C652E77696474683D2231303025222C6F2E7374796C652E6D617857696474683D6E2E73697A652B227078222C6F2E7374796C652E626F726465725261646975733D6E2E7261646975733B6C';
wwv_flow_api.g_varchar2_table(7) := '657420613D646F63756D656E742E637265617465456C656D656E744E532822687474703A2F2F7777772E77332E6F72672F323030302F737667222C227465787422293B612E7365744174747269627574652822746578742D616E63686F72222C226D6964';
wwv_flow_api.g_varchar2_table(8) := '646C6522292C612E736574417474726962757465282279222C2235302522292C612E736574417474726962757465282278222C2235302522292C612E73657441747472696275746528226479222C22302E3335656D22292C612E73657441747472696275';
wwv_flow_api.g_varchar2_table(9) := '74652822706F696E7465722D6576656E7473222C226175746F22292C612E736574417474726962757465282266696C6C222C22776869746522292C612E73657441747472696275746528227374796C65222C60666F6E742D7765696768743A20626F6C64';
wwv_flow_api.g_varchar2_table(10) := '3B20666F6E742D73697A653A20247B6E2E666F6E7453697A657D3B20666F6E742D66616D696C793A204D6F6E747365727261742C2073616E732D73657269663B60292C612E74657874436F6E74656E743D65286F2E646174617365742E696E697469616C';
wwv_flow_api.g_varchar2_table(11) := '73293B6C657420643D646F63756D656E742E637265617465456C656D656E744E532822687474703A2F2F7777772E77332E6F72672F323030302F737667222C2273766722293B642E7365744174747269627574652822786D6C6E73222C22687474703A2F';
wwv_flow_api.g_varchar2_table(12) := '2F7777772E77332E6F72672F323030302F73766722292C642E7365744174747269627574652822706F696E7465722D6576656E7473222C226E6F6E6522292C642E73657441747472696275746528227769647468222C6E2E73697A65292C642E73657441';
wwv_flow_api.g_varchar2_table(13) := '74747269627574652822686569676874222C6E2E73697A65292C642E73657441747472696275746528227374796C65222C606261636B67726F756E642D636F6C6F723A20247B6E2E636F6C6F727D3B60292C642E617070656E644368696C642861293B6C';
wwv_flow_api.g_varchar2_table(14) := '6574206C3D646F63756D656E742E637265617465456C656D656E74282244495622293B6C2E617070656E644368696C6428642E636C6F6E654E6F646528213029293B6C657420633D77696E646F772E62746F61286465636F646555524928656E636F6465';
wwv_flow_api.g_varchar2_table(15) := '555249286C2E696E6E657248544D4C2929293B6F2E7365744174747269627574652822737263222C22646174613A696D6167652F7376672B786D6C3B6261736536342C222B63297D2C733D28742C65293D3E4D6174682E666C6F6F72284D6174682E7261';
wwv_flow_api.g_varchar2_table(16) := '6E646F6D28292A28652D7429292B743B72657475726E7B696E69743A697D7D28293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(6808696564668457)
,p_plugin_id=>wwv_flow_api.id(5900241086117690)
,p_file_name=>'apex_initials.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
