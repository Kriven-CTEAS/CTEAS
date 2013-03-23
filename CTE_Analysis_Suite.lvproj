<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="12008004">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="CTEAS_InputMaker" Type="Folder">
			<Item Name="CTE_Analysis_Suite_InputMaker.vi" Type="VI" URL="../CTE_Analysis_Suite_InputMaker.vi"/>
			<Item Name="CTE_Analysis_Suite_InputMaker_FormatHKL.vi" Type="VI" URL="../CTE_Analysis_Suite_InputMaker_FormatHKL.vi"/>
			<Item Name="CTE_Analysis_Suite_InputMaker_FormatString.vi" Type="VI" URL="../CTE_Analysis_Suite_InputMaker_FormatString.vi"/>
			<Item Name="CTE_Analysis_Suite_InputMaker_FormatStringLP.vi" Type="VI" URL="../CTE_Analysis_Suite_InputMaker_FormatStringLP.vi"/>
			<Item Name="CTE_Analysis_Suite_InputMaker_FormatStringS.vi" Type="VI" URL="../CTE_Analysis_Suite_InputMaker_FormatStringS.vi"/>
		</Item>
		<Item Name="data" Type="Folder" URL="../data">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="CTE_Analysis_Suite_UIUCv0.7.vi" Type="VI" URL="../CTE_Analysis_Suite_UIUCv0.7.vi"/>
		<Item Name="CTE_Analysis_Suitev0.6.vi" Type="VI" URL="../CTE_Analysis_Suitev0.6.vi"/>
		<Item Name="CTEAS.ico" Type="Document" URL="../CTEAS.ico"/>
		<Item Name="CTE_Analysis_Suite_UIUCv0.6.vi" Type="VI" URL="../CTE_Analysis_Suite_UIUCv0.6.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="Read From Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (string).vi"/>
				<Item Name="Read From Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (I64).vi"/>
				<Item Name="Read From Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (DBL).vi"/>
				<Item Name="Read From Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File.vi"/>
				<Item Name="Write To Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (string).vi"/>
				<Item Name="Write To Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (I64).vi"/>
				<Item Name="Write To Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File (DBL).vi"/>
				<Item Name="Write To Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write To Spreadsheet File.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Read Lines From File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Lines From File.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="Open File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Open File+.vi"/>
				<Item Name="Read File+ (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read File+ (string).vi"/>
				<Item Name="compatReadText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReadText.vi"/>
				<Item Name="Close File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Close File+.vi"/>
				<Item Name="Find First Error.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find First Error.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="General Error Handler CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler CORE.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="Write Spreadsheet String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Spreadsheet String.vi"/>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="CTE_Analysis_Suite_UIUCv0.6" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{1C921203-48A8-4035-9A4B-37CF1C563D04}</Property>
				<Property Name="App_INI_GUID" Type="Str">{F01614B9-7BDF-4A31-BE3D-6D6C972851A9}</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{EDC17D6B-C789-49B4-9851-27FD77D79774}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">CTE_Analysis_Suite_UIUCv0.6</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.6</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{4457B6EE-3E7C-40BE-895B-0A1F0797ADF9}</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Destination[0].destName" Type="Str">CTEAS-UIUCv06.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.6/CTEAS-UIUCv06.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.6/data</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="SourceCount" Type="Int">6</Property>
				<Property Name="Source[0].itemID" Type="Str">{2254EF8D-6741-455F-A516-19A804236631}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/CTE_Analysis_Suite_UIUCv0.7.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/data</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Container</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].Container.applyDestination" Type="Bool">true</Property>
				<Property Name="Source[4].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/CTEAS_InputMaker</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">Container</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/CTE_Analysis_Suitev0.6.vi</Property>
				<Property Name="Source[5].type" Type="Str">VI</Property>
				<Property Name="TgtF_companyName" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_fileDescription" Type="Str">CTE_Analysis_Suite v0.6</Property>
				<Property Name="TgtF_fileVersion.build" Type="Int">2</Property>
				<Property Name="TgtF_fileVersion.minor" Type="Int">6</Property>
				<Property Name="TgtF_internalName" Type="Str">CTE_Analysis_Suite v0.6</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2011 The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_productName" Type="Str">CTE_Analysis_Suite v0.6</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{AFBA233E-4D69-4081-B208-1AFEDE52B59E}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">CTEAS-UIUCv06.exe</Property>
			</Item>
			<Item Name="CTE_Analysis_Suitev0.6" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{4CFC9DC2-F8D6-4BF8-A32E-8B48C4AB3BDF}</Property>
				<Property Name="App_INI_GUID" Type="Str">{2914C50B-8053-4336-96DE-15B2DE1A231F}</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{B2FA72CA-61AA-4EDA-A536-50F073D42B65}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">CTE_Analysis_Suitev0.6</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.6</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{99B3F68B-CFA9-443B-81E6-2431A94CE328}</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Destination[0].destName" Type="Str">CTEASv06.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.6/CTEASv06.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.6/data</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="SourceCount" Type="Int">6</Property>
				<Property Name="Source[0].itemID" Type="Str">{2254EF8D-6741-455F-A516-19A804236631}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/CTE_Analysis_Suite_UIUCv0.7.vi</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/data</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Container</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].Container.applyDestination" Type="Bool">true</Property>
				<Property Name="Source[4].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/CTEAS_InputMaker</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">Container</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/CTE_Analysis_Suitev0.6.vi</Property>
				<Property Name="Source[5].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[5].type" Type="Str">VI</Property>
				<Property Name="TgtF_companyName" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_fileDescription" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_fileVersion.build" Type="Int">2</Property>
				<Property Name="TgtF_fileVersion.minor" Type="Int">6</Property>
				<Property Name="TgtF_fileVersion.patch" Type="Int">1</Property>
				<Property Name="TgtF_internalName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2011 The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_productName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{8536D992-6D0B-4E2F-A37C-02E6F1E5F2E4}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">CTEASv06.exe</Property>
			</Item>
			<Item Name="CTEAS-UIUCv0.6" Type="Installer">
				<Property Name="DestinationCount" Type="Int">1</Property>
				<Property Name="Destination[0].name" Type="Str">CTE Analysis Suite UIUC</Property>
				<Property Name="Destination[0].parent" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
				<Property Name="Destination[0].tag" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Destination[0].type" Type="Str">userFolder</Property>
				<Property Name="DistPartCount" Type="Int">1</Property>
				<Property Name="DistPart[0].flavorID" Type="Str">DefaultFull</Property>
				<Property Name="DistPart[0].productID" Type="Str">{01C0F5DE-BF22-43B9-B7D9-7915B32F71F1}</Property>
				<Property Name="DistPart[0].productName" Type="Str">NI LabVIEW Run-Time Engine 2012 f3</Property>
				<Property Name="DistPart[0].upgradeCode" Type="Str">{20385C41-50B1-4416-AC2A-F7D6423A9BD6}</Property>
				<Property Name="InstSpecBitness" Type="Str">32-bit</Property>
				<Property Name="InstSpecVersion" Type="Str">12008029</Property>
				<Property Name="INST_author" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="INST_autoIncrement" Type="Bool">true</Property>
				<Property Name="INST_buildLocation" Type="Path">../builds/CTE_Analysis_Suite/CTEAS-UIUCv0.6</Property>
				<Property Name="INST_buildLocation.type" Type="Str">relativeToCommon</Property>
				<Property Name="INST_buildSpecName" Type="Str">CTEAS-UIUCv0.6</Property>
				<Property Name="INST_defaultDir" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="INST_productName" Type="Str">CTE Analysis Suite UIUC v0.6</Property>
				<Property Name="INST_productVersion" Type="Str">1.0.13</Property>
				<Property Name="MSI_arpCompany" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="MSI_arpContact" Type="Str">Waltraud M. Kriven</Property>
				<Property Name="MSI_distID" Type="Str">{AA38E6B0-967A-4988-869F-BE35BC95D17B}</Property>
				<Property Name="MSI_osCheck" Type="Int">0</Property>
				<Property Name="MSI_upgradeCode" Type="Str">{A2BFAA67-056D-47D3-94CD-BFFCF01FC8CB}</Property>
				<Property Name="MSI_windowMessage" Type="Str">Welcome to the CTE Analysis Suite Installer for UIUC Usage.</Property>
				<Property Name="MSI_windowTitle" Type="Str">CTE Analysis Suite Installation</Property>
				<Property Name="RegDestCount" Type="Int">1</Property>
				<Property Name="RegDest[0].dirName" Type="Str">Software</Property>
				<Property Name="RegDest[0].dirTag" Type="Str">{DDFAFC8B-E728-4AC8-96DE-B920EBB97A86}</Property>
				<Property Name="RegDest[0].parentTag" Type="Str">2</Property>
				<Property Name="SourceCount" Type="Int">1</Property>
				<Property Name="Source[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].FileCount" Type="Int">4</Property>
				<Property Name="Source[0].File[0].attributes" Type="Int">516</Property>
				<Property Name="Source[0].File[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[0].name" Type="Str">CTEAS-UIUCv06.exe</Property>
				<Property Name="Source[0].File[0].ShortcutCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].Shortcut[0].destIndex" Type="Int">0</Property>
				<Property Name="Source[0].File[0].Shortcut[0].name" Type="Str">CTE Analysis Suite UIUC v06</Property>
				<Property Name="Source[0].File[0].Shortcut[0].subDir" Type="Str">CTE Analysis Suite v0.6</Property>
				<Property Name="Source[0].File[0].tag" Type="Str">{AFBA233E-4D69-4081-B208-1AFEDE52B59E}</Property>
				<Property Name="Source[0].File[1].attributes" Type="Int">518</Property>
				<Property Name="Source[0].File[1].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[1].name" Type="Str">CTEAS-UIUCv06.aliases</Property>
				<Property Name="Source[0].File[1].tag" Type="Str">{1C921203-48A8-4035-9A4B-37CF1C563D04}</Property>
				<Property Name="Source[0].File[2].attributes" Type="Int">518</Property>
				<Property Name="Source[0].File[2].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[2].name" Type="Str">CTEAS-UIUCv06.ini</Property>
				<Property Name="Source[0].File[2].tag" Type="Str">{F01614B9-7BDF-4A31-BE3D-6D6C972851A9}</Property>
				<Property Name="Source[0].File[3].attributes" Type="Int">2</Property>
				<Property Name="Source[0].File[3].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[3].name" Type="Str">CTEAS.ico</Property>
				<Property Name="Source[0].File[3].tag" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="Source[0].name" Type="Str">CTE_Analysis_Suite_UIUCv0.6</Property>
				<Property Name="Source[0].tag" Type="Ref">/My Computer/Build Specifications/CTE_Analysis_Suite_UIUCv0.6</Property>
				<Property Name="Source[0].type" Type="Str">EXE</Property>
			</Item>
			<Item Name="CTEASv0.6" Type="Installer">
				<Property Name="DestinationCount" Type="Int">1</Property>
				<Property Name="Destination[0].name" Type="Str">CTE Analysis Suite</Property>
				<Property Name="Destination[0].parent" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
				<Property Name="Destination[0].tag" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Destination[0].type" Type="Str">userFolder</Property>
				<Property Name="DistPartCount" Type="Int">1</Property>
				<Property Name="DistPart[0].flavorID" Type="Str">DefaultFull</Property>
				<Property Name="DistPart[0].productID" Type="Str">{01C0F5DE-BF22-43B9-B7D9-7915B32F71F1}</Property>
				<Property Name="DistPart[0].productName" Type="Str">NI LabVIEW Run-Time Engine 2012 f3</Property>
				<Property Name="DistPart[0].upgradeCode" Type="Str">{20385C41-50B1-4416-AC2A-F7D6423A9BD6}</Property>
				<Property Name="InstSpecBitness" Type="Str">32-bit</Property>
				<Property Name="InstSpecVersion" Type="Str">12008029</Property>
				<Property Name="INST_author" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="INST_autoIncrement" Type="Bool">true</Property>
				<Property Name="INST_buildLocation" Type="Path">../builds/CTE_Analysis_Suite/CTEASv0.6</Property>
				<Property Name="INST_buildLocation.type" Type="Str">relativeToCommon</Property>
				<Property Name="INST_buildSpecName" Type="Str">CTEASv0.6</Property>
				<Property Name="INST_defaultDir" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="INST_productName" Type="Str">CTE Analysis Suite v0.6</Property>
				<Property Name="INST_productVersion" Type="Str">1.0.13</Property>
				<Property Name="MSI_arpCompany" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="MSI_arpContact" Type="Str">Waltraud M. Kriven</Property>
				<Property Name="MSI_distID" Type="Str">{812F1067-801C-4F41-AEE7-1500F6A41CDF}</Property>
				<Property Name="MSI_osCheck" Type="Int">0</Property>
				<Property Name="MSI_upgradeCode" Type="Str">{A16DFA69-8565-42CD-B73A-6E540FB04F43}</Property>
				<Property Name="MSI_windowMessage" Type="Str">Welcome to the CTE Analysis Suite Installer.</Property>
				<Property Name="MSI_windowTitle" Type="Str">CTE Analysis Suite Installation</Property>
				<Property Name="RegDestCount" Type="Int">1</Property>
				<Property Name="RegDest[0].dirName" Type="Str">Software</Property>
				<Property Name="RegDest[0].dirTag" Type="Str">{DDFAFC8B-E728-4AC8-96DE-B920EBB97A86}</Property>
				<Property Name="RegDest[0].parentTag" Type="Str">2</Property>
				<Property Name="SourceCount" Type="Int">1</Property>
				<Property Name="Source[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].FileCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[0].name" Type="Str">CTEASv06.exe</Property>
				<Property Name="Source[0].File[0].ShortcutCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].Shortcut[0].destIndex" Type="Int">0</Property>
				<Property Name="Source[0].File[0].Shortcut[0].name" Type="Str">CTE Analysis Suite v06</Property>
				<Property Name="Source[0].File[0].Shortcut[0].subDir" Type="Str">CTE Analysis Suite v0.6</Property>
				<Property Name="Source[0].File[0].tag" Type="Str">{8536D992-6D0B-4E2F-A37C-02E6F1E5F2E4}</Property>
				<Property Name="Source[0].name" Type="Str">CTE_Analysis_Suitev0.6</Property>
				<Property Name="Source[0].tag" Type="Ref">/My Computer/Build Specifications/CTE_Analysis_Suitev0.6</Property>
				<Property Name="Source[0].type" Type="Str">EXE</Property>
			</Item>
			<Item Name="CTE_Analysis_Suite_UIUCv0.61" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{4B90D10A-41B0-4A45-919D-2B7726B8B4A9}</Property>
				<Property Name="App_INI_GUID" Type="Str">{40C2C2A0-FEB6-4F65-9238-743641B1495C}</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{02E1AC50-4825-47E2-957E-F53BDCD11AB2}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">CTE_Analysis_Suite_UIUCv0.61</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.61</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{879F4355-A51C-4EA4-A34C-7C5DEE6BE2CB}</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Destination[0].destName" Type="Str">CTEAS-UIUCv061.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.61/CTEAS-UIUCv061.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suite_UIUCv0.61/data</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="SourceCount" Type="Int">6</Property>
				<Property Name="Source[0].itemID" Type="Str">{1B81C45F-690B-4451-9E76-6900BF560770}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/CTE_Analysis_Suite_UIUCv0.7.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/data</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Container</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].Container.applyDestination" Type="Bool">true</Property>
				<Property Name="Source[4].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/CTEAS_InputMaker</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">Container</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/CTE_Analysis_Suitev0.6.vi</Property>
				<Property Name="Source[5].type" Type="Str">VI</Property>
				<Property Name="TgtF_companyName" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_fileDescription" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_fileVersion.build" Type="Int">1</Property>
				<Property Name="TgtF_fileVersion.minor" Type="Int">6</Property>
				<Property Name="TgtF_fileVersion.patch" Type="Int">1</Property>
				<Property Name="TgtF_internalName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2011 The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_productName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{401EA7F5-BD10-430B-BEF6-422511EEE08D}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">CTEAS-UIUCv061.exe</Property>
			</Item>
			<Item Name="CTE_Analysis_Suitev0.61" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{05153256-7072-4F0E-B200-B62243AF43F9}</Property>
				<Property Name="App_INI_GUID" Type="Str">{2A521693-52EE-4FFB-83D6-B470C80068D6}</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{CB4F4533-4AD3-45F0-9370-7422F3CF5748}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">CTE_Analysis_Suitev0.61</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.61</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{23F5F786-E924-48F7-8BAD-9C2EE4C8D70B}</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Destination[0].destName" Type="Str">CTEASv061.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.61/CTEASv061.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/CTE_Analysis_Suitev0.61/data</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="SourceCount" Type="Int">6</Property>
				<Property Name="Source[0].itemID" Type="Str">{1B81C45F-690B-4451-9E76-6900BF560770}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/CTE_Analysis_Suite_UIUCv0.7.vi</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/data</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Container</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/CTEAS.ico</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].Container.applyDestination" Type="Bool">true</Property>
				<Property Name="Source[4].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/CTEAS_InputMaker</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">Container</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/CTE_Analysis_Suitev0.6.vi</Property>
				<Property Name="Source[5].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[5].type" Type="Str">VI</Property>
				<Property Name="TgtF_companyName" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_fileDescription" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_fileVersion.build" Type="Int">1</Property>
				<Property Name="TgtF_fileVersion.minor" Type="Int">6</Property>
				<Property Name="TgtF_fileVersion.patch" Type="Int">1</Property>
				<Property Name="TgtF_internalName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2011 The University of Illinois, Urbana-Champaign</Property>
				<Property Name="TgtF_productName" Type="Str">CTE_Analysis_Suite v0.61</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{F96FAF9B-4446-4D91-AD0C-A676A11B9EA5}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">CTEASv061.exe</Property>
			</Item>
			<Item Name="CTEAS-UIUCv0.61" Type="Installer">
				<Property Name="DestinationCount" Type="Int">1</Property>
				<Property Name="Destination[0].name" Type="Str">CTE Analysis Suite UIUC</Property>
				<Property Name="Destination[0].parent" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
				<Property Name="Destination[0].tag" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Destination[0].type" Type="Str">userFolder</Property>
				<Property Name="DistPartCount" Type="Int">1</Property>
				<Property Name="DistPart[0].flavorID" Type="Str">DefaultFull</Property>
				<Property Name="DistPart[0].productID" Type="Str">{01C0F5DE-BF22-43B9-B7D9-7915B32F71F1}</Property>
				<Property Name="DistPart[0].productName" Type="Str">NI LabVIEW Run-Time Engine 2012 f3</Property>
				<Property Name="DistPart[0].upgradeCode" Type="Str">{20385C41-50B1-4416-AC2A-F7D6423A9BD6}</Property>
				<Property Name="InstSpecBitness" Type="Str">32-bit</Property>
				<Property Name="InstSpecVersion" Type="Str">12008029</Property>
				<Property Name="INST_author" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="INST_autoIncrement" Type="Bool">true</Property>
				<Property Name="INST_buildLocation" Type="Path">../builds/CTE_Analysis_Suite/CTEAS-UIUCv0.61</Property>
				<Property Name="INST_buildLocation.type" Type="Str">relativeToCommon</Property>
				<Property Name="INST_buildSpecName" Type="Str">CTEAS-UIUCv0.61</Property>
				<Property Name="INST_defaultDir" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="INST_productName" Type="Str">CTE Analysis Suite UIUC v0.61</Property>
				<Property Name="INST_productVersion" Type="Str">1.0.15</Property>
				<Property Name="MSI_arpCompany" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="MSI_arpContact" Type="Str">Waltraud M. Kriven</Property>
				<Property Name="MSI_distID" Type="Str">{25BB67A1-EB0E-433E-8D73-52147EF2084A}</Property>
				<Property Name="MSI_osCheck" Type="Int">0</Property>
				<Property Name="MSI_upgradeCode" Type="Str">{0B0F06FD-4048-4F40-A84D-A49A060AA641}</Property>
				<Property Name="MSI_windowMessage" Type="Str">Welcome to the CTE Analysis Suite Installer for UIUC Usage.</Property>
				<Property Name="MSI_windowTitle" Type="Str">CTE Analysis Suite Installation</Property>
				<Property Name="RegDestCount" Type="Int">1</Property>
				<Property Name="RegDest[0].dirName" Type="Str">Software</Property>
				<Property Name="RegDest[0].dirTag" Type="Str">{DDFAFC8B-E728-4AC8-96DE-B920EBB97A86}</Property>
				<Property Name="RegDest[0].parentTag" Type="Str">2</Property>
				<Property Name="SourceCount" Type="Int">1</Property>
				<Property Name="Source[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].FileCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[0].name" Type="Str">CTEAS-UIUCv061.exe</Property>
				<Property Name="Source[0].File[0].ShortcutCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].Shortcut[0].destIndex" Type="Int">0</Property>
				<Property Name="Source[0].File[0].Shortcut[0].name" Type="Str">CTE Analysis Suite v061</Property>
				<Property Name="Source[0].File[0].Shortcut[0].subDir" Type="Str">CTE Analysis Suite UIUC v0.61</Property>
				<Property Name="Source[0].File[0].tag" Type="Str">{401EA7F5-BD10-430B-BEF6-422511EEE08D}</Property>
				<Property Name="Source[0].name" Type="Str">CTE_Analysis_Suite_UIUCv0.61</Property>
				<Property Name="Source[0].tag" Type="Ref">/My Computer/Build Specifications/CTE_Analysis_Suite_UIUCv0.61</Property>
				<Property Name="Source[0].type" Type="Str">EXE</Property>
			</Item>
			<Item Name="CTEASv0.61" Type="Installer">
				<Property Name="DestinationCount" Type="Int">1</Property>
				<Property Name="Destination[0].name" Type="Str">CTE Analysis Suite</Property>
				<Property Name="Destination[0].parent" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
				<Property Name="Destination[0].tag" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Destination[0].type" Type="Str">userFolder</Property>
				<Property Name="DistPartCount" Type="Int">1</Property>
				<Property Name="DistPart[0].flavorID" Type="Str">DefaultFull</Property>
				<Property Name="DistPart[0].productID" Type="Str">{01C0F5DE-BF22-43B9-B7D9-7915B32F71F1}</Property>
				<Property Name="DistPart[0].productName" Type="Str">NI LabVIEW Run-Time Engine 2012 f3</Property>
				<Property Name="DistPart[0].upgradeCode" Type="Str">{20385C41-50B1-4416-AC2A-F7D6423A9BD6}</Property>
				<Property Name="InstSpecBitness" Type="Str">32-bit</Property>
				<Property Name="InstSpecVersion" Type="Str">12008029</Property>
				<Property Name="INST_author" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="INST_autoIncrement" Type="Bool">true</Property>
				<Property Name="INST_buildLocation" Type="Path">../builds/CTE_Analysis_Suite/CTEASv0.61</Property>
				<Property Name="INST_buildLocation.type" Type="Str">relativeToCommon</Property>
				<Property Name="INST_buildSpecName" Type="Str">CTEASv0.61</Property>
				<Property Name="INST_defaultDir" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="INST_productName" Type="Str">CTE Analysis Suite v0.61</Property>
				<Property Name="INST_productVersion" Type="Str">1.0.14</Property>
				<Property Name="MSI_arpCompany" Type="Str">The University of Illinois, Urbana-Champaign</Property>
				<Property Name="MSI_arpContact" Type="Str">Waltraud M. Kriven</Property>
				<Property Name="MSI_distID" Type="Str">{E5565C55-EFE3-472F-91FE-AB53F47E5205}</Property>
				<Property Name="MSI_osCheck" Type="Int">0</Property>
				<Property Name="MSI_upgradeCode" Type="Str">{5F2C8D90-E319-4173-ADD7-C64A980DC4BD}</Property>
				<Property Name="MSI_windowMessage" Type="Str">Welcome to the CTE Analysis Suite Installer.</Property>
				<Property Name="MSI_windowTitle" Type="Str">CTE Analysis Suite Installation</Property>
				<Property Name="RegDestCount" Type="Int">1</Property>
				<Property Name="RegDest[0].dirName" Type="Str">Software</Property>
				<Property Name="RegDest[0].dirTag" Type="Str">{DDFAFC8B-E728-4AC8-96DE-B920EBB97A86}</Property>
				<Property Name="RegDest[0].parentTag" Type="Str">2</Property>
				<Property Name="SourceCount" Type="Int">1</Property>
				<Property Name="Source[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].FileCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].dest" Type="Str">{6A92FEE9-495A-43B0-B12B-EAC8312050CC}</Property>
				<Property Name="Source[0].File[0].name" Type="Str">CTEASv061.exe</Property>
				<Property Name="Source[0].File[0].ShortcutCount" Type="Int">1</Property>
				<Property Name="Source[0].File[0].Shortcut[0].destIndex" Type="Int">0</Property>
				<Property Name="Source[0].File[0].Shortcut[0].name" Type="Str">CTE Analysis Suite v0.61</Property>
				<Property Name="Source[0].File[0].Shortcut[0].subDir" Type="Str">CTE Analysis Suite v0.61</Property>
				<Property Name="Source[0].File[0].tag" Type="Str">{F96FAF9B-4446-4D91-AD0C-A676A11B9EA5}</Property>
				<Property Name="Source[0].name" Type="Str">CTE_Analysis_Suitev0.61</Property>
				<Property Name="Source[0].tag" Type="Ref">/My Computer/Build Specifications/CTE_Analysis_Suitev0.61</Property>
				<Property Name="Source[0].type" Type="Str">EXE</Property>
			</Item>
		</Item>
	</Item>
</Project>
