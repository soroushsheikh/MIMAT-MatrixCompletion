function err  = MIMATDriver( observation_percentage,iteration )
% Setup a matrix

   % if you're daring, try with complex numbers:
   COMPLEX = false;

   n1 = 110 ; n2 = 110 ; r = 5;

   if COMPLEX
       Matrix = (randn(n1,r)+1i*randn(n1,r))*(randn(r,n2)+1i*randn(r,n2))/2;
   else
       Matrix = randn(n1,r)*randn(r,n2);
   end

   % Determination of missing percentage
   m = floor((n1*n2)*(observation_percentage/100));
   p  = m/(n1*n2);

   filledInd = randsample(n1*n2,m); 
   
   observedMatrix=zeros(n1,n2);
   observedMatrix(filledInd) = Matrix(filledInd);
   Mask = observedMatrix==0  ;
   MaskC= ~ Mask  ;
  
 
   fprintf('Matrix completion: %d x %d matrix, rank %d, %.1f%% observations\n',...
       n1,n2,r,100*p);
   if ~isreal(Matrix), disp('Matrix is complex'); end
% Set parameters
   e1= 1e-15 ;
   e2= 1e-4 ;
% Solving the problem via MIMAT 
   completedMatrix = MIMAT( n1,n2,~MaskC ,observedMatrix,e1,e2, observation_percentage, iteration) ;
% Examination
   errMatrix = completedMatrix-Matrix;
   err = norm ( errMatrix , 'fro' )/ norm (Matrix,'fro')