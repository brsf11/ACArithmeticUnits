#include "VPKA.h"
#include "verilated.h"
#include<iostream>
#include<fstream>
#include<cmath>
using namespace std;

int main(int argc, char** argv, char** env)
{
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc,argv);
    VPKA* top = new VPKA{contextp, "TOP"};

    ofstream res("data/res.mat");
    ofstream err("data/err.mat");
    ofstream ser("data/ser.mat");
    

    long long TolEr,TolSE,MaxEr,temp;
    double ME,MSE,PSNR;

    TolEr = 0;
    TolSE = 0;
    MaxEr = 0;

    int i,j,out;
    top->Cin = 0;
    for(i=0;i<256;i++)
    {
        for(j=0;j<256;j++)
        {
            top->A = i;
            top->B = j;
            top->eval();
            out = top->Cout;
            temp = top->Sum + (out << 8) - (i+j);
            TolEr += temp;
            TolSE += (temp*temp);
            if(abs(temp) > MaxEr)
            {
                MaxEr = abs(temp);
            }

            res<<(unsigned)top->Sum + (out << 8)<<" ";
            err<<temp<<" ";
            ser<<temp*temp<<" ";
        }
        res<<endl;
        err<<endl;
        ser<<endl;
    }

    ME  = (double)TolEr/65535.0L;
    MSE = (double)TolSE/65535.0L;
    PSNR = 10*log10((double)(MaxEr*MaxEr)/MSE);

    cout<<"PKA"<<endl;
    cout<<"Total Error = "<<TolEr<<endl;
    cout<<"Total SE    = "<<TolSE<<endl;
    cout<<"Max Error   = "<<MaxEr<<endl;
    cout<<"ME          = "<<ME<<endl;
    cout<<"MSE         = "<<MSE<<endl;
    cout<<"PSNR        = "<<PSNR<<endl;


    res.close();
    err.close();
    ser.close();

    delete top;
    delete contextp;
}