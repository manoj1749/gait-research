# Gait Analysis Research Project

## Overview
This repository contains a comprehensive analysis of gait patterns using sensor data and machine learning techniques. The project focuses on analyzing gait events (Heel Strike and Toe-Off) using IMU sensors and force data from both left and right legs.

## Project Structure
- `gait_events.ipynb`: Main notebook for gait event detection and analysis
- `rfecv.ipynb`: Feature selection using Recursive Feature Elimination with Cross-Validation
- `gait_plots.ipynb`: Visualization of gait events and sensor data
- `labeled_gait_data.csv`: Primary dataset with labeled gait events
- `labeled_gait_output.csv`: Processed output data
- `combined_dataset.csv`: Combined dataset from multiple specimens

### Directories
- `labelled/`: Contains labeled gait data files
- `combined_dataset_specimen1/`: Data specific to specimen 1
- `analysis/`: Analysis scripts and notebooks
- `visualise/`: Visualization tools and outputs
- `phases/`: Gait phase analysis
- `dataset with force/`: Raw dataset including force measurements
- `data-pre-processing/`: Data preprocessing scripts

## Key Features
1. **Gait Event Detection**
   - Identification of Heel Strike and Toe-Off events
   - Analysis of ankle angles during gait cycles
   - Integration of force plate data

2. **Feature Selection**
   - RFECV implementation for optimal feature selection
   - Separate analysis for left and right gait phases
   - Selected features visualization using radar plots

3. **Data Visualization**
   - Time series plots of ankle angles
   - Gait event markers
   - Automated plot generation for multiple datasets

## Dependencies
Major dependencies include:
- pandas (2.0.3)
- numpy (1.24.4)
- matplotlib (3.5.3)
- scipy (1.9.3)
- seaborn (0.13.2)
- plotly (6.0.1)

For a complete list of dependencies, see `requirements.txt`.

## Data Processing Pipeline
1. Raw data collection from IMU sensors and force plates
2. Data preprocessing and filtering
3. Feature extraction and selection
4. Gait event detection
5. Visualization and analysis

## Results
The project has successfully:
- Implemented automated gait event detection
- Identified optimal features for gait phase classification
- Created visualization tools for gait analysis
- Combined and processed data from multiple specimens

## Setup
1. Create a virtual environment:
   ```bash
   python -m venv tf_env
   source tf_env/bin/activate  # On Unix/macOS
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage
1. Start with `gait_events.ipynb` for main analysis
2. Use `rfecv.ipynb` for feature selection
3. Generate visualizations using `gait_plots.ipynb`

## Future Work
- Implementation of advanced machine learning models
- Real-time gait analysis capabilities
- Integration with additional sensor types
- Extended dataset collection and analysis
