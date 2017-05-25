#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

draw

Função que recebe os parametros do constroiv
e a quantidade de pontos a serem desenhados. Desenha
a função nos pontos pedidos.
#}

function main (f, fx, fy, fxy, Px, Py, type)
  Nx = 2;
  Ny = 2;
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
  
  A = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, type);
  
  Qx = (Bx - Ax) / (Px - 1);
  Qy = (By - Ay) / (Py - 1);

  erro = -1;
  
  for i = 1 : Px
    for j = 1 : Py
      x = (i - 1) * Qx + Ax;
      y = (j - 1) * Qy + Ay;
      ret = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type);
      x
      y
      ret
      f(x,y)
      printf("\n");
      erro = max(erro, abs(ret - f(x, y)));
    end
  end
  
  erro
  
end
