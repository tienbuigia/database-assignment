/*
So the answer is SalesOrderID.
This item is clustered index on both header and detail so it wont need to combine things.
If not select this item sqlserver will using hash match to customerid.

explain plan:
6: quet clustered index ca bang
5: tinh LineTotal
4: tinh xem LineTotal co NULL hay ko, co thi gan gia tri 0.0
3: ?
2: quet b tree index clustered bang header
1: inner join 2 bang detail va header.
*/

select *
from (
	select 
		DENSE_RANK() over (partition by Nam order by TongGiaTriHoaDon desc) as rank_Number,
		CustomerID, Nam, TongGiaTriHoaDon
	from (
		select 
			CustomerID,
			-- SalesOrderID,
			year(ThongKeGiaTriHoaDon_KhachHang.ModifiedDate) as Nam,
			sum(ThongKeGiaTriHoaDon_KhachHang.GiaTriHoaDon) as TongGiaTriHoaDon
		from (
			select CustomerID, 
				SOH.SalesOrderID, 
				SOH.ModifiedDate, sum(LineTotal) as GiaTriHoaDon
				from Sales.SalesOrderHeader SOH, Sales.SalesOrderDetail SOD
				where SOH.SalesOrderID = SOD.SalesOrderID
				group by SOH.SalesOrderID, CustomerID, SOH.ModifiedDate
			) as ThongKeGiaTriHoaDon_KhachHang
		group by CustomerID, year(ModifiedDate)--, SalesOrderID
		) as ThongKeTongGiaTriHoaDon_KhachHang
	) ThongKeTongGiaTriHoaDon_KhachHangs1
where rank_Number < 6;

-- #test 1
SELECT *
FROM (
	SELECT
		DENSE_RANK () OVER (
			PARTITION BY Nam
			ORDER BY TongGiaTriHoaDon DESC) rankNumber,
		CustomerID, Nam, TongGiaTriHoaDon
	FROM (
		SELECT 
			CustomerID,
			-- SalesOrderID,
			Nam,
			SUM(GiaTriHoaDon) TongGiaTriHoaDon
		FROM (
			select 
				CustomerID, 
				SOH.SalesOrderID, 
				year(SOH.ModifiedDate) as Nam, 
				sum(LineTotal) as GiaTriHoaDon
			from Sales.SalesOrderDetail SOD 
				join Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID
			group by CustomerID, SOH.SalesOrderID, SOH.ModifiedDate
			) ThongKeGiaTriHoaDon_KhacHang
		GROUP BY CustomerID, SalesOrderID, Nam
		) ThongKeTongGiaTriHoaDon_KhacHang
	) ThongKeTongGiaTriHoaDon_KhacHang1
WHERE rankNumber < 6;

-- #test 2
select CustomerID,
	year(ThongKeGiaTriHoaDon_KhachHang.ModifiedDate) as Nam,
	sum(ThongKeGiaTriHoaDon_KhachHang.GiaTriHoaDon) as TongGiaTriHoaDon
from (	select CustomerID, SOH.SalesOrderID, SOH.ModifiedDate, sum(LineTotal) as GiaTriHoaDon
		from Sales.SalesOrderHeader SOH, Sales.SalesOrderDetail SOD
		where SOH.SalesOrderID = SOD.SalesOrderID
		group by SOH.SalesOrderID, CustomerID, SOH.ModifiedDate) as ThongKeGiaTriHoaDon_KhachHang
group by CustomerID, year(ModifiedDate);