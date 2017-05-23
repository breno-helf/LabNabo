#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

constroiv

Função que recebe Nx, Ny, Ax, Ay, Bx, By e uma matriz
com os valores de uma função f nos pontos de malha e caso
necessário os valores de suas derivadas também. 
A função também recebe um valor type que quando 0 calcula
a interpolação de forma bilinear, quando 1 calcula de forma
bicúbica.


#}

function ret = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, type)
  if (type == 0)
    ret = zeros(Nx, Ny);
    for i = 1 : Nx
      for j = 1 : Ny
	S = [M(i, j, 1) M(i, j + 1, 1)
	     M(i + 1, j, 1) M(i + 1, j + 1, 1)];

	B = [1 0
	     1 1];

	C = inv(B) * S * inv(transpose(B));

	ret(i, j) = C;
      end
    end
    
  else
    ret = zeros(Nx, Ny);
    for i = 1 : Nx
      for j = 1 : Ny
	S = [M(i, j, 1) M(i, j + 1, 1) M(i, j, 3) M(i, j + 1, 3)
	     M(i + 1, j, 1) M(i + 1, j + 1, 1) M(i + 1, j, 3) M(i + 1, j + 1, 3)
	     M(i, j, 2) M(i, j + 1, 2) M(i, j, 4) M(i, j + 1, 4) 
	     M(i + 1, j, 2) M(i + 1, j + 1, 2) M(i + 1, j, 4) M(i + 1, j + 1, 4)];
	
	B = [1 0 0 0
	     0 0 1 0
	     -3 3 -2 -1
	     2 -2 1 1];

	C = inv(B) * S * inv(transpose(B));
	

	ret(i, j) = C;
      end
    end
  endif
end
