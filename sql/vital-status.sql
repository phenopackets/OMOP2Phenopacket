SELECT d.person_id,
       (case when d.person_id is null then 0 else 2 end) as vital_status,
       d.death_datetime as time_of_death,
       (case when c.concept_code is null then null else concat(c.vocabulary_id,':',c.concept_code) end) as cause_of_death_id,
       c.concept_name as cause_of_death_label
FROM cdm_synthea10.person p
         LEFT JOIN cdm_synthea10.death d on d.person_id = p.person_id
         LEFT JOIN cdm_synthea10.condition_occurrence co on co.person_id = p.person_id and co.condition_concept_id = d.cause_concept_id
         LEFT JOIN cdm_synthea10.concept c on c.concept_id = d.cause_concept_id
GROUP BY d.person_id, vital_status, time_of_death, cause_of_death_id, cause_of_death_label
ORDER BY d.person_id asc;