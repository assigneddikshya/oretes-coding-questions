# oretes-coding-questions
PART-2: Making API calls from "https://api.nasa.gov/" and storing the json data in an excel spreadsheet.
1. Generate an API key in the website
2. Get the URL and request for it using "request" package
   *Save the basic structure of the url as base_url and then concatenate the generated key to get the url.
   *import request package and request for the url.
3. Get the dictionary from the API key and store it in a json object.
   * You need to import the json package 
   * Use json.loads() to store the dictionary in a variable of choice.
4. Convert the json dictionary to a pandas dataframe by using from_dict() function
5. Use pandas ExcelWriter() to create an excel worksheet
6. Use to_excel() to store the dataframe in the created excel worksheet by using a variable.
7. Save the excel file by using .save() function.

