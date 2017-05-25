#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

CalcErro

Função que cacula o erro da interpolação

#}

function erro = CalcErro (f, A, Nx, Ny, Ax, Ay, Bx, By, type, flag)
  erro = -1;

  
  if type == 0
    B = fopen ("bilinear.txt", "w");
    K = fopen("ErroBIL.txt", "w");

  else
    B = fopen ("bicubic.txt", "w");
    K = fopen("ErroCUB.txt", "w");
  end
  
  
  for i = Ax : 0.1 : Bx
    for j = Ay : 0.1: By
      x = i;
      y = j;
      ret = avaliav (x, y, A, Nx, Ny, Ax, Ay, Bx, By, type);
      cur = abs(ret - f(x, y));
      erro = max(erro, abs(ret - f(x, y)));
      if(!flag)
	fprintf(B, "%.1f %.1f %.4f %.4f %.4f\n", i, j, f(x,y), ret, cur);	
      end
    end
    
  if flag == 1  
    fprintf(K,"%f %f\n", (Bx - Ax)/Nx, erro);
  end
  fclose(C);
  fclose(B);
end
