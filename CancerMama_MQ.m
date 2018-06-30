%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  Classificador de Minimos Quadrados
%                  autor: Diego Martins Gomes Saraiva
%      Base de dados do câncer de mama de Wisconsin (8 de janeiro de 1991)

%                   
%
%   # Atributos
%  - -----------------------------------------
%   1. Número de identificação do número de código da amostra
%   2. Espessura de Clump 1 - 10
%   3. Uniformidade do tamanho da célula 1 - 10
%   4. Uniformidade da Forma da Célula 1 - 10
%   5. Adesão Marginal 1 - 10
%   6. Tamanho Único de Célula Epitelial 1 - 10
%   7. Núcleos Nus 1 - 10
%   8. Cromatina Branda 1 - 10
%   9. Nucleoli Normal 1 - 10
%  10. Mitoses 1 - 10
%  11. Classe: (2 para benigno, 4 para maligno)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%




%Retirado 16 instancas(vetores) com dados faltantes.
load breast_cancer.dat
 B = breast_cancer;

X= B(:,2:10);
Entrada=X';
Class= B(:,11)';  % Rótulo (2 para benigno, 4 para maligno)
ID = B(:,1); % Paciente  

%Criando matriz "A" resultante da transformação Y=AX
O=Class*(Entrada');
U=(inv(Entrada*Entrada'));
A =O*U;
R=A*Entrada;
 
 
acertos=0; 
for s=1:683
    basetreino=Entrada;
    basetreino(:,s)=[]; %Retirada a amostra exclusiva para teste
    classetreino=Class;
    classetreino(:,s)=[];
    R=(classetreino*basetreino')*(inv(basetreino*basetreino')); %Obtensão de  A  a partir das amostras reservadas para treino
    P=(R*Entrada(:,s)); %Classificando a partir de M a amostra
    achado=[0]; %Variável que recebará a combinação que representa a classe.
    if P(1)<3
        achado(1)=2; %Classificação como Benigno
    else    
        achado(1)=4; %Classificação como Maligno
    end
if achado==Class(:,s); %Comparação entre a combinação encontrada e a combinação correta da amostra reservada para teste.
    acertos=acertos+1; %Incremento do contador de acertos, caso os valores sejam iguais.
end
end
porcent=100*acertos/683; %Calculo percetual de acertos
fprintf('Analisando a Base sem os vetores com dados faltantes\n');
fprintf('%G%%\n',porcent)



