#include "VSCSA_16.h"
#include "verilated.h"
#include<iostream>
#include<fstream>
#include<cmath>
#include<random>
#include<chrono>
using namespace std;
using namespace std::chrono;

#define ItrNum 10000000
#define SpNum 1000

int str2num(char* str)
{
    int num = 0;
    int i = 0;
    while(str[i] != 0)
    {
        if(str[i] >= '0' && str[i] <= '9')
        {
            num *= 10;
            num += (str[i] - '0');
        }
        i++;
    }
    return num;
}

int main(int argc, char** argv, char** env)
{
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc,argv);
    VSCSA_16* top = new VSCSA_16{contextp, "TOP"};

    ofstream res("data/res.mat");
    ofstream err("data/err.mat");
    ofstream ser("data/ser.mat");

    long long TolEr,TolSE,MaxEr,temp;
    double ME,MSE,PSNR,ERATE;

    TolEr = 0;
    TolSE = 0;
    MaxEr = 0;


    int bitwidth;
    if(argc == 1)
    {
        bitwidth = 8;
    }
    else
    {
        bitwidth = str2num(argv[1]);
    }

    if(bitwidth == 8)
    {
        long long errNumTol=0;
        cout<<"Bitwidth = 8"<<endl;
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
                temp = top->Sum + (out << 8) - (i+j) - top->Cin;
                TolEr += temp;
                TolSE += (temp*temp);
                if(abs(temp) > MaxEr)
                {
                    MaxEr = abs(temp);
                }
                if(temp != 0)
                {
                    errNumTol++;
                }

                res<<(unsigned)top->Sum + (out << 8)<<" ";
                err<<temp<<" ";
                ser<<temp*temp<<" ";
            }
            res<<endl;
            err<<endl;
            ser<<endl;

            
        }

        ME  = (double)TolEr/65536.0L;
        MSE = (double)TolSE/65536.0L;
        PSNR = 10*log10((double)(MaxEr*MaxEr)/MSE);
        ERATE = (double)errNumTol/65536.0L;

        cout<<"SCSA_16"<<endl;
        cout<<"Total Error = "<<TolEr<<endl;
        cout<<"Total SE    = "<<TolSE<<endl;
        cout<<"Max Error   = "<<MaxEr<<endl;
        cout<<"ME          = "<<ME<<endl;
        cout<<"MSE         = "<<MSE<<endl;
        cout<<"ERATE       = "<<ERATE<<endl;
        cout<<"PSNR        = "<<PSNR<<endl;
    }
    else if(bitwidth >= 16)
    {
        int sampleInt = ItrNum/SpNum;
        ofstream axsA("data/axsA.mat");
        ofstream axsB("data/axsB.mat");

        ofstream sres("data/sres.mat");
        ofstream errn("data/errn.mat");
    
        cout<<"Bitwidth = "<<bitwidth<<endl;
        typedef duration<int,ratio<1>> sec_type;
        time_point<system_clock,sec_type> before = time_point_cast<sec_type>(system_clock::now());
        
        default_random_engine random(before.time_since_epoch().count());
        uniform_int_distribution<unsigned> u_rand(0, exp2(bitwidth)-1);

        long long out,tempA,tempB,errNumTol=0;
        top->Cin = 0;

        long long errnum[33];
        double errrate[33];

        for(int i=0;i<33;i++)
        {
            errnum[i] = 0;
        }

        for(int i=0;i<ItrNum;i++)
        {
            tempA = top->A = u_rand(random);
            tempB = top->B = u_rand(random);
            top->eval();
            out = top->Cout;
            temp = top->Sum + (out << bitwidth) - (tempA+tempB) - top->Cin;
            if(temp != 0)
            {
                errNumTol++;
                errnum[(unsigned)log2(abs(temp))]++;
            }
            TolEr += temp;
            TolSE += (temp*temp);
            if(abs(temp) > MaxEr)
            {
                MaxEr = abs(temp);
            }
            if(i%sampleInt == 0)
            {
                axsA<<tempA<<" ";
                axsB<<tempB<<" ";
                sres<<(unsigned)(top->Sum + (out << bitwidth))<<" ";
            }
        }

        for(int i=0;i<33;i++)
        {
            errrate[i] = (double)errnum[i]/(double)errNumTol;
            errn<<errrate[i]<<" ";
        }

        ME  = (double)TolEr/(double)ItrNum;
        MSE = (double)TolSE/(double)ItrNum;
        PSNR = 10*log10((double)(MaxEr*MaxEr)/MSE);
        ERATE = (double)errNumTol/(double)ItrNum;

        cout<<"SCSA_16"<<endl;
        cout<<"Total Error = "<<TolEr<<endl;
        cout<<"Total SE    = "<<TolSE<<endl;
        cout<<"Max Error   = "<<MaxEr<<endl;
        cout<<"ME          = "<<ME<<endl;
        cout<<"MSE         = "<<MSE<<endl;
        cout<<"ERATE       = "<<ERATE<<endl;
        cout<<"PSNR        = "<<PSNR<<endl;
        
        time_point<system_clock,sec_type> after = time_point_cast<sec_type>(system_clock::now());
        cout<<"Time used: "<<after.time_since_epoch().count() - before.time_since_epoch().count()<<" s"<<endl;

        axsA.close();
        axsB.close();
        sres.close();
        errn.close();
    }

    res.close();
    err.close();
    ser.close();

    delete top;
    delete contextp;
}