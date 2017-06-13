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
    dfx(1, j) = (M(i + 1, j) - M(i, j)) / Hx;
    dfx(Nx, j) = (M(i, j) - M(i - 1, j)) / Hx;
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
    dfy(i, 1) = (M(i, j + 1) - M(i, j)) / Hy;
    dfy(i, Ny) = (M(i, j) - M(i, j - 1)) / Hy;
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
    d2fxy(i, 1) = (dfx(i, j + 1) - dfx(i, j)) / Hy;
    d2fxy(i, Ny) = (dfx(i, j) - dfx(i, j - 1)) / Hy;
  end
  
end
