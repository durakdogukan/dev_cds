@AbapCatalog.sqlViewName: 'ZDURAK_6029_V002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS TS2 - 1'

define view zddurak_6029_cds_002
  as select from vbrp
    inner join vbrk on vbrk.vbeln = vbrp.vbeln
    inner join mara on mara.matnr = vbrp.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
    left outer join makt on makt.matnr = mara.matnr and
                            makt.spras = $session.system_language
{
    key vbrp.vbeln,
    key vbrp.posnr,
    
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    concat_with_space(kna1.name1, kna1.name2, 1) as kunnrAd,
    cast(currency_conversion( amount             => vbrp.netwr,
                         source_currency    => vbrk.waerk,
                         target_currency    => cast('EUR' as abap.cuky),
                         exchange_rate_date => vbrk.fkdat
                       ) as abap.dec(23,2)) as conversion_netwr,
                       
    left(kna1.kunnr, 3) as left_kunnr,
    length(mara.matnr) as matnr_length,
    
    case vbrk.fkart 
        when 'FAS' then 'Peşinat talebi iptali'
        when 'FAZ' then 'Peşinat talebi'
        else 'Fatura'
    end as invoiceType,   
    
    vbrk.fkdat 
    
}
