using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        delegate int ComputingAdd(int a, int b);
        static int add(int a,int b)
        {
            Console.WriteLine(a+b);
            return a + b;
        }
        static int sub(int a, int b)
        {
            Console.WriteLine(a-b);
            return a - b;
        }
        static event ComputingAdd EventComputing;
        static void Main(string[] args)
        {
            EventComputing += new ComputingAdd(add);
            EventComputing += new ComputingAdd(sub);

            EventComputing(6, 5);


        }
    }
}
