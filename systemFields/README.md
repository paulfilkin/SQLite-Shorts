# Extracting System Field values from SDLTM Files

## Overview

This script is designed for use within **DB Browser for SQLite** or **TM Fusion** (a customised version of DB Browser tailored for working with SDLTM files). It extracts key metadata and content from translation units (TUs) stored in an SDLTM file, including both source and target segments, and associated metadata such as creation date, usage counters, and user information.

## Handling Markup in Segments

The source and target fields in SDLTM files typically contain a significant amount of XML-like markup. For instance:

```xml
<Segment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <Elements>
        <Text><Value>European flag</Value></Text>
    </Elements>
    <CultureName>en-GB</CultureName>
</Segment>
```

The script specifically extracts only the text between the `<Value>` tags, while preserving any internal markup. The markup surrounding the `<Value>` element is stripped away, leaving the core content for analysis. This ensures that the script captures the actual text without being affected by other markup within the segment.

## SQL Query

```sql
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
```

## How It Works

- **`instr()`** identifies the positions of the `<Value>` and `</Value>` tags in the `source_segment` and `target_segment` columns.
- **`substr()`** extracts the text within these tags, representing the actual content of the translation unit.
- Metadata related to the creation, modification, and usage of each translation unit is retrieved from the `translation_units` table.

## Usage

### Option 1: Manual Execution

1. Open your SDLTM file in **DB Browser for SQLite** or **TM Fusion**.
2. Navigate to the **Execute SQL** tab.
3. Copy and paste the SQL query above into the SQL editor.
4. Execute the query to retrieve the translation unit data.
5. The results will display the source and target segment text alongside the metadata for each translation unit.

### Option 2: Download and Execute Script

If the script is saved as an `.sql` file, follow these steps:

1. Open **DB Browser for SQLite** or **TM Fusion**.
2. Load the SDLTM file in the tool.
3. In the **Execute SQL** tab, select and open the saved `.sql` script.
4. Execute the script to extract the translation unit data.

## Results View

Once the script has been executed the result should deliver something like this into the Results View:

![](.\images\table_results.png)

## Exporting Results

Once the query is executed, you can export the results for further analysis or reference:

1. In **DB Browser for SQLite** or **TM Fusion**, after executing the query, right-click on the results view.
2. Select **Save the results view** to export the data to a CSV, Excel, or other file formats.
   
   This allows you to work on the extracted data in external applications like Excel or Google Sheets, where you can perform additional filtering, sorting, or analysis. For instance, you might use this method to quickly identify and review specific translation units (TUs) of interest based on their ID, usage patterns, or other metadata.

## Extracted Fields

The following fields are retrieved from the `translation_units` table:

- **ID**: The unique identifier of each translation unit.
- **Source Segment**: The core text between the `<Value>` tags of the `source_segment`.
- **Target Segment**: The core text between the `<Value>` tags of the `target_segment`.
- **Creation Date**: The timestamp indicating when the translation unit was first created.
- **Creation User**: The user who created the translation unit.
- **Change Date**: The timestamp indicating when the translation unit was last modified.
- **Change User**: The user who last modified the translation unit.
- **Last Used Date**: The last time this translation unit was used.
- **Last Used User**: The user who last used this translation unit.
- **Usage Counter**: The number of times the translation unit has been used.
- **Insert Date**: The timestamp indicating when the translation unit was inserted into the database.

## Requirements

- **DB Browser for SQLite** or **TM Fusion** must be installed on your machine.
- The SDLTM file must be properly loaded in the tool for correct execution of the query.
