% calcola da variabili matlab di eprime indici di performance
% Antonio Bottalico - aprile 2012
clear all
evento=zeros(1,4);
cont=0; % contatore locale dita
cont2=0; % contatore locale incrementale
sessione=0;
flag=1;
eventoprecedente=0;
%variabili su cui fare analisi
%le sessioni sono lette per righe
salto=zeros(8,1);
nullo=zeros(8,1);
giusto=zeros(8,1);
ripetizione=zeros(8,1);
reactiontime=zeros(8,16);
%lettura variabili matlab
[file path]=uigetfile('h:\*.mat','Selezionare file variabili matlab da eprime');
nomefile=strcat(path,file);
load (nomefile);
cd (path)
36
for contgen = 1:209
if datinum (contgen,3)==1 % start
cont2=cont2+1;
cont=cont+1;
if cont==5
cont=1;
end
if flag==1
sessione=sessione+1;
flag=flag+1;
end
% inserimento algoritmi dopo aver settato le sessioni
%inizializza reacrion time
reactiontime(sessione,cont2)=datinum(contgen,10);
evento(1,cont)=datinum(contgen,9);
if evento(1,cont)==0 % nullo
nullo(sessione,1)=nullo(sessione,1)+1;
cont=eventoprecedente; % presuppongo di continuare dal tasto precedente
if cont==0 % caso in cui si susseguono tasti non premuti
cont=1;
end
else
if evento(1,cont)==cont % giusto
giusto(sessione,1)=giusto(sessione,1)+1;
else
if evento(1,cont)==eventoprecedente % ripetizione
ripetizione(sessione,1)=ripetizione(sessione,1)+1;
cont=evento(1,cont);
else salto(sessione,1)=salto(sessione,1)+1; % salto
cont=evento(1,cont);
end
end
end
eventoprecedente=evento(1,cont);
else
flag=1;
end
if cont2==16 %reset cont2
cont2=0;
end
end
%cambio da 0 a massimo in reactiontime variabile da usare per analisi : rtimezeromax
tmax=max(max(reactiontime));
rtimezeromax=reactiontime;
for i=1:8
37
for j=1:16
if rtimezeromax(i,j)==0
rtimezeromax(i,j)=tmax;
end
end
end
%%%%%%%% preferibile utilizzare questa %%%%%%%%
%cambio da 0 a media in reactiontime variabile da usare per analisi : rtimezeromean
rtimezeromean=reactiontime;
num=0;
tot=0;
for i=1:8
for j=1:16
if rtimezeromean(i,j)>0
tot=tot+rtimezeromean(i,j);
num=num+1;
end
end
end
if num==0
num=1;
end
tmean=tot/num;
for i=1:8
for j=1:16
if rtimezeromean(i,j)==0
rtimezeromean(i,j)=tmean;
end
end
end
%%% indici di performance %%%
% variabili indici
totgiusto=0;
totsalto=0;
totnullo=0;
% totali variabili
totgiusto=sum(giusto);
totsalto=sum(totsalto);
totnullo=sum(nullo);
