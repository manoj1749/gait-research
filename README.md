# Gait Research Project

## Files
- `gait_events.ipynb`: Main analysis notebook for detecting heel strike and toe-off events from sensor data
- `rfecv.ipynb`: Performs feature selection to identify the most important sensors and measurements for gait analysis
- `gait_plots.ipynb`: Creates visualizations of ankle angles and gait events
- `classify.ipynb`: Classification of gait phases using machine learning
- `gait_combine_dataset-final.ipynb`: Combines and processes data from multiple trials, includes filtering and angle calculations
- `dataset-combine.ipynb`: Earlier version of dataset combination script

## Data Files
- `labeled_gait_data.csv`: Raw data with manual labels for gait events
- `labeled_gait_output.csv`: Processed data with automated gait event detection
- `combined_dataset.csv`: Combined data from multiple trials

## Folders
- `labelled/`: Contains individual labeled datasets from different trials
- `combined_dataset_specimen1/`: Raw and processed data specific to specimen 1
- `animation outputs/`: Generated animations of gait patterns
- `analysis/`: Additional analysis scripts and results
- `visualise/`: Visualization tools and generated plots
- `phases/`: Scripts for gait phase detection
- `dataset with force/`: Raw data including force plate measurements
- `Dataset/`: Original raw datasets
- `data-pre-processing/`: Scripts for cleaning and preprocessing raw data
- `Base-Research/`: Background research and literature
- `tf_env/`: Python virtual environment
- `profiling_env/`: Environment for performance profiling

## Environment
- `requirements.txt`: Lists all Python package dependencies
- `.gitignore`: Specifies which files Git should ignore
