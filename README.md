# Effects of Lateral and Vertical Constrictions on Flow in Rough Steep Channels with Bedload

This repository contains data used in ["Effects of Lateral and Vertical Constrictions on Flow in Rough Steep Channels with Bedload"](https://ascelibrary.org/doi/abs/10.1061/%28ASCE%29HY.1943-7900.0001389).

The data stem from laboratory experiments with the setup described in my PhD thesis ([Schwindt 2017](https://infoscience.epfl.ch/record/229862/files/EPFL_TH7655.pdf?version=1)). Data processing was done with *Python* (see [pydroscape](https://sschwindt.github.io/pydroscape/)) and *Matlab* / *Octave* codes.

## Citation

Suggested citation:

*Schwindt, S.; Franca, M. J. & Schleiss, A. J. "Effects of lateral and vertical constrictions on flow in rough steep channels with bedload". Journal of Hydraulic Engineering, 2017 , 143 , 04017052-1-12. doi: 10.1061/(ASCE)HY.1943-7900.0001389*

LaTex / Bibtex Users:

```
@Article{schwindt17b,
  author    = {Schwindt, Sebastian and Franca, M\'ario J and Schleiss, Anton J},
  title     = {Effects of lateral and vertical constrictions on flow in rough steep channels with bedload},
  journal   = {Journal of Hydraulic Engineering},
  year      = {2017},
  volume    = {143},
  number    = {12},
  pages     = {04017052-1-12},
  doi       = {10.1061/(ASCE)HY.1943-7900.0001389}
}
```

## Codes
 Signal processing was done with *Python* and the [pydroscape](https://sschwindt.github.io/pydroscape/)) package. The data analyses where made with *Matlab* / *Octave* (`.m`) codes, where codes starting with an `f[...].m` mark files containing functions. All other `.m` files are algorithms that use these functions. Please note that all codes were originally written in *Matlab* and processing them with *Octave* may require adding `pkg load io` after the `clear all; close all;` statements in the codes.

## Data structure and codes

The **`RawData`** folder contains the raw data from the ultrasonic probe loggers, pump discharge logger, flow velocity (where applicable), sediment supply/outflow loggers, and constriction geometry. The `RawData/ExperimentOverview.xlsx` workbook contains overview tables of the conducted experiments.

The **`ProcessedData`** folder contains data that where extracted from the `RawData` folder. These data are stored in `ProcessedData/ANALYSIS_TYPE/DataAcquisition/` and the *Matlab* / *Octave* (`.m`) codes in that folder were used for extracting / converting the raw data. The `ProcessedData/ANALYSISTYPE/DataAcquisition/Exp_NNNNN.xls` workbooks document each experimental run, where the maximum bedload passage is highlighted, where the `_pure_Q` identifier marks reference tests without sediment supply. `ProcessedData/ANALYSIS_TYPE/DataAcquisition/YYYYMMDD_data_ANALYSISTYPE.xlsx` summarizes all relevant experiments for an `ANALYSISTYPE` (i.e., Non-constricted, Lateral, Vertical, or Combined).

In addition, the analysis types contain particular subfolders:

- `ProcessedData/NonConstricted/` contains subfolders for evaluating skin-friction of the laboratory flume.
- `ProcessedData/Constriction[Lateral/Vertical]/` contain `dE` subfolders for evaluating the energy loss coefficients of the constrictions.

The **`ProcessedData/Plots/`** folder contains *Matlab* / *Octave* (`.m`) codes for producing the plots (figures) for the paper.

The **`ProcessedData/Statistic/`** folder contains *Matlab* / *Octave* (`.m`) codes for data regression (curves) shown in figures and tables. 
