#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

draw

Função que recebe os parametros do constroiv
e a quantidade de pontos a serem desenhados. Desenha
a função nos pontos pedidos.
#}

function draw (Qx, Qy, Nx, Ny, Ax, Ay, Bx, By, M, type)
  img = zeros(Qx, Qy);

  Hx = (Bx - Ax) / Qx;
  Hy = (By - Ay) / Qy;
  
  for i = 1 : Qx
    for j = 1 : Qy
      val = avaliav (Ax + (i - 1) * Hx, Ay + (j - 1) * Hy);
      img(i, j) = val;
    end
  end

  imwrite(uint8(img), 'img.png', 'Quality', 100);
end
