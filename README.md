<div id=top></div>

<!-- PROJECT PICTURE -->
<br />
<div align="center">
  <a href="https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane">
    <img src="crane_picture2_original.jpg" alt="Logo" height="250">
  </a>
  
<h3 align="center">Identification and validation of the model of an in-scale prototype of a boom crane</h3>
  
  <p align="center">
    MA1 Project
    <br />
    <br />
    <a href="https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MA1project_MaximeJongen_Dinh-HaoNguyen.pdf">Link to the report</a>
    ·
    <a href="https://www.youtube.com/shorts/0ZIyQ80FdGc">View demo</a>
  </p>
  
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#description-of-the-matlab-code">Description of the MATLAB code</a></li>
    <li><a href="#contacts">Contacts</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project was realized within the framework of the Master 1 Project in Electromechanical Engineering at the ULB. The objective is to identify the model of a crane prototype and to validate it experimentally. All MATLAB codes used throughout this project can be found here.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [MATLAB](https://nl.mathworks.com/products/matlab.html)
* [Simulink](https://nl.mathworks.com/products/simulink.html)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Installation

To install the HEBI API for MATLAB, please refer to the [official website of HEBI](https://docs.hebi.us/tools.html#installation).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- DESCRIPTION OF THE MATLAB CODE -->
## Description of the MATLAB code

* [model_vf1.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/model_vf1.m) computes the Lagrangian of the system, without consideration of the additional counterbalance, as well as the M, C and G matrices describing the dynamic model.
* [new_modelvf1.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/new_modelvf1.m) computes the Lagrangian of the system, considering the additional counterbalance, as well as the M, C and G matrices describing the dynamic model.
* [crane.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/crane.m) computes the equations of motion of a boom crane without consideration of the additional counterbalance. This code can be used in the Simulink model.
* [new_crane.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/new_crane.m) computes the equations of motion of a boom crane considering the additional counterbalance. This code is used in the the Simulink model.
* [latex.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/model_vf1.m) can be used to convert easily all these equations from MATLAB to LaTeX.
* [code_Max.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/code_Max.m) is used to send trajectory commands to HEBI's actuators and to collect position measurements from the OptiTrack cameras and feedback torques from the actuators. Then, it computes the 5 generalized coordinates of the system: the slew angle of the base, the luff angle of the boom, the length of the rope, the tangential and radial oscillation angles of the payload.
* [newREGRESSOR_Y.mat](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/newREGRESSOR_Y.mat) contains the symbolic expression of the regressor matrix Y of the system.
* [correct_time.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/correct_time.m) defines a function that detects and deals with anormally long time delays. This is needed to better compute the velocities and accelerations.
* [TIME_DERIVATIVE.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/TIME_DERIVATIVE.m) defines a function that returns the time derivative of a matrix.
* [correct_data.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/correct_data.m) defines a function that removes undesired peaks before filtering the data.
* [Matrix_filt.m defines](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/Matrix_filt.m) defines a function used to filter the data.
* [Ident_model.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/Ident_model.m) linearizes the manipulator dynamic model in the form τ = Y π and computes the π parameter vector solving a least-squares optimization problem with the measured data.
* [Ident_model_simulink_data](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/Ident_model_simulink_data.m) computes the π parameter vector solving a least-squares optimization problem with the data obtained by simulation.
* [scheme_sim.slx](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/scheme_sim.slx) contains the Simulink model of a boom crane.
* [init_smulink.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/init_simulink.m) must be run to initialize some parameters in the Simulink model.
* [plotFig.m](https://github.com/Dinh-Hao-Nguyen/MA1_Project_Crane/blob/main/MATLAB/plotFig.m) can be used to plot the evolution of the generalized coordinates when a trajectory is sent to the crane.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contacts

* Maxime Jongen - maxime.jongen@ulb.be
* Dinh-Hao Nguyen - dinh-hao.nguyen@ulb.be

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* Prof. Emanuele Garone
* Ir. Michele Ambrosino
* Christophe Dushimyimana
* Sabri El Amrani

<p align="right">(<a href="#top">back to top</a>)</p>
