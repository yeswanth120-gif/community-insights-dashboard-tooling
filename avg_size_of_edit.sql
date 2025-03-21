SELECT
  AVG(ABS(CAST(r.rev_len AS SIGNED) - CAST(p.rev_len AS SIGNED))) AS avg_edit_size
FROM (revision r
JOIN revision p ON r.rev_parent_id = p.rev_id
JOIN (
  SELECT rev_actor, COUNT(*) AS edit_count
  FROM revision     # number of edits done by user
  GROUP BY rev_actor
) AS user_edits ON r.rev_actor = user_edits.rev_actor)
where user_edits.edit_count between 11 and 50    # we can change range of edits 
;