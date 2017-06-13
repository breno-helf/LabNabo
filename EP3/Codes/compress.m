#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

compress

Dada uma imagem a ser comprimida, comprime a imagem e interpola na
malha dada.

#}

function compress (ImgName, Nx, Ny, type)
  
  img = imread(ImgName);
  img = double(img);
  
  [a, b, c] = size(img)

  printf ("Compressão %f\n", (double((Nx * Ny))) / (double((a * b))));
  
  xEl = linspace(1, a, Nx);
  yEl = linspace(1, b, Ny);
  
  M = reshape(1 : (Nx * Ny * 4 * c), Nx, Ny, 4, c);
  A = reshape(1 : (Nx * Ny * c), Nx, Ny, c);

  for k = 1 : c
    for i = 1 : Nx
      for j = 1 : Ny
	x = xEl(i);
	y = yEl(j);      
	A(i, j, k) = img(x, y, k);
      end
    end
  end
  
  for d = 1 : c
    [dfx, dfy, d2fxy] = aproxdf(Nx, Ny, 1, 1, a, b, A(:, :, d));
    for k = 1 : 4   
      for i = 1 : Nx
	for j = 1 : Ny
	  x = xEl(i);
	  y = yEl(j);
	  
	  if (k == 2)
	    M(i, j, k, d) = dfx(i, j);
	    
	  elseif (k == 3)
	    M(i, j, k, d) = dfy(i, j);
	  
	  elseif (k == 4)
	    M(i, j, k, d) = d2fxy(i, j);
	    
	  else
	    M(i, j, k, d) = img(x, y, d);
	  end
	end
      end
    end
  end

  
  compressed = zeros(a, b, c);
  

  for k = 1 : c
    if (type == 0)
      Q = constroiv (Nx, Ny, 1, 1, a, b, M(:, :, :, k), 0);
    else
      Q = constroiv (Nx, Ny, 1, 1, a, b, M(:, :, :, k), 1);
    end
      

    for i = 1 : a
      for j = 1 : b
	ret = avaliav (i, j, Q, Nx, Ny, 1, 1, a, b, type);
	compressed(i, j, k) = ret;
      end
    end
  end

  imwrite(uint8(compressed), 'compressed.png', 'Quality', 100);  
end	  
  
