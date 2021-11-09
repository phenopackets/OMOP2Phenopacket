select m.person_id,
       m.measurement_concept_id,
       concat(c.vocabulary_id,':',c.concept_code) as assay_id,
       c.concept_name as assay_label,
    -- value_as_number maps to a phenopacket Value
       m.value_as_number,
    -- value_id and value_label map to a phenopacket OntologyClass
       concat(c3.vocabulary_id,':',c3.concept_code) as value_id,
       m.value_source_value as value_label,
       m.measurement_datetime,
    -- phenopacket Quantity
       concat(c2.vocabulary_id,':',c2.concept_code) as unit_id,
       c2.concept_name as unit_label,
       -- if range_low and range_high are not null, create a ReferenceRange
       m.range_low,
       m.range_high,
       c2.concept_id,
       m.unit_source_value,
       m.visit_occurrence_id,
/*        c3.concept_name as procedure, */
       row_number() over (partition by m.person_id, m.measurement_datetime, m.visit_occurrence_id)
FROM cdm_synthea10.measurement m
         left join cdm_synthea10.concept c on c.concept_id = m.measurement_concept_id
         left join cdm_synthea10.concept c2 on c2.concept_id = m.unit_concept_id
         left join cdm_synthea10.concept c3 on c3.concept_id = m.value_as_concept_id
/* You can use the line below if in you ETL conversion */
/* left join cdm_synthea10.procedure_occurrence po on po.visit_occurrence_id = m.visit_occurrence_id and po.person_id = m.person_id */
/* left join cdm_synthea10.concept c3 on c3.concept_id = po.procedure_concept_id */
/* where m.measurement_concept_id in (3012888, 3004249) */
;
