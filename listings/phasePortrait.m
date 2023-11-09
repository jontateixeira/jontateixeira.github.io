function phasePortrait(fun, lb, ub, n, randomize)
%Create a phase portrait from a two-dimensional system of ode
%
% SYNOPSIS:
%   phasePortrait(fun, lb, ub, n, randomize)
%
% PARAMETERS:
%   fun         - Function handle or function name with the system of ode 
%   lb          - lower bound of phase portrait
%   ub          - upper bound of phase portrait
%   n           - number of intial condition of system
%   randomize   - logical variable to randomize the initial points to integrate 
%                 the system. OPTIONAL.  Default value == true
%
% RETURNS:
%   phase portrait plot
%
% EXAMPLE:
%

if nargin<4 
  n = 100;
  randomize = true;
elseif nargin < 5
  randomize = true;
end

num = 20;
dx = abs(ub-lb)/num;

[x1,x2]=meshgrid(lb(1):dx(1):ub(1),lb(2):dx(2):ub(2));

v = zeros(numel(x1(:)),2);
for i=1:numel(x1(:))
   v(i,:) = fun([x1(i), x2(i)]);
end

figure()
disp('vectorial field')
hold on
quiver(x1(:),x2(:),v(:,1),v(:,2));
if randomize
  u=lb(1)+(ub(1)-lb(1))*rand(n,1);
  v=lb(2)+(ub(2)-lb(2))*rand(n,1);
else 
  n = floor(n/4+1);
  u = linspace(lb(1),ub(1),n); 
  u = [repmat(u,1,2),repmat(lb(1),1,n), repmat(ub(1),1,n)]; 
  v = linspace(lb(2),ub(2),n);
  v = [repmat(lb(2),1,n), repmat(ub(2),1,n), repmat(v,1,2)]; 
end

funcao = @(t,x) fun([x(1),x(2)]);
disp('tracing paths ...')
for i=1:numel(u)
    [~,sol]=ode45(funcao,[0,1000],[u(i),v(i)]);
    plot(sol(:,1),sol(:,2),'k');
end
hold off

xlim([lb(1) ub(1)])
ylim([lb(2) ub(2)])
