#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

avaliav
função que recebe as coordenadas x e y de um ponto (x, y)
em [Ax, Bx] x [Ay, By] e devolve v(x, y)
#}

function ret = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type)
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);

  I = -2;
  J = -2;

  # Os próximo loops procuram em qual subretangulo o ponto a ser
  # Interpolado se encontra.
  
  for i = 0 : Nx - 1
    if (x <= Ax + i * Hx)
      I = i - 1;
      break
    end
  end

  for j = 0 : Ny - 1 
    if (y <= Ay + j * Hy)
      J = j - 1;
      break
    end
  end

  I = max(I, 0);
  J = max(J, 0);
  Xr = (x - (Ax + I * Hx)) / Hx;
  Yr = (y - (Ay + J * Hy)) / Hy;

  if (type != 0)
    X = [1 Xr Xr ^ 2 Xr ^ 3];
    Y = [1
	 Yr
	 Yr ^ 2
	 Yr ^ 3];
  else
    X = [1 Xr];
    Y = [1
	 Yr];
  end

  ret = X * cell2mat(A(I + 1, J + 1)) * Y;
end
