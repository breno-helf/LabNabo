#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

MaxErroMain

Dada a função a ser interpolada e a malha, calcula o
Erro Máximo das interpolações bilinear e bicúbica. 

#}

function [erroBilinear, erroBicubic] = MaxErroMain (f, fx, fy, fxy, Nx, Ny, Ax, Bx, Ay, By)

  Nx++;
  Ny++;
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);
  PASSO = 0.1

  M = reshape (1:(Nx * Ny * 4), Nx, Ny, 4);

  # Monta a matriz de valores a serem passados para a constroiv
  
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
  erroBicubic = CalcErro(f, C, Nx, Ny, Ax, Ay, Bx, By, 1,PASSO);
  erroBilinear = CalcErro(f, L, Nx, Ny, Ax, Ay, Bx, By, 0,PASSO);
  printf("Malha interpolada %dx%d pontos\n", Nx, Ny);
  printf("Erro Bilinear %f\n", erroBilinear);
  printf("Erro bicúbico %f\n", erroBicubic);
end

function erro = CalcErro (f, A, Nx, Ny, Ax, Ay, Bx, By, type, PASSO)
  erro = -1;
  for i = Ax : PASSO : Bx
    for j = Ay : PASSO: By
      x = i;
      y = j;
      ret = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type);
      %%printf("[%f][%f] aprox %f  real  %f  erro %f\n", x,y,ret,f(x,y), abs(ret-f(x,y)));
      erro = max(erro, abs(ret - f(x, y)));
    end
  end
end
