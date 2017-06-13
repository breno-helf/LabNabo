#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

DrawMain

Dado a função e a malha, faz um desenho da função original e
das compressões com bilinear e bicúbico, como pedido no
enunciado.

#}

function DrawMain (f, Px, Py, Nx, Ny, Ax, Bx, Ay, By)
  Nx++;
  Ny++;
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);
  
  M = reshape (1:(Nx * Ny * 4), Nx, Ny, 4);
  A = reshape (1 : (Nx * Ny), Nx, Ny);
  
  # Monta a matriz de valores a serem passados para a constroiv

  for i = 1 : Nx
    for j = 1 : Ny		
      A(i, j) = f(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
    end
  end

  [dfx, dfy, d2fxy] = aproxdf(Nx, Ny, Ax, Ay, Bx, By, A);

  
  for k = 1 : 4
    for i = 1 : Nx
      for j = 1 : Ny		
	if (k == 1)
	  M(i, j, k) = f(Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
	elseif (k == 2)
	  M(i, j, k) = dfx(i, j);
	elseif (k == 3)
	  M(i, j, k) = dfy(i, j);
	elseif (k == 4)
	  M(i, j, k) = d2fxy(i, j);
	end
      end
    end
  end
  
  L = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, 0);
  C = constroiv (Nx, Ny, Ax, Ay, Bx, By, M, 1);

  drawOriginal (Px, Py, Nx, Ny, Ax, Ay, Bx, By, f);
  draw (Px, Py, L, Nx, Ny, Ax, Ay, Bx, By, 0);
  draw (Px, Py, C, Nx, Ny, Ax, Ay, Bx, By, 1);
end

function drawOriginal (Qx, Qy, Nx, Ny, Ax, Ay, Bx, By,f)
  img = zeros(Qx, Qy);
  Hx = (Bx - Ax) / Qx;
  Hy = (By - Ay) / Qy;
  for i = 1 : Qx
    for j = 1 : Qy
      x = Ax + (i - 1) * Hx;
      y = Ay + (j - 1) * Hy;
      val = f (x, y);
      img(i,j) =  val;
    end
  end
  imwrite(uint8(img), 'original.png', 'Quality', 100);
end


function draw (Qx, Qy, A, Nx, Ny, Ax, Ay, Bx, By, type)
  img = zeros(Qx, Qy);
  
  Hx = (Bx - Ax) / Qx;
  Hy = (By - Ay) / Qy;
  
  for i = 1 : Qx
    for j = 1 : Qy
      x = Ax + (i - 1) * Hx;
      y = Ay + (j - 1) * Hy;
      val = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type);
      img(i, j) = val;
    end
  end
  
  if (type == 1)
    imwrite(uint8(img), 'bicubic.png', 'Quality', 100);
  else
    imwrite(uint8(img), 'bilinear.png', 'Quality', 100);
  end
end


