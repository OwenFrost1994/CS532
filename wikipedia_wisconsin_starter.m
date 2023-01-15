clear
clc
close all

edges = csvread('wisconsin_edges.csv');

node_count = max(edges(:))+1;

A = zeros(node_count,node_count);
[m,n] = size(edges);
for i=1:m
  from_node = edges(i,1);
  to_node = edges(i,2);
  A(to_node+1,from_node+1)=1;
end

%% a)
%i)
A=A+0.001*ones(node_count,node_count);
%ii)normalization
for i=1:1:node_count
    A(:,i)=A(:,i)/norm(A(:,i));
end
%iii)use eigenvalue
[Evea,Evaa]=eigs(A);

%% b) 1st
[Eve,Eva]=eigs(A,1);
[va,po]=max(abs(Eve));
po

%% c) 3st
[Eve,Eva]=eigs(A,3);
[va,po]=max(abs(Eve));
po
% Hint: use 
% eigs(A,k)
% where k=1 to get the first eigenvector, instead of 
% eig(A)
% as computation of all eigenvectors will take ~5 minutes