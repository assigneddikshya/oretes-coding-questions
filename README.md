bonobo SETUP
--------------
I.Get a virtual environment set up. "python -m venv venv_name" in the desired file location. 
   - Activate the venv using command "venv_name\Scripts\activate.bat"
II. Download and graphviz software, put it into path for current user / install it as "pip install graphviz"
III. Install the packages listed in requirements.txt.
*Most important ones bonobo, pydotplus(to visualize ETL graphs).
You can test the versions of the packages eg. bonobo version
Your virtual environment is ready.

BONOBO FILES
-------------
1. simple_fun.py is a simple range function . To get the result , Run "python simple_fun.py" ; 
    - To visualize graph, Run "bonobo inspect --graph code_file.py | dot -Tpng -o name_of_graph.png" 
2. my-etl.py has a simple yield function to visualize.
3. bonobo_for_json_doc_ETL.py has a function to retrieve the contents of a json file in JSON format into a txt file, and then visualizing the ETL graph.
