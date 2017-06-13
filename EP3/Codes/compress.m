#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

compress

Dada uma imagem a ser comprimida, comprime a imagem e interpola na
malha dada.

#}

function compress (ImgName, Kx, Ky, Nx, Ny, type)
  Kx++;
  Ky++;
  
  img = imread(ImgName)(1 : Kx : end, 1 : Ky : end, :);
  imwrite(img, 'pre-interpola.png', 'Quality', 100);
  img = double(img);
  
  [a, b, c] = size(img)
  
  M = reshape (1 : (Nx * Ny * 4), Nx, Ny, 4);

  [dfx, dfy, d2fxy] = aproxdf (Nx, Ny, 1, 1, a, b, img);
  s
  for k = 1 : 4
    for i = 1 : Nx
      for j = 1 : Ny	
	if (k == 2)
	  M(i, j, k) = dfx(i, j);

	elseif (k == 3)
	  M(i, j, k) = dfy(i, j);
	  
	elseif (k == 4)
	  M(i, j, k) = d2fxy(i, j);

	else
	  M(i, j, k) = img(i, j);
	end
      end
    end
  end

  
  compressed = zeros(a, b, c);
  
  L = constroiv (Nx, Ny, 1, 1, a, b, img, 0);
  C = constroiv (Nx, Ny, 1, 1, a, b, M, 1);

  for k = 1 : c
    for i = 1 : a
  
  
  for k = 1 : c
    for i = 1 : a - 1
      for j = 1 : b - 1
	if (type == 1)
	  
  
