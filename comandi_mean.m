% estrae la media dal file di testo meanNAWM e restituisce su file txt nella cartella pazienti i comandi per mascherare
% con cygwin .
% posizionare cygwin nella directory contenente i pazienti
% Antonio Bottalico - Aprile 2012
comandi='';
path1=uigetdir('','Selezionare la cartella contenente cartelle pz');
cd (path1)
d=dir;
Nsogg=size(d,1);
scartare=0;
for i=3:Nsogg
%controllo esclusione zz_*
pzNO=strfind(d(i).name,'zzz_'); %NB: nominare così tutte la cartelle che non sono analisi single subj, così le scarta
scartare=~isempty(pzNO); % 0 se vuoto (cartella ok), 1 se pieno(cartella da scartare)
if scartare == 0
cd (d(i).name);
cd mpr_sienax;
%lettura txt edtrazione val
nomefile = fopen ( 'meanNAWM.txt' , 'r');
A = fscanf ( nomefile , '%s' , [1 inf] ); %restituisce vettore di char
% valore medio voxel
if A(1,33)== '.'
val=str2double(A(1,31))*10+str2double(A(1,32));
else
val=str2double(A(1,31))*100+str2double(A(1,32))*10+str2double(A(1,33));
end
fclose (nomefile);
cd ..;
cd ..;
%%% scrittura file txt comandi
%preserva cancellazione righe precedenti
comandi=strcat(comandi,'cd \t',d(i).name,'/mpr_sienax\n','/cygdrive/c/Programmi/Xinapse/Jim6/Unix/Masker -b ','\t',num2str(val),' -i ../mpr.hdr ../rLL.hdr ../t1filled.hdr\ncd ..\ncd ..\n');
end
end
fidcomandi = fopen ( 'comandi.txt' , 'wt');
fprintf ( fidcomandi , comandi);
fclose (fidcomandi);
