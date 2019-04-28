Versione *_for per calcolo automatico su tutti i pazienti:
% chiede in ingresso la cartella contenente tutte le cartelle dei pz, entra
% in ognuna, cerca la cartella della sequenza "pd+t2_tse_tra",
% entra, entra in 3D_orig e prende il file lesioni.hdr
% calcola il volume e lo scrive in: NOMEPAZIENTE-volumeLesioni.xls sia
% nella cartella dove c'è il file lesioni.hdr, che a livello delle cartelle
% pazienti, nella cartella zz-lesioni.(attenzione a nomi di file e cartelle)
clear all
%scegliere la cartella del paziente (che conterrà quelle delle singole sequenze)
path1=uigetdir('','Selezionare la cartella del protocollo contenente cartelle pz');
cd(path1);
33
d=dir; %struct contenente le cartelle dei pazienti.
% name -- filename (char array)
% date -- modification date
% bytes -- number of bytes allocated to the file
% isdir -- 1 if name is a directory and 0 if not (se 0 è un file)
dim=size(d);
SEQtrovate=0;
N=dim(1); %numero di pazienti (2 sono da scartare perchè sono . e .., inizierò da 3 a esplorarle)
for i=3:N %%%% eventualmente mettere N-2 per non far entrare in zz e zz-lesioni
nomepaziente = d(i).name;
path2=strcat(path1,'\',d(i).name);
cd(path2); %entro nella cartella del paziente i-esimo
f=dir; %entro nella cartella paziente dove ci sono le seq
% cerco la seq che contiene "pd+t2"
dimf=size(f);
Nf=dimf(1);
for j=3:Nf
seqOK=strfind(f(j).name,'pd+t2');
trovata=isempty(seqOK); % 1 se vuoto, 0 se pieno
if trovata == 0
path3=strcat(path2,'\',f(j).name);
cd(path3); %entro nella cartella della seq pd+t2_tse_tra
cd('3D_orig');
SEQtrovate=SEQtrovate+1;
% [lesioni directory]=uigetfile('d:\*.hdr','Seleziona la immagine
% LESIONI');
vol_les= load_untouch_nii('LL.hdr');%richiamiamo la funzione load_nii per leggere il file nifti di interesse
vol_les.img=double(vol_les.img); %trasformo l'immagine in double
pixwidth_DE=vol_les.hdr.dime.pixdim(2);
pixheight_DE=vol_les.hdr.dime.pixdim(3);
pixthick_DE=vol_les.hdr.dime.pixdim(4);
bits_DE=vol_les.hdr.dime.bitpix;
% taglia=size(vol_les.img);
% z=taglia(1,3);
% x=taglia(1,1);
% y=taglia(1,2);
%
% vol_les_new=zeros(x,y,z);
[I,J,N_les]=find(vol_les.img);
%calcola il volume desiderato (converte anche da mm^3 a cm^3)
pixel_lesioni=size(N_les);
volume_lesioni=(pixel_lesioni(1)*pixwidth_DE*pixheight_DE*pixthick_DE);
% xlswrite(strcat(directory,'\volumeLesioni.xls'),{'lesioni'},'Foglio1','A1');
% xlswrite(strcat(directory,'\volumeLesioni.xls'),volume_lesioni,'Foglio1','A2');
xlswrite(strcat(nomepaziente,'-volumeLesioni.xls'),{'lesioni'},'Foglio1','A1');
34
xlswrite(strcat(nomepaziente,'-volumeLesioni.xls'),volume_lesioni,'Foglio1','A2');
cartellaFINALElesioni=strcat(path1,'\zz-lesioni\');
xlswrite(strcat(cartellaFINALElesioni,nomepaziente,'-volumeLesioni.xls'),{'lesioni'},'Foglio1','A1');
xlswrite(strcat(cartellaFINALElesioni,nomepaziente,'-volumeLesioni.xls'),volume_lesioni,'Foglio1','A2');
end
end
end
