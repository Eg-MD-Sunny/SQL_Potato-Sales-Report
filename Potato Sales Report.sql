Select cast(dbo.ToBdt(s.ReconciledOn)as date) [Date],
	   pv.id [PVID],
	   pv.name [Product],
	   Count(*) [Sale Quantity]

from ProductVariant pv
join ThingRequest tr on tr.ProductVariantId=pv.id
join thing t on t.id=tr.AssignedThingId
join Shipment s on s.id=tr.ShipmentId

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-07-30 00:00 +06:00'
and s.ReconciledOn < '2022-08-05 00:00 +06:00'
and pv.ShelfType in (5,9)
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and pv.id in (10944)

group by cast(dbo.ToBdt(s.ReconciledOn)as date),
         pv.id,
		 pv.name

order by 1 asc


--select *
--from ProductVariant pv
--where pv.name like '%Potato%' and pv.name like '%Special%'
