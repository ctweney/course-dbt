select PRODUCT_ID,
	NAME,
	PRICE FLOAT,
	INVENTORY
from {{ source('postgres', 'products') }}
