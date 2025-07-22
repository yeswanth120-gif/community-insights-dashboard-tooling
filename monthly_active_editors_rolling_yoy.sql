SELECT
    edit_year,
    edit_month,
    COUNT(*) AS active_editors
FROM (
    -- subquery to idnetify active editors
    SELECT
    -- Extract year and month fromrev_timestamp
        YEAR(STR_TO_DATE(r.rev_timestamp, '%Y%m%d%H%i%s')) AS edit_year,
        MONTH(STR_TO_DATE(r.rev_timestamp, '%Y%m%d%H%i%s')) AS edit_month,
        a.actor_user,
        COUNT(r.rev_id) AS edit_count
    FROM revision r    
    JOIN actor a ON r.rev_actor = a.actor_id
    -- Filter: only include edits from the last 12 months
    WHERE STR_TO_DATE(r.rev_timestamp, '%Y%m%d%H%i%s') >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
    GROUP BY edit_year, edit_month, a.actor_user
    -- only include editors with at least 5 edits
    HAVING COUNT(r.rev_id) >= 5
)AS filtered_editors
GROUP BY edit_year, edit_month,
ORDER BY edit_year, edit_month;  