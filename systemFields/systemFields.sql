SELECT 
    id, 
    substr(source_segment, instr(source_segment, '<Value>') + 7, instr(source_segment, '</Value>') - instr(source_segment, '<Value>') - 7) AS source_segment_text, 
    substr(target_segment, instr(target_segment, '<Value>') + 7, instr(target_segment, '</Value>') - instr(target_segment, '<Value>') - 7) AS target_segment_text, 
    creation_date, 
    creation_user, 
    change_date, 
    change_user, 
    last_used_date, 
    last_used_user, 
    usage_counter, 
    insert_date
FROM 
    translation_units;
