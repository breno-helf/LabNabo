#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

draw

Função que recebe os parametros do constroiv
e a quantidade de pontos a serem desenhados. Desenha
a função nos pontos pedidos.
#}

function draw (Qx, Qy, A, Nx, Ny, Ax, Ay, Bx, By, type, f)
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
