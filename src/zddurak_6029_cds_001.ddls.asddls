@AbapCatalog.sqlViewName: 'ZDURAK_6029_V001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS TS1'

 define view zddurak_6029_cds_001
  as select from ekko
    inner join ekpo on ekko.ebeln = ekpo.ebeln
    left outer join mara on mara.matnr = ekpo.matnr
    left outer join makt on makt.matnr = mara.matnr and makt.spras = $session.system_language
    left outer join lfa1 on lfa1.lifnr = ekko.lifnr
   {
    key ekpo.ebeln,
    key ekpo.ebelp,
    ekpo.matnr,
    makt.maktx,
    ekpo.werks,
    ekpo.lgort,
    ekpo.meins,
    lfa1.lifnr,
    lfa1.name1,
    concat(lfa1.stras, lfa1.mcod3)as satici_adresi
  }
  
