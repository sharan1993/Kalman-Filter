clear;
Y_t=load('2D-UWB-data.txt');

X_t=[0 0 0 0]';
S_t=[1 0 1 0;0 1 0 1;0 0 1 0;0 0 0 1];
M=[1 0 0 0;0 1 0 0];
S=[0 0 0 0 ;0 0 0 0;0 0 0.1 0.05;0 0  0.05 0.1];
Q=[0 0 0 0 ;0 0 0 0;0 0 0.5 0.25;0 0  0.25 0.5];
R=[1 0.5;1 0.5];

X_predict=S_t*X_t;
S_predict=S_t*S*S_t'+Q;

for i=1:length(Y_t)
    Kt=S_predict*M'*inv(M*S_predict*M'+R);
    X_upd=X_predict+Kt*(Y_t(i,:)'-M*X_predict);
    S_update=(eye(4)-Kt*M)*S_predict;
    X_update(i)=X_upd(1);
    Y_update(i)=X_upd(2);
    X_predict=S_t*X_upd;
    S_predict=S_t*S_update*S_t'+Q;

end

figure
scatter(1:1:length(Y_t),Y_t(:,1))
hold on
plot(X_update)

figure
scatter(1:1:length(Y_t),Y_t(:,2))
hold on
plot(Y_update)