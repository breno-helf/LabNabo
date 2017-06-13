#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

MaxErroMain

Dada a função a ser interpolada e a malha, calcula o
Erro Máximo das interpolações bilinear e bicúbica. 

#}

function ErroAproxdf (f, fx, fy, fxy, Nx, Ny, Ax, Bx, Ay, By)

  Nx++;
  Ny++;
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);

  M = reshape (1:(Nx * Ny), Nx, Ny);

  # Monta a matriz de valores a serem passados para a constroiv
  
  for i = 1 : Nx
    for j = 1 : Ny		
      M(i, j) = f(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
    end
  end

  M;
  [dfx, dfy, d2fxy] = aproxdf (Nx, Ny, Ax, Ay, Bx, By, M);

  printf("Malha interpolada %dx%d pontos\n", Nx - 1, Ny - 1);
  
  Hx
  Hy
  
  [errox, erroy, erroxy] = CalcErro(fx, fy, fxy, dfx, dfy, d2fxy, Nx, Ny, Ax, Ay, Bx, By);
  printf("Erro %f\n%f\n%f\n", errox, erroy, erroxy);
end

function [errox, erroy, erroxy] = CalcErro (fx, fy, fxy, dfx, dfy, d2fxy, Nx, Ny, Ax, Ay, Bx, By)
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);

  errox = -1;
  erroy = -1;
  erroxy = -1;
  
  for k = 1 : 3
    for i = 2 : Nx - 1
      for j = 2 : Ny - 1
 	x = Ax + (i - 1) * Hx;
	y = Ay + (j - 1) * Hy;
	
	if (k == 1)
	  ret = dfx(i, j);
	  errox = max(errox, abs(ret - fx(x, y)));

	elseif (k == 2)
	  ret = dfy(i, j);
	  erroy = max(erroy, abs(ret - fy(x, y)));
	  
	elseif (k == 3)
	  ret = d2fxy(i, j);
	  erroxy = max(erroxy, abs(ret - fxy(x, y)));
	  
	end
      end
    end
  end
end
