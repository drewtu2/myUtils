function [signal1,signal2, time, kk_vec,ak_plus,bk_plus,ck_plus]=periodic_square_wave_comments(durationT1,periodT,order1)

global running


% This code approximates a periodic square wave up to specified order 
% using Fourier Series synthesis equations.
% The input to the function is the duration of the waveform,
% the period of the waveform, and the order of the approximation.
% For other waveforms, other parameters would be used to generate
% different ak, bk, and ck coefficients.

% First, calculate w0, the angular frequency, from the period.
w0=2*pi/periodT;

% Next, set the spacing between time points to the period/64.  
% Or, 64 points for each period.
dt=periodT/64;

% Now create the vector of times corresponding to 4 periods of the wave.
time=[-2*periodT:dt:2*periodT];

% Create a vector of length order1+1 starting with zero and containing the
% orders of interest.  For an order 3 synthesis of a square wave the vetor
% will be [0 1 2 3], corresponding to the Fourier components, c0, c1, c2,
% c3 or a0, a1, a2, a3.
kk_vec=[0:1:order1];

% Create vectors for the a, b, and c coefficients, of length
% order1+1, and filled with zeros.  The a and b are for trigonometric 
% series and c for the exponential form.
% Note that this allows for a0 and c0,
% the constant terms in the Fourier series.
% Again for order=3, the vector will contain zeros and will 
% be 4 elements long (the length of kk_vec).  Note that b0 (which 
% presumably would be the first element of bk_plus) will always be
% zero, since b0 is not used.
ak_plus=zeros(1,length(kk_vec));
bk_plus=zeros(1,length(kk_vec));
ck_plus=zeros(1,length(kk_vec));

% Calculate the integral symbolically outside the loop so we calculate
% it only once. Then substitute values in when performing the loop
% Allowed as per class discussion on 11/15/17
syms myT sub_k;
A = 1;
bk_sym = (4/periodT) ...
* (2*int(6*A/periodT*myT*sin(sub_k*w0*myT)/1.0, myT, 0, periodT/6) ...
+ int(A*sin(sub_k*w0*myT), myT, periodT/6, periodT/3));

% Question 2 (Default)
if running == 2
    A = 4*10^-3;
end
ck_sym = (2/periodT) ...
    * (int(((-2*A/periodT)*myT + A) * exp(-sub_k*myT*w0*1i), myT, 0, periodT/2));

% Question 3 (Overwrite Question 2)
if running == 3
    A = 10;
    ck_sym = (1/periodT)*int(A*exp(-sub_k*myT*w0*1i),myT, 0, 1);
end

% Transform the symbolic integral into a sum dependent on an input k. 
calculate_bk = matlabFunction(bk_sym);
calculate_ck = matlabFunction(ck_sym);


% This "for" statemet cycles through all the values of kk_vec
% For the order 3 example, these values would be 0, 1, 2, and 3
for kk=kk_vec
    oneORtwo = ((running == 1) || (running == 2)) && (mod(kk, 2) == 1);
    % In this first part (if kk=0), we define the constant term ak=ck and
    % put that value into the first term of the Fourier series ak_plus
    % or ck_plus
    if kk==0
        ak=2*durationT1/periodT;
        ak = 0;                         %% EDITED: Set ak = 0
        
        if running == 3
            ak = A/periodT;                 %% EDITED: For Question 3
        end
        
        ak_plus(kk+1)=ak;
        ck_plus(kk+1)=ak;
        
        % Now we create the vectors that will contain the time-domain
        % signal, filled with zeros.
        signal1 = ak+zeros(1,length(time));
        signal2 = ak+zeros(1,length(time));

  % This is for a1, a2, a3... and b1, b2... and c1, c2...
  % Note that c-1, c-2... are not calculated but are generated
  % below as the complex conjugate of c1, c2...
  % Do this for all ODD values
  
    elseif (oneORtwo || running == 3)  %% EDITED: Make sure we only add odd values
        % The following is the formula for the exponential form Fourier
        % coefficients for the square wave.  (For a different wave, you
        % replace this with a different formula.)  
        % Note that you could also eliminate the exponential form if
        % you are using the trigonometric form.
        ck=2*sin(kk*w0*durationT1)/(kk*w0*periodT);
        ck = calculate_ck(kk);
        % Now we build up the signal from the exponential terms
        % by adding the various frequency 
        % components, starting with c0 and continuing up to the
        % specified order.  Note that c-1 is the complex conjugate (conj)
        % of c1.
        signal2=signal2+ck*exp(j*kk*w0*time)+conj(ck)*exp(-j*kk*w0*time);
        
        % The ak and bk terms are generated from the ck terms
        % using the mathematical relationships:
        % Note, you could generate these directly with the appropriate
        % trigonometric Fourier series formula, rather than generating 
        % ak and bk from ck.
        ak=2*real(ck);
        bk=-2*imag(ck);
        
        ak = 0;                          %% EDITED: For odd function ak = 0
        bk = calculate_bk(kk);           %% Edited: Use the precalculated integral sum
        
        % We also build up the signal from the cos and sin terms.
        % This should be the same signal that we get from the 
        % exponential series!!
        signal1=signal1+ak*cos(kk*w0*time)+bk*sin(kk*w0*time);
        
        % Put the ak, bk, and ck values in the vector of coefficients
        % that will be returned by the function.
        ak_plus(kk+1)=ak;
        bk_plus(kk+1)=bk;
        ck_plus(kk+1)=ck;
    end;
end
   
return;