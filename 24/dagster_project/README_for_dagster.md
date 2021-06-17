Dagster setup
---------------
1. Create a virtual environment using "python -m venv venv_name"; activate it using "venv_name\Scripts\activate.bat" in the same directory.
2. Install the packages listed in requirements.txt in the venv.
You are set for a dagster pipeline project.

Dagster pipelines
------------------
1. To initiate a pipeline for your data, you have to create a repository in the dagit portal. Run "dagit -f dagster_initiate_pipeline.py" . 
2. Just replace the string name with your choice of string.
3. Open the dagit portal in website and Launch execution.
4. Now, you have to execute the pipeline. Run "dagster pipeline execute -f dagster_initiate_pipeline.py"
5. You have established a basic pipeline . Now you can build a simple or a complex pipeline using the basic structure.

