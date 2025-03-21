SELECT 
    page_title, -- Retrives the little of the pager
    page_len    -- Retrives the length of the page in bytes
FROM 
    page 
WHERE 
    page_namespace = 0  --Filters results to include only pages in the main namespace

LIMIT 25;