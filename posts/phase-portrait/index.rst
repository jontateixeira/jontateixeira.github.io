.. title: Nonlinear dynamics 1: Phase portrait
.. slug: phase-portrait
.. date: 2019-11-05 05:43:02 UTC-03:00
.. has_math: true
.. footnote-references: superscript
.. tags: nonlinear dynamic, phase portrait, chemical problem, CSTR, Lyapunov’s stability
.. category: nonlinear dynamic
.. link:
.. description: explanation abaout phase portrait diagram
.. type: text

Sometimes *chemical problems* can be answered using knowledge of *nonlinear dynamic analysis* that is not directly related to chemistry. For example, some information about a complex reactions flow can be gained from the mathematical models of the interspecific competition. Oscillating chemical reactions such as the `Bray-Liebhafsky reaction`_, the `Briggs-Rauscher reaction`_ , and the `Belousov-Zhabotinski reaction`_ provide wonderful examples of relaxation oscillations (nonlinear behavior) in science. They are often demonstrated in chemistry classes or used to astound the public at university open days. The first experiment of the BZ reaction was conducted by the Russian biochemist Boris Belousov in the 1950s, and the results were not confirmed until as late as 1968 by Zhabotinski (those examples will be addressed ina future post).

.. _Bray-Liebhafsky reaction: https://doi.org/10.1021/ja01352a006
.. _Briggs-Rauscher reaction: https://doi.org/10.1021/ed050p496
.. _Belousov-Zhabotinski reaction: https://doi.org/10.1063/1.441007


In this first post, we going to make a classic *phase portrait* analysis, considering non-isothermal *CSTR* problem, where we going to identify **multiplicity steady-state**. Due to the nonlinear behavior of chemical systems (strongly linked with the `Arrhenius equation`_), the existence of multiplicity steady-state is often found when we are modelling or simulating a chemical system, sometimes we come across this behavior, experimentally.

.. _Arrhenius equation: https://en.wikipedia.org/wiki/Arrhenius_equation

Before we get started, let's define critical points (steady-state for engineering chemical accent) and how to classify them. First start with one of the simplest systems, a homogeneous linear system. Such a system has the form:

.. math::

    \frac{d\mathbf{x}}{dt} = \mathbf{A}\mathbf{x}

where :math:`\mathbf{A}` is a matrix 2-by-2, and :math:`\mathbf{x}` is a vector 2-by-1. From calculus we have solution family like :math:`\mathbf{x} = \mathbf{\omega} e^{\lambda t}`. So replace this into homogeneous system, we get:

.. math::
  \left(\mathbf{A} - \lambda\mathbf{I} \right)\omega = \mathbf{0}

with :math:`\lambda` and :math:`\omega` are the eigenvalue and eigenvector of :math:`\mathbf{A}`, respectively. In order to obtain the eigenvalue, we need to solve the **characteristic equation** (:math:`\mathrm{det}\left(\mathbf{A} - \lambda\mathbf{I} \right) = 0`) and eigenvector from constraint :math:`\|\omega\| = 0` and homogeneous system above.

The correspondent solution of the homogeneous linear system (i.e. when :math:`\mathbf{A}\mathbf{x}=0`) is named by critical points and correspond to steady-states or equilibria of the system. The investigation of the critical point character, based on *Lyapunov’s stability* criteria, is closely related to the question of the system stability at the steady-state to small disturbances can be assessed first by linearization and then by computation of the eigenvalues of the Jacobian matrix:

.. math::
  \mathbf{J}(\mathbf{x0}) =
  \begin{bmatrix}
    \frac{\partial f_1(\mathbf{x0})}{\partial x_1} & \frac{\partial f_1(\mathbf{x0})}{\partial x_2} & ... & \frac{\partial f_1(\mathbf{x0})}{\partial x_m} \\
    \frac{\partial f_2(\mathbf{x0})}{\partial x_1} & \frac{\partial f_2(\mathbf{x0})}{\partial x_2} & ... & \frac{\partial f_2(\mathbf{x0})}{\partial x_m} \\
    \vdots & \vdots & \dots & \vdots \\
    \frac{\partial f_i(\mathbf{x0})}{\partial x_1} & \frac{\partial f_i(\mathbf{x0})}{\partial x_2} & ... & \frac{\partial f_i(\mathbf{x0})}{\partial x_m} \\
    \vdots & \vdots & \dots & \vdots \\
    \frac{\partial f_n(\mathbf{x0})}{\partial x_1} & \frac{\partial f_n(\mathbf{x0})}{\partial x_2} & ... & \frac{\partial f_n(\mathbf{x0})}{\partial x_m} \\
  \end{bmatrix}



Or qualitatively using phase portrait analysis. The phase portrait is a set of solving from a number of initial conditions, that will produce a phase path (a plot that shows the dependence of one unknown with the other) showing the behavior of the system along time integration. For example, given the linear system:

.. math::
  x' &= ax \\
  y' &= b(x + y )

which has as critical point in the origin, and the eigenvalues of Jacobian: :math:`\mathbf{J} = \begin{bmatrix} a & 0 \\ b & b\end{bmatrix}` are a and b. If :math:`a= -1; b=-5` the phase portrait [#]_ looks like this:

.. figure:: /files/nonlinear-dynamic/phase_portrait_linear.png
  :height: 500px
  :width: 700px
  :alt: Phase portrait with a= -1 and b=-5.

  Phase portrait with a= -1 and b=-5.


Here all trajectories are lines through the origin (steady state of the system), this behavior is typically to **attractor critical points**. Others trajectories are ilustraited in Table below, with differents values for a and b:

.. |pp-1| image:: /files/nonlinear-dynamic/phase_portrait_linear_2.png
  :height: 500px
  :width: 700px
  :scale: 50 %
  :alt: Phase portrait with a= -1 and b=-5.

.. |pp-2| image:: /files/nonlinear-dynamic/phase_portrait_linear_4.png
  :height: 500px
  :width: 700px
  :scale: 50 %
  :alt: Phase portrait with a= -1 and b=-5.

======================   ======================  =====================
Parameters values        Phase portrait          Critical point type   
======================   ======================  =====================
a = +1; b = -5           |pp-1|                  saddle point 
a = +1; b = +5           |pp-2|                  source point 
======================   ======================  =====================

Those are commonly found in chemical reactors system, but there are others critical points types (center, spiral, star, degenerated,... more info, see the aforementioned references). 

Here the chemical engineering kinetic borrows some terms from the dynamic system theory, without a deep discussion of the mathematical apparatus, 
we will show how the mathematical suites allow one to determine the critical point type. Assume the mathematical model of a process described by a set of two differential equations. As we saw above, in order to find the critical point type one has to:
1. Calculate the critical points (steady-states) on a phase plane, or solving the corresponding algebraic equation set (:math:`\mathbf{A}\mathbf{x}=0`);
2. Compute the Jacobian matrix for the system using the critical points coordinates (:math:`\mathbf{J}(\mathbf{x0})`);
3. Find the eigenvalues of the latter matrix, to establish the critical point type and the stability of the stationary state.


Non-isothermal reactor problem
--------------------------------

Lets us consider the steady-state operation of a CSTR under non-isothermal conditions. If an exothermic reaction takes place in an isolated system (i.e. adiabatic reactor, absent of the heat exchange), a temperature will apparently increase over time, for example, hydrolysis of Propylene Glycol. The rate of this increase depends both on the kinetic parameters (rate constant) and on the thermodynamic properties of the system (thermal conditions of the reaction, heat capacity). For a well-mixed tank reactor, where a single first-order reaction:
A + B → C occurs, the mathematical model is described by this set of equations:

.. math::
    \frac{dC_A}{dt} &= \frac{C_{Ao} - C_A}{\tau} - r_A \\
    \frac{dT}{dt} &= \frac{T_o - T}{\tau} + \frac{-\Delta H_{rx}}{\rho C_p|_{mx}} (-r_A)


where: :math:`\tau` residence time, :math:`C_{Ao}` the input reagent concentration, :math:`r_A = k_o e^{\frac{E}{RT}} C_A^n` kinetic rate, :math:`T_o` is the reagent temperature at entering reactor, :math:`\Delta H_{rx}` heat of reaction, :math:`\rho|_{mx}` misture density and :math:`C_p|_{mx}` misture heat capacity. For simplicity, we assume that the heat capacity, heat reaction and density are temperature independent (i.e. constants) and the kinetic is a single first-order reaction. So, we can rewrite the model as:

.. math::
    \frac{dC_A}{dt} &= \frac{C_{Ao} - C_A}{\tau} - k_o e^{\frac{E}{RT}}C_A \\
    \frac{dT}{dt} &= \frac{T_o - T}{\tau} + G k_o e^{\frac{E}{RT}}C_A \\

with: :math:`G = \frac{\Delta H_{rx}}{\rho C_p |_{mx}}`. 

Modeling the system of ODEs using the initial parameters:

+----------------------+----------------------+
| :math:`G`            | :math:`90.3`         |
+----------------------+----------------------+
| :math:`\frac{E}{R}`  | :math:`- 6307`       |
+----------------------+----------------------+
| :math:`k_o`          | 17 x :math:`10^{+6}` |  
+----------------------+----------------------+
| :math:`\tau`         |       60             |  
+----------------------+----------------------+
| :math:`C_{Ao}`       |       1.5            |  
+----------------------+----------------------+
| :math:`T_o`          |       250            |  
+----------------------+----------------------+

We can find a stationary state through the phase portrait, from several initial conditions as ilustraited following:

.. image:: /files/nonlinear-dynamic/phase_portrait_nonlinear_01.png
  :height: 500px
  :width: 700px

We can see that the steady-state (1.499, 250.015) is an *attractor critical point*, because all phase path toward it. The stationary state is linked to the thermal stability of the reactor (in the current case) and consequently with the convertion, that in this case is very slow. In order to confirm the attraction behavior, we analyze the Jacobian of the system using the critical point:

.. math::
  \mathbf{J}(C_A, T) =
  \begin{bmatrix}
    -\frac{1}{\tau}-k_o e^{-\frac{E}{RT}} & -\frac{k_o C_A \frac{E}{R} e^{-\frac{E}{RT}}}{T^2} \\
    k_o G e^{-\frac{E}{RT}} & \frac{k_o C_A \frac{E}{R} G e^{-\frac{E}{RT}}}{T^2} - \frac{1}{\tau}
  \end{bmatrix}

where we found the following eigenvalues: (-0.1667, -0.1666) < 0. The dynamic of this problem depends on the temperature of the initial mixture (as also: inlet concentration, residence time and etc), and thusas also the portrait can change strikingly. In the discussed example the steady-state is undesirable from the efficiency point of view. In order to enable the process, we need to increase the inlet temperature to improve the convertion and thus goes from old stationary to the other one, stable or may be unstable. If the latter one happens, any small perturbation of the system takes it out of the unstable state and goes to a stable one. 
Such situation is illustrated the animation below

.. image:: /files/nonlinear-dynamic/phase_portrait.gif
  :height: 500px
  :width: 700px

When we change the input reagent temperature, we saw the presence of multiple steady-state (red square). In these cases (@ 322 and 331), the animation shows that two of the three possible stationary states are stable: for them the Jacobian matrix eigenvalues are real and of the same sign (stable point). The third steady-state has Jacobian eigenvalues real, but with signs opposite (saddle point).


+---------------+-------------------+--------------------------------------------+-------------------+
| :math:`T_o`   | :math:`C_A, T`    |  eigenvalues of Jacobian :math:`(C_A,T)`   |                   |
+===============+===================+============================================+===================+
|               | 1.431, 328.90     | -0.1670, -0.1140                           | Attractor         |
|               +-------------------+--------------------------------------------+-------------------+
|  @ 322.727    | 0.736, 391.70     | -0.1670,  0.0132                           | Saddle            |
|               +-------------------+--------------------------------------------+-------------------+
|               | 0.225, 437.80     | -0.0478, -0.0167                           | Attractor         |
+---------------+-------------------+--------------------------------------------+-------------------+
|               | 1.313, 348.70     | -0.0167, -0.0044                           | Attractor         |
|               +-------------------+--------------------------------------------+-------------------+
|  @ 331.818    | 1.110, 367.00     | -0.0167,  0.0049                           | Saddle            |
|               +-------------------+--------------------------------------------+-------------------+
|               | 0.142, 454.50     | -0.1141, -0.0167                           | Attractor         |
+---------------+-------------------+--------------------------------------------+-------------------+


This example by no means covers all possible problems of chemical reactor kinetics as well as other differential models for chemical-engineering processes, on which the nonlinear dynamic can be applied. In the next post, we'll be shown how to make a bifurcation diagram through `software MatCont`_.

.. _software MatCont: https://sourceforge.net/projects/matcont/

-------

  .. [#] all phase portrait and images were plotted using the function :doc:`phasePortrait <listings-nonlinear>`


