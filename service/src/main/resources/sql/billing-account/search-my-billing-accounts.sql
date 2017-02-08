SELECT
  SKIP {offset}
  FIRST {limit}
       p.project_id as id, p.name as name, pt.payment_terms_id as paymentTerms_Id,
       pt.description as paymentTerms_Description,
       ps.name as status, p.sales_tax as salesTax, p.po_box_number as poNumber,
       p.start_date as startDate, p.end_date as endDate, p.budget as amount,
       p.creation_date as createdAt, p.creation_user as createdBy,
       p.modification_date as updatedAt, p.modification_user as updatedBy
FROM tc_direct_project tdp, direct_project_account dpa, tt_project p, time_oltp\:payment_terms pt, user_permission_grant upg, project_status_lu ps
WHERE tdp.project_id = dpa.project_id
AND dpa.billing_account_id = p.project_id
AND pt.payment_terms_id = p.payment_terms_id
AND ps.project_status_id = p.project_status_id
AND tdp.project_id = upg.resource_id
AND upg.user_id = :loggedInUser
AND {filter}
ORDER BY
  {order}