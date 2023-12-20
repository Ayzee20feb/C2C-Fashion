 --Analyze Sellers Performence

Select * from [dbo].['Comparison-of-Sellers-by-Gender$']

        --Cleaning & Modifying the data

 Alter table [dbo].['Comparison-of-Sellers-by-Gender$']
 Add Gender  int
 
 Alter table [dbo].['Comparison-of-Sellers-by-Gender$']
 Drop column [Gender]

 Delete [dbo].['Comparison-of-Sellers-by-Gender$'] where  country='Martinique' and [country]='0'
 
 Update [dbo].['Comparison-of-Sellers-by-Gender$']
 Set [country]='Canary Islands' where [country]='Îles Canaries'

  Update [dbo].['Comparison-of-Sellers-by-Gender$']
 Set [country]='Ukrain' where [country]='Ukraine'

  Select * from [dbo].[Sellers_Performence]
   
        --Statistical analysis

 Select [country],sum([nbsellers]) from [dbo].['Comparison-of-Sellers-by-Gender$']
 Group by [country]

  Select [country],Count([sex]) from [dbo].['Comparison-of-Sellers-by-Gender$']
  Group by [country]

 Select [country],[sex],[nbsellers] as  #OfSellersPerGender,[totalproductslisted],[totalproductssold],[totalwished],[totalproductsliked]
 From [dbo].['Comparison-of-Sellers-by-Gender$']
 Order by [totalproductssold] desc


         --Create a view
 Drop view [dbo].[Sellers_Performence]
 
 Create view Sellers_Performence as
  Select [country],[sex],[nbsellers] as  #OfSellersPerGender,[totalproductslisted],[totalproductssold],[totalwished],[totalproductsliked]
 From [dbo].['Comparison-of-Sellers-by-Gender$']

 Select * from [dbo].[Sellers_Performence]
 Order by [totalproductssold] desc


        --Using Case statement to analyze the less performers
 Select *,
 Case
 When [totalproductslisted] < [totalproductssold] then ''
 else [sex]
 end as 'Less_Performers'
 From [dbo].[Sellers_Performence]
 order by 'Less_Performers' desc


       --Analyze total performence by gender
 Select [sex],
 Sum([#OfSellersPerGender]) as [#OfSellersPerGender], 
 Sum([totalproductslisted])as[totalproductslisted],
 Sum([totalproductssold]) as [totalproductssold],
 Sum([totalwished]) as [totalwished],
 Sum([totalproductsliked]) as [totalproductsliked]
 from [dbo].[Sellers_Performence]
 Group by [sex]

       --Analyze total performence by Country

  Select [country],
 Sum([#OfSellersPerGender]) as [#OfSellersPerGender], 
 Sum([totalproductslisted])as[totalproductslisted],
 Sum([totalproductssold]) as [totalproductssold],
 Sum([totalwished]) as [totalwished],
 Sum([totalproductsliked]) as [totalproductsliked]
 from [dbo].[Sellers_Performence]
 Group by [country]




 Select * from [dbo].[Sellers_Performence]
 Order by [country] 