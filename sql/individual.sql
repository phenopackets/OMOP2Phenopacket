SELECT p.person_id::text as id,
        null as alternate_ids,
       p.birth_datetime as date_of_birth,
       max(vo.visit_start_date) as time_at_last_encounter,
       (case when d.person_id is null then 0 else 2 end) as vital_status,
       (case when p.gender_concept_id is null then 0
             when p.gender_concept_id = 8532 then 1
             when p.gender_concept_id = 8507 then 2
             else 3 end) as sex,
       null as karyotypic_sex,
       null as gender,
    'NCBITaxon:9606' as taxonomy_id,
    'human' as taxonomy_label
FROM cdm_synthea10.person p
    LEFT JOIN cdm_synthea10.visit_occurrence vo on vo.person_id = p.person_id
    LEFT JOIN cdm_synthea10.death d on d.person_id = p.person_id
GROUP BY p.person_id, p.birth_datetime, vital_status, sex
ORDER BY p.person_id asc;
SELECT p.person_id::text as id,
        null as alternate_ids,
       p.birth_datetime as date_of_birth,
       max(vo.visit_start_date) as time_at_last_encounter,
       (case when d.person_id is null then 0 else 2 end) as vital_status,
       (case when p.gender_concept_id is null then 0
             when p.gender_concept_id = 8532 then 1
             when p.gender_concept_id = 8507 then 2
             else 3 end) as sex,
       null as karyotypic_sex,
       null as gender,
    'NCBITaxon:9606' as taxonomy_id,
    'human' as taxonomy_label
FROM cdm_synthea10.person p
    LEFT JOIN cdm_synthea10.visit_occurrence vo on vo.person_id = p.person_id
    LEFT JOIN cdm_synthea10.death d on d.person_id = p.person_id
GROUP BY p.person_id, p.birth_datetime, vital_status, sex
ORDER BY p.person_id asc;
