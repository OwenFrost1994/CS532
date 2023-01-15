function U = gram_schmidt( A )
   % GRAM-SCHMIDT CODE
   %  U = gram_schmidt( A )
   %  where U'*U=I and range(U)=range(A)
   %  number of columns of U is the rank of A.
	
   [m,n] = size(A);
   U = zeros(m,0);          % start with empty matrix
   for i = 1:n
      v = A(:,i);           % the current column of A
      v = v - U*(U'*v);     % project onto current output set
      if norm(v) > 1e-10    % ensure linear independence
         U = [U v/norm(v)]; % normalize and add to the set
      end
   end
end  % end of function