# Gait Research Project

## Files
- `gait_events.ipynb`: Main analysis notebook for detecting heel strike and toe-off events from sensor data
- `rfecv.ipynb`: Performs feature selection to identify the most important sensors and measurements for gait analysis
- `gait_plots.ipynb`: Creates visualizations of ankle angles and gait events
- `classify.ipynb`: Classification of gait phases using machine learning
- `gait_combine_dataset-final.ipynb`: Combines and processes data from multiple trials, includes filtering and angle calculations
- `dataset-combine.ipynb`: Earlier version of dataset combination script
- `convert_images.py`: Utility script to convert PNG images to JPG format

## Recent Work (Past 6-8 Months)

### 1. Machine Learning Model Development
- Implemented and compared multiple classification models for gait phase detection:
  - XGBoost (Best performer with 99.71% accuracy)
  - AdaBoost
  - Random Forest
  - SVM
  - Naive Bayes
  - Decision Trees
  - Gradient Boosting
  - KNN
  - Logistic Regression
- Generated comprehensive model performance metrics and confusion matrices
- Conducted feature importance analysis using RFECV for both left and right gait

### 2. Gait Analysis Improvements
- Enhanced gait event detection (Heel Strike and Toe-Off)
- Calculated detailed gait metrics:
  - Average stance/swing percentages (Left: 44.46%/55.54%, Right: 42.72%/57.28%)
  - Stride symmetry analysis (Average index: 2.81%)
  - Step timing analysis for both legs
  - Cadence measurement (96.07 steps/min)
- Developed visualization tools for:
  - Force sensor data
  - Ankle and knee angles
  - Gait phase transitions
  - Stance phase highlighting

### 3. Data Processing Pipeline
- Created automated data combination scripts for multiple trials
- Implemented signal filtering and processing:
  - Butterworth filters for noise reduction
  - Angular velocity integration
  - PCA for joint axis identification
- Developed standardized data labeling system

### 4. Documentation and Analysis
- Generated comprehensive visualization suite
- Created detailed performance metrics reports
- Documented data processing methodologies
- Established standardized testing protocols

## Data Files
- `labeled_gait_data.csv`: Raw data with manual labels for gait events
- `labeled_gait_output.csv`: Processed data with automated gait event detection
- `combined_dataset.csv`: Combined data from multiple trials

## Folders
- `OUTPUTs/`: Contains analysis results and visualizations
  - Model Performance:
    - Confusion matrices for multiple classifiers (XGBoost, AdaBoost, SVM, etc.)
    - Model metrics comparison plots
    - Training outputs and metrics in text format
  - Gait Analysis:
    - Force sensor and ankle angle visualizations
    - Gait phase labeling plots
    - Left vs Right knee angle comparisons
    - RFECV feature selection plots
  - All visualizations available in both PNG and JPG formats
- `labelled/`: Contains individual labeled datasets from different trials
- `combined_dataset_specimen1/`: Raw and processed data specific to specimen 1
- `animation outputs/`: Generated animations of gait data
- `analysis/`: Additional analysis scripts and results
- `visualise/`: Visualization tools and generated plots
- `phases/`: Scripts for gait phase detection
- `dataset with force/`: Raw data including force plate measurements
- `Dataset/`: Original raw datasets
- `data-pre-processing/`: Scripts for cleaning and preprocessing raw data
- `Base-Research/`: Background research and literature
- `tf_env/` and `profiling_env/`: Python virtual environment

## Environment
- `requirements.txt`: Lists all Python package dependencies
- `.gitignore`: Specifies which files Git should ignore
