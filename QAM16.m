M = 16;
k = log2(M);
data = randi([0 1],1000*k,1);
txSig = qammod(data,M,'InputType','bit','UnitAveragePower',true);
rxSig = awgn(txSig,10);
cd = comm.ConstellationDiagram('ShowReferenceConstellation',false);
step(cd,rxSig)