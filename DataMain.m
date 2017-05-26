#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

#}

function DataMain (f, fx, fy, fxy, Nx, Ny, Ax, Bx, Ay, By)

  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);
  PASSO = 0.1
  
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

  Calc(f, L, Nx, Ny, Ax, Ay, Bx, By, 0, PASSO);
  Calc(f, C, Nx, Ny, Ax, Ay, Bx, By, 1, PASSO);
  
end


function Calc (f, A, Nx, Ny, Ax, Ay, Bx, By, type, PASSO)
   
  if type == 0
    B = fopen ("bilinear.txt", "w");
  else
    B = fopen ("bicubic.txt", "w");
  end
  
  
  for i = Ax : PASSO : Bx
    for j = Ay : PASSO: By
      x = i;
      y = j;
      ret = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type);
      cur = abs(ret - f(x, y));
      fprintf(B, "%.1f %.1f %.4f %.4f %.4f\n", i, j, f(x,y), ret, cur);	
    end
  end
  fclose(B);
end
