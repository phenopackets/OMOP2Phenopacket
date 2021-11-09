select m.person_id,
       m.measurement_concept_id,
       concat(c.vocabulary_id,':',c.concept_code) as assay_id,
       c.concept_name as assay_label,
       m.value_as_number as value,
       m.range_low,
       m.range_high,
       m.measurement_datetime,
/*        c3.concept_name as procedure, */
       concat(c2.vocabulary_id,':',c2.concept_code) as unit_id,
       c2.concept_name as unit_label,
       c2.concept_id,
       m.unit_source_value,
       m.visit_occurrence_id,
       row_number() over (partition by m.person_id, m.measurement_datetime, m.visit_occurrence_id)
FROM cdm_synthea10.measurement m
    left join cdm_synthea10.concept c on c.concept_id = m.measurement_concept_id
    left join cdm_synthea10.concept c2 on c2.concept_id = m.unit_concept_id
/* You can use the line below if in you ETL conversion */
/* left join cdm_synthea10.procedure_occurrence po on po.visit_occurrence_id = m.visit_occurrence_id and po.person_id = m.person_id */
/* left join cdm_synthea10.concept c3 on c3.concept_id = po.procedure_concept_id */
;
