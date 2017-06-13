#{
Tiago Martins Napoli - 9345384
Breno Helfstein Moura - 9790972

#}

function ExperimentaErro (f, fx, fy, fxy, Nini, Ax, Bx, Ay, By)
    Bicubic = fopen("MaxErroBicubic.txt", "w");
    Bilinear = fopen("MaxErroBilinear.txt", "w");
    now = Nini
    while now < 100
        [erroBilinear, erroBicubic] = MaxErroMain(f,fx,fy,fxy,now,now,Ax,Bx,Ay,By);
        fprintf(Bicubic, "%f %f\n", (Bx-Ax)/(now), erroBicubic);
        fprintf(Bilinear, "%f %f\n", (Bx-Ax)/(now), erroBilinear);
        now = now*2;
    end
    fclose(Bilinear);
    fclose(Bicubic);
end


