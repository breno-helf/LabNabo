#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

arpoxdf

Função que recebe Nx, Ny, Ax, Ay, Bx, By e uma matriz com os
valores de uma função f nos pontos de malha. A função devolve
dfx, dfy, d2fxy que são as derivadas parciais da função f.
#}

function [dfx, dfy, d2fxy] = aproxdf (Nx, Ny, Ax, Ay, Bx, By, M)
  Hx = (Bx - Ax) / (Nx - 1);
  Hy = (By - Ay) / (Ny - 1);

  ## Calculating dfx
  
  dfx = reshape (1 : Nx * Ny, Nx, Ny);
  for i = 2 : Nx - 1
    for j = 1 : Ny
      dfx(i, j) = (M(i + 1, j) - M(i - 1, j)) / (2 * Hx);
    end
  end
  
  %% Casos da borda

  for j = 1 : Ny
    dfx(1, j) = (-3 * M(1,j) + 4 * M(1 + 1,j) - M(1 + 2,j))/(2 * Hx);
    dfx(Nx, j) = -(-M(Nx - 2,j) + 4 * M(Nx - 1,j) - 3*M(Nx,j))/(2 * Hx); 
  end
  
  ## Calculating dfy

  dfy = reshape (1 : Nx * Ny, Nx, Ny);
  for i = 1 : Nx
    for j = 2 : Ny - 1
      dfy(i, j) = (M(i, j + 1) - M(i, j - 1)) / (2 * Hy);
    end
  end

  %% Casos da borda

  for i = 1 : Nx
    dfy(i, 1) = (-3 * M(i,1) + 4 * M(i,1 + 1) - M(i,1 + 2))/(2 * Hy);
    dfy(i, Ny) = -(-M(i,Ny - 2) + 4 * M(i,Ny - 1) - 3 * M(i,Ny))/(2 * Hy); 
  end

  ## d2fxy

  d2fxy = reshape (1 : Nx * Ny, Nx, Ny);
  for i = 1 : Nx
    for j = 2 : Ny - 1
      d2fxy(i, j) = (dfx(i, j + 1) - dfx(i, j - 1)) / (2 * Hy);
    end
  end

  %% Casos da borda

  for i = 1 : Nx
    d2fxy(i, 1) = (-3 * dfx(i, 1) + 4 * dfx(i, 1 + 1) - dfx(i, 1 + 2)) / (2 * Hy);
    d2fxy(i, Ny) = -(-dfx(i, Ny - 2) + 4 * dfx(i, Ny - 1) - 3 * dfx(i, Ny - 2)) / (2 * Hy);
  end
  
end
