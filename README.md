# HeartBEAT
Code for paper - H. Pan, D. Temel and G. AlRegib, "HeartBEAT: Heart beat estimation through adaptive tracking," 2016 IEEE-EMBS International Conference on Biomedical and Health Informatics (BHI), Las Vegas, NV, 2016, pp. 587-590.



<p align="center">
  <img src=/Images/heartbeat_figure.png/>
</p> 

### Paper
ArXiv: https://arxiv.org/abs/1810.08554

IEEE: https://ieeexplore.ieee.org/document/7455966

This is a brief explanation and demonstration of the proposed heart beat estimation algorithm HeartBEAT. 



### Citation
If you find our paper and repository useful, please consider citing our paper:  
```
@INPROCEEDINGS{7455966, 
author={H. {Pan} and D. {Temel} and G. {AlRegib}}, 
booktitle={2016 IEEE-EMBS International Conference on Biomedical and Health Informatics (BHI)}, 
title={HeartBEAT: Heart beat estimation through adaptive tracking}, 
year={2016}, 
pages={587-590}, 
doi={10.1109/BHI.2016.7455966}, 
ISSN={2168-2208}, 
month={Feb},}

```

### Abstract 
In this paper, we propose an algorithm denoted as HeartBEAT that tracks heart rate from wrist-type photo-plethysmography (PPG) signals and simultaneously recorded three-axis acceleration data. HeartBEAT contains three major parts: spectrum estimation of PPG signals and acceleration data, elimination of motion artifacts in PPG signals using recursive least Square (RLS) adaptive filters, and auxiliary heuristics. We tested HeartBEAT on the 22 datasets provided in the 2015 IEEE Signal Processing Cup. The first ten datasets were recorded from subjects performing forearm and upper-arm exercises, jumping, or pushing-up. The last twelve datasets were recorded from subjects running on tread mills. The experimental results were compared to the ground truth heart rate, which comes from simultaneously recorded electrocardiogram (ECG) signals. Compared to state-of-the-art algorithms, HeartBEAT not only produces comparable Pearson's correlation and mean absolute error, but also higher Spearman's ρ and Kendall's τ.


### Code

#### Description of m files
* analyzePPG_general: proposed algorithm
* findthreepeaks: supplementary function for analyzePPG_general
* testAlgorithmOnMoreData: generate results from scratch
* generatePaperImages: generate plots in Fig.2, Fig.4, and Fig.5 from precomputed results
* generatePaperTables: generate table results from precomputed results


#### Descript of data folders
* data: competition data - DATA_0#_TYPE0#.mat corresponds to initial 12 datasets whereas TEST_S#_T#.mat and TRUE_S#_T#.mat refer to additional 10 datasets 
* fig_data: data used to plot paper figures
* JOSSresult: the results of JOSS (tracked heart rate and ground truth). Please refer to “Zhilin Zhang, Photoplethysmography-based heart rate monitoring in physical activities via joint sparse spectrum reconstruction, Biomedical Engineering, IEEE Transactions on, vol. 62, no. 8, 2015” for a detailed explanation of the JOSS algorithm.
* TROIKAresult: the results of TROIKA (tracked heart rate and ground truth). Please refer to “Zhilin Zhang, Zhouyue Pi, and Benyuan Liu, Troika: A general framework for heart rate monitoring using wrist-type photoplethysmographic signals during intensive physical exercise, Biomedical Engineering, IEEE Transactions on, vol. 62, no. 2, pp. 522–531, 2015” for a detailed explanation of the algorithm.
* result: results of the proposed algorithm (tracked heart rate and ground truth).


### Experiment description and data format 

Two-channel PPG signals, three-axis acceleration signals, and one-channel ECG signals were simultaneously recorded from 
subjects with age from 18 to 35. For each subject, the PPG signals were recorded from wrist by two pulse oximeters with green LEDs (wavelength: 609nm). Their distance (from center to center) was 2 cm. The acceleration signal was also recorded from wrist by a three-axis accelerometer. Both the pulse oximeter and the accelerometer were embedded in a wristband, which was comfortably worn. The ECG signal was recorded simultaneously from the chest using wet ECG sensors. All signals were sampled at 125 Hz and sent to a nearby computer via bluetooth.


Each dataset with the similar name 'DATA_01_TYPE01' contains a variable 'sig'. It has 6 rows. The first row is a simultaneous recording of ECG, which is recorded from the chest of each subject. The second row and the third row are two channels of PPG, which are recorded from the wrist of each subject. The last three rows are simultaneous recordings of acceleration data (in x-, y-, and z-axis). 

During data recording, each subject ran on a treadmill with changing speeds. For datasets with names containing 'TYPE01', the running speeds changed as follows:
        rest(30s) -> 8km/h(1min) -> 15km/h(1min) -> 8km/h(1min) -> 15km/h(1min) -> rest(30s)

For datasets with names containing 'TYPE02', the running speeds changed as follows:
        rest(30s) -> 6km/h(1min) -> 12km/h(1min) -> 6km/h(1min) -> 12km/h(1min) -> rest(30s)

For each dataset with the similar name 'DATA_01_TYPE01', the ground-truth of heart rate can be calculated from the simultaneously recorded ECG signal (i.e. the first row of the variable 'sig'). For convenience, we also provide the calculated ground-truth heart rate, stored in the datasets with the corresponding name, say 'DATA_01_TYPE01_BPMtrace'. In each of this kind of datasets, there is a variable 'BPM0', which gives the BPM value in every 8-second time window. Note that two successive time windows overlap by 6 seconds. Thus the first value in 'BPM0' gives the calcualted heart rate ground-truth in the first 8 seconds, while the second value in 'BPM0' gives the calculated heart rate ground-truth from the 3rd second to the 10th second. 

For more details, please refer to: Z. Zhang, Z. Pi, B. Liu, TROIKA: A general framework for heart rate monitoring using wrist-type photoplethysmographic (PPG) signals during intensive physical exercise, IEEE Transactions on Biomedical Engineering (in press), 
DOI: 10.1109/TBME.2014.2359372 





### Contact:

Ghassan AlRegib:  alregib@gatech.edu, https://ghassanalregib.com/, 

Dogancan Temel: dcantemel@gmail.com, http://cantemel.com/


