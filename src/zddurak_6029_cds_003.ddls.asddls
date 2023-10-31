@AbapCatalog.sqlViewName: 'ZDURAK_6029_V003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS TS2 - 2'
define view zddurak_6029_cds_003
  as select from zddurak_6029_cds_002 as invoice
  left outer join vbrk on vbrk.vbeln = invoice.vbeln
{

  invoice.vbeln,
  sum( invoice.conversion_netwr ) as totalNetValue,
  invoice.kunnrAd,
  count ( * )                     as totalInvoiceNumber,
  cast((
         cast(sum( invoice.conversion_netwr) as abap.decfloat34) / cast(count( * ) as abap.decfloat34)
      ) as abap.dec( 23, 2 ) )   as avgAmount,
  
  invoice.fkdat,
  substring(invoice.fkdat, 1, 4 ) as faturalamaYili,
  substring(invoice.fkdat, 5, 2 ) as faturalamaAyi,
  substring(invoice.fkdat, 7, 2 ) as faturalamaGunu,
  substring(vbrk.inco2_l,1, 3 ) as incotermYeri

} 

group by
  invoice.vbeln,
  invoice.kunnrAd,
  invoice.fkdat,
  vbrk.inco2_l
