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
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);

  if (type == 0)
    ret = cell(Nx - 1, Ny - 1);
    for i = 1 : Nx - 1
      for j = 1 : Ny - 1
	S = [M(i, j, 1) M(i, j + 1, 1)
	     M(i + 1, j, 1) M(i + 1, j + 1, 1)];

	B = [1 0
	     1 1];
	
	C = inv(B) * S * inv(transpose(B));

	ret(i, j) = C;	
      end
    end
    
  else
    ret = cell(Nx - 1, Ny - 1);
    for i = 1 : Nx - 1
      for j = 1 : Ny - 1
	S = [M(i, j, 1) M(i, j + 1, 1) M(i, j, 3) M(i, j + 1, 3)
	     M(i + 1, j, 1) M(i + 1, j + 1, 1) M(i + 1, j, 3) M(i + 1, j + 1, 3)
	     M(i, j, 2) M(i, j + 1, 2) M(i, j, 4) M(i, j + 1, 4)
	     M(i + 1, j, 2) M(i + 1, j + 1, 2) M(i + 1, j, 4) M(i + 1, j + 1, 4)];

	Bx = [1 0 0 0
	     0 0 1 0
	     -3/Hx^2 3/Hx^2 -2/Hx -1/Hx
	     2/Hx^3 -2/Hx^3 1/Hx^2 1/Hx^2];
	
	By = [1 0 0 0
	     0 0 1 0
	     -3/Hy^2 3/Hy^2 -2/Hy -1/Hy
	     2/Hy^3 -2/Hy^3 1/Hy^2 1/Hy^2];

	
	C = Bx * S * transpose(By);

	ret(i, j) = C;
      end
    end
  endif
end
