% Importa dati di eprime da excell e tramite il vettore delcol elimina le
% colonne non utili ai fini delle analisi
% la prima riga è tutta 0 perchè deriva dai titoli quindi non è da
% analizzare
% se (colonna 3)=1 e (colonna 9)=0 significa che non c'è stata risposta
% dal paziente


close all
clear all
[file path]=uigetfile('h:\*.xls','Selezionare excel del log file');
nomefile=strcat(path,file);
[NUMERIC,TXT,RAW]=xlsread(nomefile,'Foglio1');
cd (path)


dati=RAW;

delcol=[1:12 14 16:44 46:49 51 53:57 59 61 66:67 69 71 73:77 79 81 83:85]; %vettore colonne da eliminare
dati(:,delcol)=[];
datinum=zeros(209,17,'double'); %inizializza matrice dati numerici

for i = 2:209 % crea matrice datinum con valori numerici sostituendo 'NULL con 0' tranne che per le colonne 3 e 9
    for j = 1:17
        if (j  ~=  3 && j ~= 9)
            m=dati(i,j);
            
            if strcmp (m,'NULL')
               datinum(i,j)=0;
            else
            mm=cell2mat(m);
            datinum(i,j)=mm;
            end
        end
    end
end


for i = 2:209 % colonna 3 datinum = 1 se c'e' List Cadenza in eprime
    m=dati(i,3);
    if strcmp (m,'ListCadenza')
       datinum(i,3)=1;
    end
end

for i = 2:209  % assegna numerazione ai tasti premuti
    m=dati(i,9);
    mm=cell2mat(m);
    switch mm
        case 'S'
            datinum(i,9)=1;
        case 'D'
            datinum(i,9)=2;
        case 'A'
            datinum(i,9)=3;
        case 'M'
            datinum(i,9)=4;
            
    end
end
file2= file;
save (file2(1:(end-4)),  'datinum');

            

               
           
    
            
  
         
         
        







