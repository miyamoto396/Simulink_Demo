clear;clc;close;    %初期化

%% バッテリモデル
SOC = [0    0.1    0.2  0.3 0.4   0.5   0.6  0.7  0.8    0.9 1];
OCV = [2.8 3.4 3.6 3.7 3.8 3.9 4.0 4.1 4.2  4.4   4.6];

FCC_Ah = 4.0;                       %[Ah]Full Charge Cap
FCC = FCC_Ah*60*60;         %[C]Full Charge Cap

R0 = 1.90e-3;         %移動抵抗

%Warburgインピーダンス
n = 4;      %Warburgインピーダンスの近似次数

Rd = 1.42e-3;     %
Cd = 1.65e5;     %

Cn = Cd/2; 
Rn = @(n) 8*Rd/(2*n-1)^2/pi^2;

Adiag = [];     %A行列の対角成分をつくる
for i = 1:n Adiag = horzcat(Adiag,-1/(Rn(i)*Cn));  end %対角成分を次数nに追加

%%　Warburgインピーダンス過電圧の状態方程式表現
A = diag(Adiag);    %A行列を作成
B = ones(n,1);             %B行列を作成
B = B/Cn;
C = eye(n);         %状態変数をそのまま出力とする
D = zeros(n,1);   %


%% 推定器共通設定
Ts = 0.01;          %[s]サンプル時間





%% Unceted Kalman Filter 用設定