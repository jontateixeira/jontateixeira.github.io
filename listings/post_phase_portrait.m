%{
File: test_phasePortrait.m
Author: Jonathan C. Teixeira
Email: jonta.teixeira@gmail.com
Description: Generate phase portrait of ode system
%}

% as usual
clc; clear; close all;

ode = 'nonlinear';    % ode selections: 'linear' or 'nonlinear'

switch lower(ode)
case 'linear'
    % homogeneous linear system
    % name of variables
    varname = {'x', 'y'};
    portrait_lim = {[-5,-5],[5,5]};
    num_curves = 100;
    [x0, y0] = deal(0,0);

    a   = [-1, +1, -1, +1]; 
    b   = [-5, -5, +5, +5];

    for i=1:numel(a)
      % define ode system
      dy = @(x) [a(i)*x(1); b(i)*(x(1) + x(2))];

      % plot phase portrait
      phasePortrait(dy,portrait_lim{1},portrait_lim{2},num_curves)
      hold on
      plot(x0,y0,'sr');
      xlabel(varname{1}); ylabel(varname{2}); grid on 
      print('-dpng', '-r300', ['phase_portrait_',ode,'_',num2str(i)]);
    end

case 'nonlinear'
    %% nonlinear system
    % parameter definition
    tau = 60;
    k0  = 1.7e5;
    G   = 90.3;
    E_R = 6307;
    Ca0 = 1.5;
    T0  = linspace(250,350,12);

    % name of variables
    varname = {'Concentration', 'Temperature'};
    portrait_lim = {[0,200],[3,550]};
    num_curves = 300;

    for i=1:numel(T0)
        % define ode system
        dy = @(x) [(Ca0 - x(1))/tau - k0*exp(-E_R/x(2))*x(1); ...
                   (T0(i) - x(2))/tau + G*k0*exp(-E_R/x(2))*x(1)];
        
        % critical points
        opts = optimoptions('fsolve','Display','off','MaxFunctionEvaluations',3000, 'functiontolerance',1e-6);
        x = [fsolve(dy,[0;0], opts), ...
                fsolve(dy,[0;500], opts), ...
                fsolve(dy,[1;380], opts)]
        j = [sqrt(sum(dy(x(:,1)).^2))<1e-3; ...
             sqrt(sum(dy(x(:,2)).^2))<1e-3; ...
             sqrt(sum(dy(x(:,3)).^2))<1e-3]
        disp(i);
        y0 = x(2,j); x0 = x(1,j);


        % plot phase portrait
        phasePortrait(dy,portrait_lim{1},portrait_lim{2},num_curves, false)
        hold on
        plot(x0,y0,'sr','markerfacecolor','r');
        xlabel(varname{1}); ylabel(varname{2}); grid on;
        title(['T0 = ',num2str(T0(i))])
        print('-dpng', '-r300', ['phase_portrait_',ode,'_',num2str(i)]);
    end
otherwise
  error('** select valid model')
end

