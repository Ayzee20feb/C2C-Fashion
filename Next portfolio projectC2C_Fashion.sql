
                    --Analyze a fashion brand dataset

     --create database [C2C_Fashion]

     --use  [C2C_Fashion]

                    select * from [dbo].['6M-0K-99K#users#dataset#public$']

                    select * from [dbo].['Buyers-repartition-by-country$']

					
				    --Data Modifying

				  Select *,
			      CONCAT([femalebuyers],[malebuyers]) from [dbo].['Buyers-repartition-by-country$']
				  Order by [country]	

				 update  [dbo].['6M-0K-99K#users#dataset#public$']
				 Set country='Spain' where country= 'Espagne' 

                 update  [dbo].['Buyers-repartition-by-country$']
				 Set country='Spain' where country= 'Espagne'  
		
			     Delete from [dbo].['Buyers-repartition-by-country$']   where country='Guadeloupe'
					 
					 --Join concerned columns to analysis from both tables

                 Select distinct
                 a.[country],
				 a.[socialProductsLiked],
				 a.[productsSold],
				 a.[productsPassRate],
				 a.[productsWished],
				 a.[productsBought],
				 a.[gender],
				 b.[topbuyers],
				 b.[boughtperwishlistratio],
				 b.[boughtperlikeratio],
				 b.[totalproductswished],
				 b.[totalproductsliked],
                 b.[totalproductsbought],
				 a.productsListed
				 from [dbo].['6M-0K-99K#users#dataset#public$'] as a
				 Join [dbo].['Buyers-repartition-by-country$'] as b
				 on a.country=b.country
			     order by  b.[totalproductsbought] desc	;


				       
				     --Creating a view of a joined table to use it in further analysis

				     
				 create view C2C_Fashion_view as
				   Select distinct
                 a.[country],
				 a.[socialProductsLiked],
				 a.[productsSold],
				 a.[productsPassRate],
				 a.[productsWished],
				 a.[productsBought],
				 a.[gender],
				 b.[topbuyers],
				 b.[boughtperwishlistratio],
				 b.[boughtperlikeratio],
				 b.[totalproductswished],
				 b.[totalproductsliked],
                 b.[totalproductsbought],
				 a.productsListed
				 from [dbo].['6M-0K-99K#users#dataset#public$'] as a
				 Join [dbo].['Buyers-repartition-by-country$'] as b
				 on a.country=b.country;
			
				     
					 -- Create 2nd view
				
				Create view View2_Fashion_C2C  as 
				select
				country,
				SUM([productsWished])as WishlistProducts_total,
				SUM([socialProductsLiked])as LikedProducts_Total,
				Sum([productsPassRate]) as ProductsPassRate_Total,
				Sum([productsBought])as ProductsBought_total,
                Sum([productsListed]) as listedItems_Total
				from [dbo].[C2C_Fashion_view]
				group by country
				
	
				    --Analyze the selected data
				
				Select * from [dbo].[View2_Fashion_C2C]
				order by ProductsBought_total desc


				Select sum([ProductsBought_total]) from [dbo].[View2_Fashion_C2C]
				
                Select Sum([WishlistProducts_total])+Sum([LikedProducts_Total]) from [dbo].[View2_Fashion_C2C]
				

				
				--Case Statement for furthur analysis 
				
				Select *,
				Case
				When [ProductsBought_total]<[listedItems_Total] then 'Low Purchase then Items offered'
				Else ''
				End Purchase
				From [dbo].[View2_Fashion_C2C]
				Order by Purchase desc
				

				