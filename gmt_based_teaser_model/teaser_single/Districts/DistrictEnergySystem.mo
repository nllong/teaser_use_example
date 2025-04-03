within teaser_single.Districts;
model DistrictEnergySystem
  extends Modelica.Icons.Example;
  // District Parameters
  package MediumW=Buildings.Media.Water
    "Source side medium";
  package MediumA=Buildings.Media.Air
    "Load side medium";

  // TODO: dehardcode these
  parameter Modelica.Units.SI.TemperatureDifference delChiWatTemDis(displayUnit="degC")=7;
  parameter Modelica.Units.SI.TemperatureDifference delChiWatTemBui(displayUnit="degC")=5;
  parameter Modelica.Units.SI.TemperatureDifference delHeaWatTemDis(displayUnit="degC")=12;
  parameter Modelica.Units.SI.TemperatureDifference delHeaWatTemBui(displayUnit="degC")=5;
  parameter Integer numberofchillers = 2;

  // Models

  //
  // Begin Model Instance for TeaserLoad_B5a6b99ec37f4de7f94020090
  // Source template: /model_connectors/load_connectors/templates/Teaser_Instance.mopt
  //
  Loads.B5a6b99ec37f4de7f94020090.building TeaserLoad_B5a6b99ec37f4de7f94020090(
    nPorts_aHeaWat=1,
    nPorts_bHeaWat=1,
    nPorts_aChiWat=1,
    nPorts_bChiWat=1)
    "Building with thermal loads as TEASER zones"
    annotation (Placement(transformation(extent={{50.0,30.0},{70.0,50.0}})));
  //
  // End Model Instance for TeaserLoad_B5a6b99ec37f4de7f94020090
  //


  
  //
  // Begin Model Instance for etsHotWatStub_677e5958
  // Source template: /model_connectors/energy_transfer_systems/templates/EtsHotWaterStub_Instance.mopt
  //
  // TODO: move these components into a single component
  Buildings.Fluid.Sources.Boundary_pT supHeaWat_etsHotWatStub_677e5958(
    redeclare package Medium=MediumW,
    use_T_in=true,
    nPorts=1)
    "Heating water supply"
    annotation (Placement(transformation(extent={{10.0,-10.0},{30.0,10.0}})));
  Buildings.Fluid.Sources.Boundary_pT sinHeaWat_etsHotWatStub_677e5958(
    redeclare package Medium=MediumW,
    nPorts=1)
    "Heating water sink"
    annotation (Placement(transformation(extent={{50.0,-10.0},{70.0,10.0}})));
  //
  // End Model Instance for etsHotWatStub_677e5958
  //


  
  //
  // Begin Model Instance for etsColWatStub_72bd9314
  // Source template: /model_connectors/energy_transfer_systems/templates/EtsColdWaterStub_Instance.mopt
  //
  // TODO: move these components into a single component
  Buildings.Fluid.Sources.Boundary_pT supChiWat_etsColWatStub_72bd9314(
    redeclare package Medium=MediumW,
    use_T_in=true,
    nPorts=1)
    "Chilled water supply"
    annotation (Placement(transformation(extent={{-70.0,-50.0},{-50.0,-30.0}})));
  Buildings.Fluid.Sources.Boundary_pT sinChiWat_etsColWatStub_72bd9314(
    redeclare package Medium=MediumW,
    nPorts=1)
    "Chilled water sink"
    annotation (Placement(transformation(extent={{-30.0,-50.0},{-10.0,-30.0}})));
  //
  // End Model Instance for etsColWatStub_72bd9314
  //


  

  // Model dependencies

  //
  // Begin Component Definitions for 4ff12520
  // Source template: /model_connectors/couplings/templates/Teaser_EtsHotWaterStub/ComponentDefinitions.mopt
  //
  Modelica.Blocks.Sources.RealExpression THeaWatSup_4ff12520(
    y=max(
      TeaserLoad_B5a6b99ec37f4de7f94020090.terUni.T_aHeaWat_nominal))
    "Heating water supply temperature"
    annotation (Placement(transformation(extent={{-70.0,-10.0},{-50.0,10.0}})));

  //
  // End Component Definitions for 4ff12520
  //



  //
  // Begin Component Definitions for 1201276d
  // Source template: /model_connectors/couplings/templates/Teaser_EtsColdWaterStub/ComponentDefinitions.mopt
  //
  Modelica.Blocks.Sources.RealExpression TChiWatSup_1201276d(
    y=min(
      TeaserLoad_B5a6b99ec37f4de7f94020090.terUni.T_aChiWat_nominal))
    "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-30.0,-10.0},{-10.0,10.0}})));

  //
  // End Component Definitions for 1201276d
  //



equation
  // Connections

  //
  // Begin Connect Statements for 4ff12520
  // Source template: /model_connectors/couplings/templates/Teaser_EtsHotWaterStub/ConnectStatements.mopt
  //

  // teaser, ets hot water stub connections
  connect(supHeaWat_etsHotWatStub_677e5958.T_in,THeaWatSup_4ff12520.y)
    annotation (Line(points={{16.8799537170364,21.94311259856177},{-3.1200462829635995,21.94311259856177},{-23.1200462829636,21.94311259856177},{-43.1200462829636,21.94311259856177},{-43.1200462829636,1.9431125985617683},{-63.1200462829636,1.9431125985617683}},color={0,0,127}));
  connect(supHeaWat_etsHotWatStub_677e5958.ports[1],TeaserLoad_B5a6b99ec37f4de7f94020090.ports_aHeaWat[1])
    annotation (Line(points={{24.43505441850654,29.27518026137055},{24.43505441850654,49.27518026137055},{44.435054418506525,49.27518026137055},{64.43505441850652,49.27518026137055}},color={0,0,127}));
  connect(sinHeaWat_etsHotWatStub_677e5958.ports[1],TeaserLoad_B5a6b99ec37f4de7f94020090.ports_bHeaWat[1])
    annotation (Line(points={{62.06159090476115,23.998376274684688},{62.06159090476115,43.99837627468469}},color={0,0,127}));

  //
  // End Connect Statements for 4ff12520
  //



  //
  // Begin Connect Statements for 1201276d
  // Source template: /model_connectors/couplings/templates/Teaser_EtsColdWaterStub/ConnectStatements.mopt
  //

  // teaser, ets cold water stub connections
  connect(TChiWatSup_1201276d.y,supChiWat_etsColWatStub_72bd9314.T_in)
    annotation (Line(points={{-25.93908017163716,-12.466843040542983},{-45.93908017163716,-12.466843040542983},{-45.93908017163716,-32.46684304054298},{-65.93908017163716,-32.46684304054298}},color={0,0,127}));
  connect(supChiWat_etsColWatStub_72bd9314.ports[1],TeaserLoad_B5a6b99ec37f4de7f94020090.ports_aChiWat[1])
    annotation (Line(points={{-69.94388829303585,-15.70246982106002},{-49.943888293035855,-15.70246982106002},{-49.943888293035855,4.297530178939979},{-49.943888293035855,24.297530178939972},{-49.943888293035855,44.29753017893997},{-29.943888293035855,44.29753017893997},{-9.943888293035855,44.29753017893997},{10.056111706964145,44.29753017893997},{30.056111706964145,44.29753017893997},{50.056111706964145,44.29753017893997}},color={0,0,127}));
  connect(sinChiWat_etsColWatStub_72bd9314.ports[1],TeaserLoad_B5a6b99ec37f4de7f94020090.ports_bChiWat[1])
    annotation (Line(points={{-21.093523904422668,-24.102487717754414},{-1.0935239044226677,-24.102487717754414},{-1.0935239044226677,-4.102487717754414},{-1.0935239044226677,15.897512282245586},{-1.0935239044226677,35.897512282245586},{18.906476095577332,35.897512282245586},{38.90647609557735,35.897512282245586},{58.90647609557735,35.897512282245586}},color={0,0,127}));

  //
  // End Connect Statements for 1201276d
  //




annotation(
  experiment(
    StopTime=86400,
    Interval=3600,
    Tolerance=1e-06),
  Diagram(
    coordinateSystem(
      preserveAspectRatio=false,
      extent={{-90.0,-70.0},{90.0,70.0}})),
  Documentation(
    revisions="<html>
 <li>
 May 10, 2020: Hagar Elarga<br/>
Updated implementation to handle template needed for GeoJSON to Modelica.
</li>
</html>"));
end DistrictEnergySystem;