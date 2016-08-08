clear;
Y_t=load('1D-data.txt');

X_t=[0 0]';
S_t=[1 1;0 1];
M=[1 0];
S=[0 0;0 1];
Q=[0 0; 0 0.0005];
R=.0005;

X_predict=S_t*X_t;
S_predict=S_t*S*S_t'+Q;

for i=1:size(Y_t)
    Kt=S_predict*M'*inv(M*S_predict*M'+R);
    X_upd=X_predict+Kt*(Y_t(i)-M*X_predict);
    S_update=(eye(2)-Kt*M)*S_predict;
    X_update(i)=X_upd(1);
    X_predict=S_t*X_update(i);
    S_predict=S_t*S_update*S_t'+Q;

end

scatter(1:1:length(Y_t),Y_t)
hold on
plot(X_update)
hold off