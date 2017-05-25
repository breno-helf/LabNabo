#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

draw

Função que recebe os parametros do constroiv
e a quantidade de pontos a serem desenhados. Desenha
a função nos pontos pedidos.
#}

function main (f, fx, fy, fxy, Px, Py)
  Nx = 11;
  Ny = 11;
  Ax = 0;
  Ay = 0;
  Bx = 2;
  By = 2;

  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);
  
  M = reshape (1:(Nx * Ny * 4), Nx, Ny, 4);

  for k = 1 : 4
    for i = 1 : Nx
      for j = 1 : Ny		
	if (k == 1)
	  M(i, j, k) = f(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
	elseif (k == 2)
	  M(i, j, k) = fx(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
	elseif (k == 3)
	  M(i, j, k) = fy(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
	elseif (k == 4)
	  M(i, j, k) = fxy(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
	end
      end
    end
  end
  
  L = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, 0);
  C = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, 1);

  draw (Px, Py, L, Nx, Ny, Ax, Ay, Bx, By, 0, f);
  draw (Px, Py, C, Nx, Ny, Ax, Ay, Bx, By, 1, f);

  printf("Erro Bilinear\n");

  CalcErro(f, L, Nx, Ny, Ax, Ay, Bx, By, 0,1)

  printf("\n\nErro bicúbico\n");
  CalcErro(f, C, Nx, Ny, Ax, Ay, Bx, By, 1,1)
  
end
