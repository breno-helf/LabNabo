#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

avaliav
função que recebe as coordenadas x e y de um ponto (x, y)
em [Ax, Bx] x [Ay, By] e devolve v(x, y)
#}

function avaliav (x, y)
  Hx = (Bx - Ax) / Nx;
  Hy = (By - Ay) / Ny;

  I = -1;
  J = -1;
  
  for i = 0 : Nx
    if (x <= Ax + i * Hx)
      I = i - 1;
      break
    end
  end
  for j = 0 : Ny
    if (y <= Ay + j * Hy)
      J = j - 1;
      break
    end
  end

  Xr = (x - Ax + I * Hx);
  Yr = (y - Ay + J * Hy);
  
  X = [1 Xr Xr ^ 2 Xr ^ 3];
  Y = [1
       Yr
       Yr ^ 2
       Yr ^ 3];
  
  ret = X * A * Y;
  
end
